import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/core/app_constants.dart';
import 'package:pakpay/sharedwidgets/primary_button.dart';
import 'package:pakpay/utills/pakistan_locations.dart';
import 'package:pakpay/view/auth/createaccount/appbar_steps_widget.dart';
import 'package:pakpay/view/auth/createaccount/employement_income.dart';
import 'package:pakpay/view/auth/login_screen.dart';

class AddressDetailsScreen extends StatefulWidget {
  const AddressDetailsScreen({super.key});

  @override
  State<AddressDetailsScreen> createState() => _AddressDetailsScreenState();
}

class _AddressDetailsScreenState extends State<AddressDetailsScreen> {
  String? selectedProvince;
  String? selectedCity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StepAppBar(currentStep: 3),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.bgclr),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 20.h),
              Text(
                "Address Details",
                style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10.h),
              Text(
                'Please provide your current residential address for account verification.',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: Colors.grey.shade50, width: 1.w),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Province label
                    Text(
                      "Province",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryclr,
                      ),
                    ),
                    SizedBox(height: 6.h),

                    // Province dropdown
                    DropdownButtonFormField<String>(
                      initialValue: selectedProvince,
                      isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.primaryclr,
                      ),
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      hint: Text(
                        "Select your province",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.txtfieldclr,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1.w,
                          ),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1.w,
                          ),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryclr,
                            width: 1.5.w,
                          ),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      items: PakistanLocations.provinces
                          .map(
                            (province) => DropdownMenuItem(
                              value: province,
                              child: Text(
                                province,
                                style: TextStyle(fontSize: 15.sp),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedProvince = value;
                          selectedCity = null;
                        });
                      },
                    ),
                    SizedBox(height: 15.h),
                    // City label
                    Text(
                      "City",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryclr,
                      ),
                    ),
                    SizedBox(height: 6.h),

                    // City dropdown
                    DropdownButtonFormField<String>(
                      initialValue: selectedCity,
                      isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: selectedProvince == null
                            ? Colors.grey.shade400
                            : AppColors.primaryclr,
                      ),
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      hint: Text(
                        selectedProvince == null
                            ? "Select province first"
                            : "Select your city",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: selectedProvince == null
                            ? Colors.grey.shade100
                            : AppColors.txtfieldclr,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1.w,
                          ),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1.w,
                          ),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1.w,
                          ),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryclr,
                            width: 1.5.w,
                          ),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        helperText: selectedProvince == null
                            ? "Please select a province first"
                            : null,
                        helperStyle: TextStyle(
                          color: Colors.orange.shade700,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      items: selectedProvince == null
                          ? [
                              DropdownMenuItem(
                                value: null,
                                enabled: false,
                                child: Text(
                                  "Please select a province first",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ),
                            ]
                          : PakistanLocations.citiesFor(selectedProvince)
                                .map(
                                  (city) => DropdownMenuItem(
                                    value: city,
                                    child: Text(
                                      city,
                                      style: TextStyle(fontSize: 15.sp),
                                    ),
                                  ),
                                )
                                .toList(),
                      onChanged: selectedProvince == null
                          ? null
                          : (value) {
                              setState(() {
                                selectedCity = value;
                              });
                            },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(20),
                height: 320.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Residential\nAddress",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryclr,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TextFormField(
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText:
                            "Enter your full address (House #, Street...)",
                        hintStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        filled: true,
                        fillColor: AppColors.txtfieldclr.withValues(alpha: .3),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide: BorderSide(
                            color: Colors.grey.shade50,
                            width: 1.w,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1.w,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.5.w,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 95.h,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryclr.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: AppColors.primaryclr.withValues(alpha: 0.2),
                            width: 1.w,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 50.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                color: AppColors.primaryclr,
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                                size: 25.sp,
                              ),
                            ),
                            SizedBox(width: 14.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Locate on Map",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryclr,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "Tap to pick your location\nautomatically",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: AppColors.primaryclr,
                              size: 26.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(20),
                height: 150.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Postal Code (Optional)",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryclr,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: "e.g. 24640",
                        hintStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        filled: true,
                        fillColor: AppColors.txtfieldclr.withValues(alpha: .2),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide: BorderSide(
                            color: Colors.grey.shade100,
                            width: 1.w,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.r),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.5.w,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Image.asset(
                AppConstants.mapPreview,
                height: 150.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryButton(
                text: "Continue",
                icon: Icons.arrow_forward,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmployementIncomeScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 10.h),
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
            ],
          ),
        ),
      ),
    );
  }
}
