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
import 'otp_screen.dart';

class VerifyMobileScreen extends StatefulWidget {
  const VerifyMobileScreen({super.key});

  @override
  State<VerifyMobileScreen> createState() => _VerifyMobileScreenState();
}

class _VerifyMobileScreenState extends State<VerifyMobileScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String _deviceToken = 'dummy_device_token';

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.06),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is OTPSentState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EnterOTPScreen(
                      mobileNumber: _phoneController.text,
                      deviceToken: _deviceToken,
                    ),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              } else if (state is LoginError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
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
                    'Login Using your mobile number',
                    style: TextStyle(
                      fontSize: AppFontSize.h1(context),
                      fontWeight: AppFontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    'Enter mobile number',
                    style: TextStyle(
                      fontSize: AppFontSize.text3(context),
                      fontWeight: AppFontWeight.regular,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      cursorColor: AppColors.primary,
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      style: TextStyle(
                        fontSize: AppFontSize.text(context),
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter mobile number',
                        hintStyle: TextStyle(
                          fontSize: AppFontSize.text3(context),
                          color: AppColors.textMuted,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: width * 0.04,
                          vertical: height * 0.02,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  CommonButton(
                    title: "Get OTP",
                    height: height * 0.065,
                    backgroundColor: AppColors.primary,
                    isLoading: state is LoginLoading,
                    textStyle: TextStyle(
                      fontSize: AppFontSize.h6(context),
                      fontWeight: AppFontWeight.semiBold,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (_phoneController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter mobile number'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      context.read<LoginBloc>().add(
                        SendOTPEvent(
                          mobileNumber: _phoneController.text,
                          deviceToken: _deviceToken,
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}