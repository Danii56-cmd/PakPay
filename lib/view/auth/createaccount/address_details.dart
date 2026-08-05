import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/core/app_constants.dart';
import 'package:pakpay/sharedwidgets/already_have_account_row.dart';
import 'package:pakpay/sharedwidgets/app_drop_down_field.dart';

import 'package:pakpay/sharedwidgets/primary_button.dart';
import 'package:pakpay/sharedwidgets/reusbale_textfiel.dart';
import 'package:pakpay/sharedwidgets/screen_header.dart';
import 'package:pakpay/utills/pakistan_locations.dart';
import 'package:pakpay/Models/user_model.dart';
import 'package:pakpay/view/auth/createaccount/appbar_steps_widget.dart';
import 'package:pakpay/view/auth/createaccount/employement_income.dart';

class AddressDetailsScreen extends StatefulWidget {
  const AddressDetailsScreen({super.key, required this.user});

  final UserModel user;

  @override
  State<AddressDetailsScreen> createState() => _AddressDetailsScreenState();
}

class _AddressDetailsScreenState extends State<AddressDetailsScreen> {
  final _addressController = TextEditingController();
  final _postalCodeController = TextEditingController();

  String? _selectedProvince;
  String? _selectedCity;

  @override
  void dispose() {
    _addressController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    final updatedUser = widget.user.copyWith(
      province: _selectedProvince,
      city: _selectedCity,
      residentialAddress: _addressController.text.trim(),
      postalCode: _postalCodeController.text.trim(),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmploymentIncomeScreen(user: updatedUser),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StepAppBar(currentStep: 3),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgclr),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ScreenHeader(
                title: "Address Details",
                subtitle:
                    'Please provide your current residential address for account verification.',
              ),
              SizedBox(height: 10.h),

              _SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppDropdownField<String>(
                      label: "Province",
                      hint: "Select your province",
                      value: _selectedProvince,
                      items: PakistanLocations.provinces,
                      itemLabel: (p) => p,
                      onChanged: (value) {
                        setState(() {
                          _selectedProvince = value;
                          _selectedCity = null;
                        });
                      },
                    ),
                    SizedBox(height: 15.h),
                    AppDropdownField<String>(
                      label: "City",
                      hint: _selectedProvince == null
                          ? "Select province first"
                          : "Select your city",
                      value: _selectedCity,
                      enabled: _selectedProvince != null,
                      helperText: _selectedProvince == null
                          ? "Please select a province first"
                          : null,
                      items: _selectedProvince == null
                          ? const []
                          : PakistanLocations.citiesFor(_selectedProvince),
                      itemLabel: (c) => c,
                      onChanged: (value) =>
                          setState(() => _selectedCity = value),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),

              _SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(
                      controller: _addressController,
                      label: "Residential Address",
                      hint: "Enter your full address (House #, Street...)",
                      maxLines: 3,
                      fillColor: AppColors.txtfieldclr.withValues(alpha: .3),
                    ),
                    SizedBox(height: 20.h),
                    const _LocateOnMapButton(),
                  ],
                ),
              ),
              SizedBox(height: 10.h),

              _SectionCard(
                child: AppTextField(
                  controller: _postalCodeController,
                  label: "Postal Code (Optional)",
                  hint: "e.g. 24640",
                  fillColor: AppColors.txtfieldclr.withValues(alpha: .2),
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
                onPressed: _handleContinue,
              ),
              SizedBox(height: 10.h),
              const AlreadyHaveAccountRow(),
            ],
          ),
        ),
      ),
    );
  }
}


class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: child,
    );
  }
}

class _LocateOnMapButton extends StatelessWidget {
  const _LocateOnMapButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 95.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
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
            Icon(Icons.chevron_right, color: AppColors.primaryclr, size: 26.sp),
          ],
        ),
      ),
    );
  }
}
