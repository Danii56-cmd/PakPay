import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/core/app_constants.dart';
import 'package:pakpay/sharedwidgets/primary_button.dart';

class OnboardingScreen2 extends StatelessWidget {
  final VoidCallback? onNext;
  final VoidCallback? onSkip;

  const OnboardingScreen2({super.key, this.onNext, this.onSkip});

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
              SizedBox(height: 20.h),
              // Phone/QR illustration + floating badges
              SizedBox(
                height: 350.h,
                width: 350.w,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // Phone with QR code (base image - this is a PNG, not SVG)
                    Image.asset(
                      AppConstants.onBoarding2,
                      // height: 350.h,
                      // width: 350.w,
                    ),

                    // Chat bubble badge floating on the left
                    Positioned(
                      left: -05.w,
                      top: 160.h,
                      child: SvgPicture.asset(
                        AppConstants.onBoarding2left,
                        height: 90.h,
                        width: 90.w,
                      ),
                    ),

                    // Checkmark badge floating on the top right of QR
                    Positioned(
                      right: 05.w,
                      top: 90.h,
                      child: SvgPicture.asset(
                        AppConstants.onBoarding2right,
                        height: 90.h,
                        width: 90.w,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                "Scan & Pay",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                "Pay merchants and friends instantly\nwith QR technology.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600], fontSize: 15.sp),
              ),
              Spacer(),
              PrimaryButton(
                width: 320.w,
                text: "Next",
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
