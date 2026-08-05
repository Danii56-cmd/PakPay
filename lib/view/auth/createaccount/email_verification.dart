import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/illustration_circle.dart';
import 'package:pakpay/sharedwidgets/pill_status_badge.dart';
import 'package:pakpay/sharedwidgets/primary_button.dart';
import 'package:pakpay/Models/user_model.dart';
import 'package:pakpay/view/auth/createaccount/appbar_steps_widget.dart';
import 'package:pakpay/view/auth/createaccount/identity_verification.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key, required this.user});

  final UserModel user;

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  static const _resendSeconds = 58;

  Timer? _timer;
  int _secondsLeft = _resendSeconds;

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
    // TODO: trigger the actual resend-verification-email API call here.
    _startTimer();
  }

  void _handleCheckInbox() {
    // TODO: replace with your actual inbox / mail-app deep link.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IdentityVerificationScreen(user: widget.user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StepAppBar(currentStep: 6),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgclr),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  'Email Verification',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20.h),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const IllustrationCircle(
                    icon: Icons.mark_email_read_outlined,
                    showBadge: true,
                  ),
                ),
                SizedBox(height: 26.h),

                Text(
                  'Verify Your Email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "We've sent a verification link to your email address. Please click the link to secure your account.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 24.h),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 18.h,
                    horizontal: 16.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'VERIFICATION SENT TO',
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.6,
                          color: Colors.black45,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              widget.user.email,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryclr,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          GestureDetector(
                            onTap: () => Navigator.maybePop(context),
                            child: Icon(
                              Icons.edit_outlined,
                              size: 16.sp,
                              color: AppColors.secondaryclr,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                const PillStatusBadge(
                  icon: Icons.check_circle_outline,
                  text: 'Email sent successfully',
                ),
                SizedBox(height: 24.h),

                PrimaryButton(
                  width: double.infinity,
                  text: 'Check Inbox',
                  icon: Icons.mail_outline,
                  onPressed: _handleCheckInbox,
                ),
                SizedBox(height: 18.h),

                GestureDetector(
                  onTap: _handleResend,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.refresh,
                        size: 15.sp,
                        color: _secondsLeft > 0
                            ? Colors.black38
                            : AppColors.primaryclr,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Resend Email',
                        style: TextStyle(
                          color: _secondsLeft > 0
                              ? Colors.black38
                              : AppColors.primaryclr,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  _secondsLeft > 0
                      ? 'Resend available in ${_secondsLeft}s'
                      : 'You can resend now',
                  style: TextStyle(fontSize: 12.5.sp, color: Colors.black45),
                ),
                SizedBox(height: 30.h),

                Divider(color: Colors.grey.shade300, height: 1),
                SizedBox(height: 14.h),
                Text(
                  'SECURE FINTECH ARCHITECTURE BY PAKPAY',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10.5.sp,
                    letterSpacing: 0.6,
                    fontWeight: FontWeight.w500,
                    color: Colors.black38,
                  ),
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
