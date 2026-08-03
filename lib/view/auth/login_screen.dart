import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/primary_button.dart';
import 'package:pakpay/view/auth/createaccount/step1.dart';
import 'package:pakpay/view/dashboard_screens.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: AppColors.primaryclr,
        backgroundColor: Color.fromARGB(255, 248, 249, 255),
        elevation: 0.r,
        title: Text(
          'PakPay',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.bgclr),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Securely login to your PakPay account',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryclr,
                  ),
                ),
                SizedBox(height: 20.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mobile Number or Email",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: "e.g. +92 300 1234567",
                        hintStyle: TextStyle(
                          color: Colors.black38,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        suffixIcon: Icon(
                          Icons.person_outline,
                          color: Colors.black26,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        filled: true,
                        fillColor: AppColors.txtfieldclr,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "Password",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: "***************",
                        hintStyle: TextStyle(
                          color: Colors.black38,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        suffixIcon: Icon(
                          Icons.visibility_outlined,
                          color: Colors.black26,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        filled: true,
                        fillColor: AppColors.txtfieldclr,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Switch(
                      value: false,
                      onChanged: (value) {},
                      activeThumbColor: Colors.white,
                      activeTrackColor: AppColors.txtfieldclr,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: AppColors.txtfieldclr,
                      trackOutlineColor: WidgetStateProperty.all(
                        Colors.transparent,
                      ),
                    ),
                    Text(
                      "Remember Me",
                      style: TextStyle(
                        color: AppColors.secondaryclr,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: AppColors.primaryclr,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                PrimaryButton(
                  width: 320.w,
                  text: "Login",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(color: Colors.black12, thickness: 1),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        "Or Secure Access",
                        style: TextStyle(
                          color: AppColors.secondaryclr,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: Colors.black12, thickness: 1),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                PrimaryButton(
                  icon: Icons.fingerprint,
                  text: "Continue with Biometrics",
                  iconOnLeft: true,
                  width: 320.w,
                  backgroundColor: Colors.transparent,
                  textColor: AppColors.secondaryclr,
                  borderColor: AppColors.secondaryclr,
                  onPressed: () {},
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: AppColors.secondaryclr,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Step1Page(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: AppColors.primaryclr,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
