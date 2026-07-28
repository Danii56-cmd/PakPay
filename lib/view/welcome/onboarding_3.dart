import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/core/app_constants.dart';
import 'package:pakpay/sharedwidgets/primary_button.dart';

class OnboardingScreen3 extends StatelessWidget {
  final VoidCallback? onNext;
  final VoidCallback? onSkip;

  const OnboardingScreen3({super.key, this.onNext, this.onSkip});

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
              // Base illustration + floating security badges
              SizedBox(
                height: 300.h,
                width: 300.w,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // Base image (phone / lock illustration)
                    Image.asset(AppConstants.onBoarding3main),
                    // Small circular badge floating top-left
                    Positioned(
                      left: 20.w,
                      top: 20.h,
                      child: SvgPicture.asset(
                        AppConstants.onBoarding3face,
                        height: 120.h,
                        width: 120.w,
                      ),
                    ),

                    // Larger circular badge floating bottom-right (fingerprint)
                    Positioned(
                      right: 15.w,
                      bottom: 10.w,
                      child: SvgPicture.asset(
                        AppConstants.onBoarding3bio,
                        height: 170.h,
                        width: 170.w,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                "Safe & Secure",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                "Your finances are protected by bank-grade\nencryption and biometric security.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600], fontSize: 15.sp),
              ),
              Spacer(),
              PrimaryButton(
                width: 320.w,
                text: "Get Started",
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

// /// Small reusable white circle badge used for the floating
// /// security icons on the "Safe & Secure" onboarding screen.
// class _CircleBadge extends StatelessWidget {
//   final double size;
//   final double iconSize;
//   final String asset;

//   const _CircleBadge({
//     required this.size,
//     required this.iconSize,
//     required this.asset,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: size,
//       width: size,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         shape: BoxShape.circle,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.08),
//             blurRadius: 12.r,
//             spreadRadius: 1.r,
//             offset: Offset(0, 4.h),
//           ),
//         ],
//       ),
//       child: Center(
//         child: SvgPicture.asset(asset, height: iconSize, width: iconSize),
//       ),
//     );
//   }
// }
