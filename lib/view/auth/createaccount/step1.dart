import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/primary_button.dart';
import 'package:pakpay/view/auth/createaccount/appbar_steps_widget.dart';
import 'package:pakpay/view/auth/createaccount/step2.dart';
import 'package:pakpay/view/auth/login_screen.dart';

class Step1Page extends StatefulWidget {
  const Step1Page({super.key});

  @override
  State<Step1Page> createState() => _Step1PageState();
}

class _Step1PageState extends State<Step1Page> {
  bool agreeTerms = false;
  bool agreePrivacy = false;

  // Reusable decoration so every field stays visually consistent
  InputDecoration _fieldDecoration({
    required String hint,
    Widget? prefixIcon,
    BoxConstraints? prefixIconConstraints,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: Colors.black,
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
      ),
      prefixIcon: prefixIcon,
      prefixIconConstraints: prefixIconConstraints,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(14.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(14.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent, width: 1.5),
        borderRadius: BorderRadius.circular(14.r),
      ),
      filled: true,
      fillColor: Color.fromARGB(255, 199, 199, 199),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StepAppBar(currentStep: 1),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.bgclr),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Text(
                'Create Your Account',
                style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10.h),
              Text(
                'Open your digital bank account in just a few minutes.',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20.h),
              // First Name / Last Name Textfields
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: _fieldDecoration(
                        hint: "First Name",
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: _fieldDecoration(hint: "Last Name"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Mobile Number with country code prefix
              IntlPhoneField(
                initialCountryCode: 'PK',
                keyboardType: TextInputType.phone,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: "Mobile Number",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 199, 199, 199),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                ),
                dropdownIcon: const Icon(Icons.keyboard_arrow_down),
                onChanged: (phone) {
                  debugPrint(phone.completeNumber);
                },
              ),
              SizedBox(height: 16.h),

              // Email Address
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
                decoration: _fieldDecoration(
                  hint: "Email Address",
                  prefixIcon: Icon(Icons.mail_outline, color: Colors.black),
                ),
              ),
              SizedBox(height: 16.h),

              // Referral Code (Optional)
              TextFormField(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
                decoration: _fieldDecoration(
                  hint: "Referral Code (Optional)",
                  prefixIcon: Icon(
                    Icons.card_giftcard_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Agreement checkboxes
              Row(
                children: [
                  SizedBox(
                    height: 24.h,
                    width: 24.w,
                    child: Checkbox(
                      value: agreeTerms,
                      activeColor: AppColors.primaryclr,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      onChanged: (value) {
                        setState(() => agreeTerms = value ?? false);
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    "I agree to the ",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Terms & Conditions",
                      style: TextStyle(
                        color: AppColors.primaryclr,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryclr,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  SizedBox(
                    height: 24.h,
                    width: 24.w,
                    child: Checkbox(
                      value: agreePrivacy,
                      activeColor: AppColors.primaryclr,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      onChanged: (value) {
                        setState(() => agreePrivacy = value ?? false);
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    "I agree to the ",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(
                        color: AppColors.primaryclr,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryclr,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.h),
              PrimaryButton(
                width: double.infinity,
                text: "Continue",
                icon: Icons.arrow_forward,
                onPressed: (agreeTerms && agreePrivacy)
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Step2Page(),
                          ),
                        );
                      }
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Please agree to the terms and privacy policy",
                            ),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        );
                      },
              ),
              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: AppColors.secondaryclr,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Sign In",
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
    );
  }
}
