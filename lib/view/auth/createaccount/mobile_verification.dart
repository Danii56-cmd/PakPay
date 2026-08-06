import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/illustration_circle.dart';
import 'package:pakpay/sharedwidgets/input_otp.dart';
import 'package:pakpay/sharedwidgets/pill_status_badge.dart';
import 'package:pakpay/sharedwidgets/primary_button.dart';
import 'package:pakpay/Models/user_model.dart';
import 'package:pakpay/view/auth/createaccount/appbar_steps_widget.dart';
import 'package:pakpay/view/auth/createaccount/email_verification.dart';

class MobileVerificationScreen extends StatefulWidget {
  const MobileVerificationScreen({super.key, required this.user});

  final UserModel user;

  @override
  State<MobileVerificationScreen> createState() =>
      _MobileVerificationScreenState();
}

class _MobileVerificationScreenState extends State<MobileVerificationScreen> {
  static const _resendSeconds = 45;

  Timer? _timer;
  int _secondsLeft = _resendSeconds;
  String _code = '';

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _secondsLeft = _resendSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 1) {
        timer.cancel();
        setState(() => _secondsLeft = 0);
      } else {
        setState(() => _secondsLeft -= 1);
      }
    });
  }

  void _handleResend() {
    if (_secondsLeft > 0) return;
    //  Trigger the actual resend-OTP API call here.
    _startTimer();
  }

  void _handleContinue() {
    if (_code.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please enter the 6-digit code"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmailVerificationScreen(user: widget.user),
      ),
    );
  }

  String get _maskedPhone {
    final phone = widget.user.phone;
    if (phone.length <= 6) return phone;
    final visible = phone.substring(0, phone.length - 6);
    return '$visible ${'●' * 6}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StepAppBar(currentStep: 5),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgclr),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 30.h),
                const IllustrationCircle(
                  icon: Icons.smartphone_outlined,
                  showBadge: true,
                ),
                SizedBox(height: 30.h),
                Text(
                  'Verify Mobile Number',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12.h),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                    children: [
                      const TextSpan(text: "We've sent a 6-digit code to "),
                      TextSpan(
                        text: _maskedPhone,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const TextSpan(text: '. Enter it below to continue.'),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: () => Navigator.maybePop(context),
                  child: Text(
                    'Change Number',
                    style: TextStyle(
                      color: AppColors.primaryclr,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 28.h),

                OtpInputRow(
                  length: 6,
                  onChanged: (code) => _code = code,
                  onCompleted: (code) => setState(() => _code = code),
                ),
                SizedBox(height: 20.h),

                const PillStatusBadge(
                  icon: Icons.verified_user_outlined,
                  text: 'Automatic OTP detection is active.',
                ),
                SizedBox(height: 20.h),

                if (_secondsLeft > 0)
                  Text.rich(
                    TextSpan(
                      style: TextStyle(fontSize: 13.sp, color: Colors.black54),
                      children: [
                        const TextSpan(text: 'Resend code in '),
                        TextSpan(
                          text: '00:${_secondsLeft.toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  GestureDetector(
                    onTap: _handleResend,
                    child: Text(
                      'Resend OTP',
                      style: TextStyle(
                        color: AppColors.primaryclr,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                SizedBox(height: 40.h),

                PrimaryButton(
                  width: double.infinity,
                  text: 'Continue',
                  onPressed: _handleContinue,
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
