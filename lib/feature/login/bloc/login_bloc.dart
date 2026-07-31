import 'package:bloc/bloc.dart';
import '../../../utils/secure_storage.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../repository/login_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;
  final SecureStorageService _secureStorageService;

  // Held in memory only, between sending an OTP and verifying it. Nothing is
  // persisted until the OTP actually matches, otherwise merely requesting an
  // OTP would leave the user permanently signed in.
  LoginResponse? _pendingLogin;

  LoginBloc({
    required LoginRepository loginRepository,
    required SecureStorageService secureStorageService,
  })  : _loginRepository = loginRepository,
        _secureStorageService = secureStorageService,
        super(LoginInitial()) {
    on<SendOTPEvent>(_onSendOTP);
    on<VerifyOTPEvent>(_onVerifyOTP);
    on<ResendOTPEvent>(_onResendOTP);
    on<LogoutEvent>(_onLogout);
    on<CheckLoginStatusEvent>(_onCheckLoginStatus);
  }

  Future<void> _onSendOTP(
      SendOTPEvent event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading());
    try {
      final request = LoginRequest(
        mobileNumber: event.mobileNumber,
        deviceToken: event.deviceToken,
      );

      final response = await _loginRepository.login(request);

      if (response.code == '200' || response.code == 'success' || response.code == '1') {
        // Hold the response until the OTP is verified.
        _pendingLogin = response;
        emit(OTPSentState(message: response.message.isEmpty ? 'OTP sent successfully' : response.message));
      } else {
        emit(LoginError(message: response.message.isEmpty ? 'Failed to send OTP' : response.message));
      }
    } catch (e) {
      emit(LoginError(message: 'Failed to send OTP. Please check your network connection and try again.'));
    }
  }

  Future<void> _onVerifyOTP(
      VerifyOTPEvent event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading());
    try {
      // The pending response from the OTP request, not yet persisted.
      final userData = _pendingLogin;

      if (userData != null && userData.otp == event.otp) {
        // OTP matched: only now does the session become persistent.
        await _secureStorageService.storeLoginResponse(userData);
        _pendingLogin = null;
        emit(OTPVerifiedState(loginResponse: userData));
        emit(LoggedInState(userData: userData));
      } else {
        emit(LoginError(message: 'Invalid OTP. Please try again.'));
      }
    } catch (e) {
      emit(LoginError(message: 'Failed to verify OTP. Please try again.'));
    }
  }

  Future<void> _onResendOTP(
      ResendOTPEvent event,
      Emitter<LoginState> emit,
      ) async {
    emit(LoginLoading());
    try {
      final request = LoginRequest(
        mobileNumber: event.mobileNumber,
        deviceToken: event.deviceToken,
      );

      final response = await _loginRepository.login(request);

      if (response.code == '200' || response.code == 'success' || response.code == '1') {
        _pendingLogin = response;
        emit(OTPSentState(message: 'OTP resent successfully'));
      } else {
        emit(LoginError(message: response.message.isEmpty ? 'Failed to resend OTP' : response.message));
      }
    } catch (e) {
      emit(LoginError(message: 'Failed to resend OTP. Please try again.'));
    }
  }

  Future<void> _onLogout(
      LogoutEvent event,
      Emitter<LoginState> emit,
      ) async {
    try {
      _pendingLogin = null;
      await _secureStorageService.clearAll();
      emit(LoggedOutState());
    } catch (e) {
      emit(LoginError(message: 'Failed to logout. Please try again.'));
    }
  }

  Future<void> _onCheckLoginStatus(
      CheckLoginStatusEvent event,
      Emitter<LoginState> emit,
      ) async {
    try {
      final isLoggedIn = await _secureStorageService.isLoggedIn();
      if (isLoggedIn) {
        final userData = await _secureStorageService.getUserData();
        if (userData != null && userData.accessToken != null) {
          emit(LoggedInState(userData: userData));
        } else {
          await _secureStorageService.clearAll();
          emit(LoggedOutState());
        }
      } else {
        emit(LoggedOutState());
      }
    } catch (e) {
      emit(LoggedOutState());
    }
  }
}