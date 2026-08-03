import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/core/app_constants.dart';
import 'package:pakpay/sharedwidgets/primary_button.dart';

class IdentityVerificationScreen extends StatelessWidget {
  const IdentityVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2.r,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryclr),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Identity Verification",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.bgclr),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h),

                // Face scan with glowing ring
                Stack(
                  children: [
                    Container(
                      width: 300.w,
                      height: 300.h,
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: ClipOval(
                          child: Image.asset(
                            AppConstants.identityVerify,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 110,
                      left: 130,
                      child: Icon(
                        Icons.camera_enhance,
                        color: Colors.white,
                        size: 70.w,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Position your face within the frame",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Ensure good lighting and avoid wearing\nglasses or hats for the best result.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade500,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 24.h),

                // Info card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44.w,
                        height: 44.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          Icons.face_retouching_natural,
                          color: Colors.grey.shade400,
                          size: 22.w,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                            children: [
                              const TextSpan(
                                text: "Secure verification powered by ",
                              ),
                              TextSpan(
                                text: "PakPay AI",
                                style: TextStyle(
                                  color: AppColors.primaryclr,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const TextSpan(
                                text:
                                    ". Your biometric data is encrypted and never stored locally.",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 28.h),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey.shade200,
                ),
                SizedBox(height: 20.h),

                PrimaryButton(text: "Continue", width: 320.w, onPressed: () {}),

                SizedBox(height: 18.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.refresh,
                            size: 16.w,
                            color: AppColors.secondaryclr,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "Take Again",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryclr,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.help_outline,
                            size: 16.w,
                            color: Colors.black54,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "Need Help?",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
