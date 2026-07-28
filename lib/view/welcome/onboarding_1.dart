import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/core/app_constants.dart';
import 'package:pakpay/sharedwidgets/primary_button.dart';

class OnboardingScreen1 extends StatelessWidget {
  final VoidCallback? onNext;
  final VoidCallback? onSkip;

  const OnboardingScreen1({super.key, this.onNext, this.onSkip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: onSkip,
            child: Text(
              "Skip",
              style: TextStyle(
                color: const Color.fromARGB(255, 65, 95, 141),
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: 16.w),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.bgclr),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                AppConstants.onBoarding1,
                height: 300.h,
                width: 300.w,
              ),
              Text(
                "Welcome to PakPay",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "Secure Digital Banking",
                style: TextStyle(color: Colors.black87, fontSize: 15.sp),
              ),
              SizedBox(height: 20.h),
              Text(
                "Experience the future of financial freedom\nwith our encrypted, lightning-fast\npayment ecosystem.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600], fontSize: 15.sp),
              ),
              Spacer(),
              PrimaryButton(
                width: 320.w,
                text: "Next",
                textColor: Colors.white,
                icon: Icons.arrow_forward,
                onPressed: onNext ?? () {},
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
