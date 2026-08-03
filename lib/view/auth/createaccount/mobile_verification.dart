import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/core/app_constants.dart';
import 'package:pakpay/sharedwidgets/primary_button.dart';
import 'package:pakpay/view/auth/createaccount/appbar_steps_widget.dart';
import 'package:pakpay/view/auth/createaccount/email_verification.dart';
import 'package:pinput/pinput.dart';

class MobileVerificationScreen extends StatelessWidget {
  const MobileVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StepAppBar(currentStep: 5),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.bgclr),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 40.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(AppConstants.step5),
                      Text(
                        "Verify Mobile Number",
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "We've sent a 6-digit code to +92 300\n•••••••. Enter it below to continue.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "Change Number",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryclr,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Pinput(
                        length: 6,
                        keyboardType: TextInputType.number,
                        defaultPinTheme: PinTheme(
                          width: 52.w,
                          height: 58.h,
                          textStyle: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: 52.w,
                          height: 58.h,
                          textStyle: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.primaryclr,
                              width: 2,
                            ),
                          ),
                        ),
                        onCompleted: (pin) {
                          print(pin);
                        },
                      ),
                      SizedBox(height: 30.h),
                      Container(
                        height: 40.h,
                        width: 300,
                        decoration: BoxDecoration(
                          color: AppColors.primaryclr.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.security,
                              color: Colors.green[800],
                              size: 20.w,
                            ),
                            Text(
                              "Automatic OTP detection is active.",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Resend Code in ",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryclr,
                            ),
                          ),
                          Text(
                            "00:45",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Resend OTP",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryclr,
                        ),
                      ),
                      // Fixed spacing instead of Spacer() — Spacer needs a
                      // bounded parent, which SingleChildScrollView doesn't give.
                      SizedBox(height: 40.h),
                      PrimaryButton(
                        text: "Continue",
                        width: 320.w,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EmailVerificationPage(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
