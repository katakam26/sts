// lib/features/auth/pages/otp_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_font_size.dart';
import '../../../utils/app_font_weight.dart';
import '../../../widgets/app_logo.dart';
import '../../../widgets/common_button.dart';
import '../../navigation/bottom_nav.dart';

class EnterOTPScreen extends StatefulWidget {
  final String mobileNumber;
  final String deviceToken;

  const EnterOTPScreen({
    super.key,
    required this.mobileNumber,
    required this.deviceToken,
  });

  @override
  State<EnterOTPScreen> createState() => _EnterOTPScreenState();
}

class _EnterOTPScreenState extends State<EnterOTPScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
        (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6,
        (_) => FocusNode(),
  );

  int _secondsRemaining = 30;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = 30;
      _canResend = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_secondsRemaining > 0) {
            _secondsRemaining--;
          } else {
            _canResend = true;
            _timer?.cancel();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  String get _otp => _otpControllers.map((c) => c.text).join();

  String _maskPhoneNumber(String mobileNumber) {
    if (mobileNumber.length <= 4) return mobileNumber;
    return '${mobileNumber.substring(0, 2)}******${mobileNumber.substring(mobileNumber.length - 2)}';
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is OTPVerifiedState) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MainBottomNav(),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Login successful! Welcome ${state.loginResponse.firstName}'),
                    ),
                  );
                } else if (state is LoginError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is OTPSentState) {
                  _startTimer();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.08),
                    const Center(child: AppLogo()),
                    SizedBox(height: height * 0.06),
                    Text(
                      'Enter OTP',
                      style: TextStyle(
                        fontSize: AppFontSize.h1(context),
                        fontWeight: AppFontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    RichText(
                      text: TextSpan(
                        text: 'Verification code has been sent to ',
                        style: TextStyle(
                          fontSize: AppFontSize.text3(context),
                          fontWeight: AppFontWeight.regular,
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: '+91 ${_maskPhoneNumber(widget.mobileNumber)}',
                            style: TextStyle(
                              fontSize: AppFontSize.text2(context),
                              fontWeight: AppFontWeight.semiBold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        5,
                            (index) => Container(
                          width: width * 0.12,
                          height: width * 0.14,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _focusNodes[index].hasFocus 
                                  ? AppColors.primary 
                                  : AppColors.cardBorder,
                              width: 1.5,
                            ),
                            boxShadow: [
                              if (_focusNodes[index].hasFocus)
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.1),
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                ),
                            ],
                          ),
                          child: TextField(
                            cursorColor: AppColors.primary,
                            controller: _otpControllers[index],
                            focusNode: _focusNodes[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            autofocus: index == 0,
                            maxLength: 1,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: TextStyle(
                              fontSize: AppFontSize.h4(context),
                              fontWeight: AppFontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              counterText: '',
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                HapticFeedback.selectionClick();
                              }
                              _onOtpChanged(value, index);
                              setState(() {}); // Rebuild to update border color
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.04),
                    CommonButton(
                      title: "Verify OTP",
                      height: height * 0.065,
                      backgroundColor: AppColors.primary,
                      isLoading: state is LoginLoading,
                      textStyle: TextStyle(
                        fontSize: AppFontSize.h6(context),
                        fontWeight: AppFontWeight.semiBold,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (_otp.length < 5) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter all 5 digits'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        context.read<LoginBloc>().add(
                          VerifyOTPEvent(
                            mobileNumber: widget.mobileNumber,
                            otp: _otp,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: height * 0.025),
                    Center(
                      child: Column(
                        children: [
                          if (!_canResend)
                            Text(
                              "Resend OTP in 00:${_secondsRemaining.toString().padLeft(2, '0')}",
                              style: TextStyle(
                                fontSize: AppFontSize.text3(context),
                                fontWeight: AppFontWeight.regular,
                                color: AppColors.textSecondary,
                              ),
                            )
                          else
                            RichText(
                              text: TextSpan(
                                text: "Didn't get the OTP? ",
                                style: TextStyle(
                                  fontSize: AppFontSize.text3(context),
                                  fontWeight: AppFontWeight.regular,
                                  color: AppColors.textSecondary,
                                ),
                                children: [
                                  WidgetSpan(
                                    child: GestureDetector(
                                      onTap: state is LoginLoading
                                          ? null
                                          : () {
                                        context.read<LoginBloc>().add(
                                          ResendOTPEvent(
                                            mobileNumber: widget.mobileNumber,
                                            deviceToken: widget.deviceToken,
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Resend',
                                        style: TextStyle(
                                          fontSize: AppFontSize.text3(context),
                                          fontWeight: AppFontWeight.semiBold,
                                          color: state is LoginLoading
                                              ? Colors.grey
                                              : AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.04),
                    Center(
                      child: TextButton(
                        onPressed: state is LoginLoading ? null : () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Change Number',
                          style: TextStyle(
                            fontSize: AppFontSize.text3(context),
                            fontWeight: AppFontWeight.semiBold,
                            color: state is LoginLoading
                                ? Colors.grey
                                : AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
