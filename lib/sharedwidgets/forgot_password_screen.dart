import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/primary_button.dart';
import 'package:pakpay/sharedwidgets/reusbale_textfiel.dart';
import 'package:pakpay/view/otpscreens/otp_verification_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _identifierController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _identifierController.dispose();
    super.dispose();
  }

  bool get _canSubmit => _identifierController.text.trim().isNotEmpty;

  Future<void> _onSendOtp() async {
    if (!_canSubmit) return;
    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    // Replace with actual API call to request OTP
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            OtpVerificationScreen(contact: _identifierController.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primaryclr,
            size: 22.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'PakPay',
          style: TextStyle(
            color: AppColors.primaryclr,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.bgclr),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40.h),

                // Icon avatar
                Container(
                  width: 90.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(50.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.lock_reset_outlined,
                    size: 46.w,
                    color: AppColors.primaryclr,
                  ),
                ),
                SizedBox(height: 32.h),

                Text(
                  'Forgot Password?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Enter your email or mobile number to receive\na 6-digit verification code.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 32.h),

                AppTextField(
                  hint: 'Email or Mobile Number',
                  controller: _identifierController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (_) => setState(() {}),
                ),
                SizedBox(height: 24.h),

                PrimaryButton(
                  text: _isLoading ? 'Sending...' : 'Send OTP',
                  icon: _isLoading ? null : Icons.arrow_forward,
                  onPressed: (_canSubmit && !_isLoading) ? _onSendOtp : null,
                ),
                SizedBox(height: 16.h),

                Center(
                  child: TextButton(
                    onPressed: () {
                      // Navigate to alternate recovery method
                    },
                    child: Text(
                      'Try another way',
                      style: TextStyle(
                        color: AppColors.primaryclr,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 80.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Remembered your password? ',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: AppColors.primaryclr,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
