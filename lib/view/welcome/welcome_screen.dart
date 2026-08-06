import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/core/app_constants.dart';
import 'package:pakpay/sharedwidgets/primary_button.dart';
import 'package:pakpay/view/auth/createaccount/create_account.dart';
import 'package:pakpay/view/auth/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppConstants.welcomeScreenBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 90.h),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.52),
                      blurRadius: 50.r,
                      spreadRadius: 05.r,
                      offset: Offset(0, 5.h),
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                  AppConstants.appLogoDark,
                  height: 100.h,
                  width: 100.w,
                ),
              ),
              Text(
                "PakPay",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 38.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "The future of digital finance, built for\neveryone.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10.h),
              PrimaryButton(
                text: "Login",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                width: 320.w,
              ),
              SizedBox(height: 10.h),
              PrimaryButton(
                text: "Create Account",
                buttonColor: AppColors.secondaryclr,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateAccountScreen(),
                    ),
                  );
                },
                width: 320.w,
              ),
              SizedBox(height: 10.h),
              PrimaryButton(
                text: "Register as Merchant",
                txtcolor: Colors.black,
                buttonColor: Colors.transparent,
                onPressed: () {},
                width: 320.w,
              ),
              Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "By continuing, you agree to our ",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Terms & Conditions",
                      style: TextStyle(
                        color: AppColors.primaryclr,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12.w,
                children: [
                  Icon(Icons.security, color: Colors.black45, size: 20.w),
                  Icon(
                    Icons.verified_user_outlined,
                    color: Colors.black45,
                    size: 20.w,
                  ),
                  Icon(Icons.lock_outline, color: Colors.black45, size: 20.w),
                ],
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
