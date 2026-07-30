import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/core/app_constants.dart';
import 'package:pakpay/view/welcome/onboarding_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingMain()),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.bgsplash),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 178, 160, 0.2),
                      blurRadius: 50.r,
                      spreadRadius: 02.r,
                      // offset: Offset(0, 0.3.h),
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                  AppConstants.appLogo,
                  height: 150.h,
                  width: 150.w,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Pak',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextSpan(
                      text: 'Pay',
                      style: TextStyle(
                        color: AppColors.primaryclr,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "SECURE  FUTURE",
                style: TextStyle(color: Colors.grey[700], letterSpacing: 1.0),
              ),
              Spacer(),
              CircularProgressIndicator(
                color: AppColors.primaryclr,
                backgroundColor: AppColors.primaryclr.withValues(alpha: 0.15),
              ),
              SizedBox(height: 20.h),
              Text(
                "Initializing Secure Connection...",
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 80.h),
            ],
          ),
        ),
      ),
    );
  }
}
