import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

// Event for sending OTP
class SendOTPEvent extends LoginEvent {
  final String mobileNumber;
  final String deviceToken;

  const SendOTPEvent({
    required this.mobileNumber,
    required this.deviceToken,
  });

  @override
  List<Object?> get props => [mobileNumber, deviceToken];
}

// Event for verifying OTP
class VerifyOTPEvent extends LoginEvent {
  final String mobileNumber;
  final String otp;

  const VerifyOTPEvent({
    required this.mobileNumber,
    required this.otp,
  });

  @override
  List<Object?> get props => [mobileNumber, otp];
}

// Event for resending OTP
class ResendOTPEvent extends LoginEvent {
  final String mobileNumber;
  final String deviceToken;

  const ResendOTPEvent({
    required this.mobileNumber,
    required this.deviceToken,
  });

  @override
  List<Object?> get props => [mobileNumber, deviceToken];
}

// Event for logout
class LogoutEvent extends LoginEvent {}

// Event for checking login status
class CheckLoginStatusEvent extends LoginEvent {}