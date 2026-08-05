import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/already_have_account_row.dart';

import 'package:pakpay/sharedwidgets/primary_button.dart';
import 'package:pakpay/sharedwidgets/reusbale_textfiel.dart';
import 'package:pakpay/sharedwidgets/screen_header.dart';
import 'package:pakpay/Models/user_model.dart';
import 'package:pakpay/view/auth/createaccount/appbar_steps_widget.dart';
import 'package:pakpay/view/auth/createaccount/personal_information.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _referralController = TextEditingController();

  bool _agreeTerms = false;
  bool _agreePrivacy = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  bool get _canContinue => _agreeTerms && _agreePrivacy;

  void _handleContinue() {
    if (!_canContinue) // false
    {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please agree to the terms and privacy policy"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      );
      return;
    }

    final user = UserModel(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      referralCode: _referralController.text.trim(),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PersonalInformationScreen(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StepAppBar(currentStep: 1),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgclr),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              const ScreenHeader(
                title: 'Create Your Account',
                subtitle:
                    'Open your digital bank account in just a few minutes.',
              ),
              SizedBox(height: 20.h),

              // First Name / Last Name
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: _firstNameController,
                      hint: "First Name",
                      prefixIcon: Icons.person_outline,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: AppTextField(
                      controller: _lastNameController,
                      hint: "Last Name",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

          
              IntlPhoneField(
                controller: _phoneController,
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
                    color: Colors.black54,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  fillColor: AppColors.txtfieldclr,
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
                onChanged: (phone) => debugPrint(phone.completeNumber),
              ),
              SizedBox(height: 16.h),

              AppTextField(
                controller: _emailController,
                hint: "Email Address",
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.mail_outline,
              ),
              SizedBox(height: 16.h),

              AppTextField(
                controller: _referralController,
                hint: "Referral Code (Optional)",
                prefixIcon: Icons.card_giftcard_outlined,
              ),
              SizedBox(height: 20.h),

              _AgreementCheckboxRow(
                value: _agreeTerms,
                onChanged: (v) => setState(() => _agreeTerms = v),
                prefixText: "I agree to the ",
                linkText: "Terms & Conditions",
              ),
              SizedBox(height: 4.h),
              _AgreementCheckboxRow(
                value: _agreePrivacy,
                onChanged: (v) => setState(() => _agreePrivacy = v),
                prefixText: "I agree to the ",
                linkText: "Privacy Policy",
              ),
              SizedBox(height: 50.h),

              PrimaryButton(
                width: double.infinity,
                text: "Continue",
                icon: Icons.arrow_forward,
                onPressed: _handleContinue,
              ),
              SizedBox(height: 20.h),

              const AlreadyHaveAccountRow(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}


class _AgreementCheckboxRow extends StatelessWidget {
  const _AgreementCheckboxRow({
    required this.value,
    required this.onChanged,
    required this.prefixText,
    required this.linkText,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String prefixText;
  final String linkText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 24.h,
          width: 24.w,
          child: Checkbox(
            value: value,
            activeColor: AppColors.primaryclr,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
            onChanged: (v) => onChanged(v ?? false),
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          prefixText,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            linkText,
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
    );
  }
}
