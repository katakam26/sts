import 'package:equatable/equatable.dart';

import '../models/login_response.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

// Initial state
class LoginInitial extends LoginState {}

// Loading state (for both OTP send and verification)
class LoginLoading extends LoginState {}

// OTP sent successfully
class OTPSentState extends LoginState {
  final String message;

  const OTPSentState({required this.message});

  @override
  List<Object?> get props => [message];
}

// OTP verified successfully
class OTPVerifiedState extends LoginState {
  final LoginResponse loginResponse;

  const OTPVerifiedState({required this.loginResponse});

  @override
  List<Object?> get props => [loginResponse];
}

// Logged in state
class LoggedInState extends LoginState {
  final LoginResponse userData;

  const LoggedInState({required this.userData});

  @override
  List<Object?> get props => [userData];
}

// Logged out state
class LoggedOutState extends LoginState {}

// Error state
class LoginError extends LoginState {
  final String message;

  const LoginError({required this.message});

  @override
  List<Object?> get props => [message];
}