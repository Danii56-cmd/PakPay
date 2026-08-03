import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/core/app_constants.dart';
import 'package:pakpay/sharedwidgets/primary_button.dart';
import 'package:pakpay/view/auth/createaccount/appbar_steps_widget.dart';
import 'package:pakpay/view/auth/createaccount/identity_verification.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StepAppBar(currentStep: 6),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.bgclr),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Email Verification",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  width: 220.w,
                  height: 220.h,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        AppConstants.emailVerification,
                        width: 220.w,
                        height: 220.h,
                        fit: BoxFit.contain,
                      ),
                      Positioned(
                        bottom: 4.h,
                        right: 4.w,
                        child: Container(
                          height: 40.h,
                          width: 35.w,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryclr,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 18.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),
                Text(
                  "Verify Your Email",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "We've sent a verification link to your\nemail address. Please click the link to\nsecure your account.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 24.h),

                // Verification sent to card
                Container(
                  width: 270.w,
                  padding: EdgeInsets.symmetric(
                    vertical: 14.h,
                    horizontal: 16.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "VERIFICATION SENT TO",
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.6,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              "user@example.com",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryclr,
                              ),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Icon(
                            Icons.edit_outlined,
                            size: 16.w,
                            color: Colors.grey.shade600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                // Success Container
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 16.w,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryclr.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle_outline_outlined,
                        color: AppColors.primaryclr,
                        size: 16.w,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        "Email sent successfully",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryclr,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),

                PrimaryButton(
                  text: "Check Inbox",
                  width: 320.w,
                  icon: Icons.mail_outline,
                  iconOnLeft: true,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const IdentityVerificationScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.refresh,
                      size: 16.w,
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      "Resend Email",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  "Resend available in 58s",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black45,
                  ),
                ),

                SizedBox(height: 24.h),
                Container(width: 40.w, height: 1, color: Colors.grey.shade400),
                SizedBox(height: 12.h),
                Text(
                  "SECURE FINTECH ARCHITECTURE BY PAKPAY",
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.8,
                    color: Colors.grey.shade400,
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
