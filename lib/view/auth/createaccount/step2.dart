import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/primary_button.dart';
import 'package:pakpay/view/auth/createaccount/appbar_steps_widget.dart';
import 'package:pakpay/view/auth/createaccount/step3.dart';
import 'package:pakpay/view/auth/login_screen.dart';

class Step2Page extends StatefulWidget {
  const Step2Page({super.key});

  @override
  State<Step2Page> createState() => _Step2PageState();
}

class _Step2PageState extends State<Step2Page> {
  final TextEditingController cnicController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();

  String? selectedGender;

  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  @override
  void dispose() {
    cnicController.dispose();
    dobController.dispose();
    fatherNameController.dispose();
    super.dispose();
  }

  Widget _fieldBox({
    required IconData icon,
    required String label,
    required Widget child,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 199, 199, 199),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Label on its own line, top-left
            Text(
              label,
              style: TextStyle(
                color: AppColors.secondaryclr,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6.h),
            // Icon + value row below the label
            Row(
              children: [
                Icon(icon, color: Colors.black, size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(child: child),
                if (trailing != null) trailing,
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextStyle get _valueStyle => TextStyle(
    color: Colors.black,
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
  );

  InputDecoration get _innerDecoration =>
      const InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        isDense: true,
        isCollapsed: true,
        contentPadding: EdgeInsets.zero,
      ).copyWith(
        hintStyle: TextStyle(
          color: Colors.black,
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
        ),
      );

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dobController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  bool get _isFormValid =>
      cnicController.text.isNotEmpty &&
      dobController.text.isNotEmpty &&
      selectedGender != null &&
      fatherNameController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StepAppBar(currentStep: 2),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.bgclr),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Text(
                'Personal Information',
                style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10.h),
              Text(
                'Please provide your details as per your CNIC for identity verification.',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryclr,
                ),
              ),
              SizedBox(height: 24.h),

              // CNIC Number
              _fieldBox(
                icon: Icons.badge_outlined,
                label: "CNIC Number",
                child: TextFormField(
                  controller: cnicController,
                  keyboardType: TextInputType.number,
                  onChanged: (_) => setState(() {}),
                  style: _valueStyle,
                  decoration: _innerDecoration.copyWith(
                    hintText: "XXXXX-XXXXXXX-X",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 6.h, left: 4.w),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 14.sp,
                      color: Colors.black45,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      "Example: 42101-1234567-1",
                      style: TextStyle(fontSize: 12.sp, color: Colors.black45),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Date of Birth
              _fieldBox(
                icon: Icons.calendar_today_outlined,
                label: "Date of Birth",
                onTap: _pickDate,
                child: TextFormField(
                  controller: dobController,
                  readOnly: true,
                  enabled: false,
                  style: _valueStyle.copyWith(color: Colors.black),
                  decoration: _innerDecoration
                      .copyWith(hintText: "DD/MM/YYYY")
                      .copyWith(disabledBorder: InputBorder.none),
                ),
              ),
              SizedBox(height: 16.h),

              // Gender
              _fieldBox(
                icon: Icons.wc_outlined,
                label: "Gender",
                trailing: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black,
                  size: 22.sp,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedGender,
                    isExpanded: true,
                    isDense: true,
                    hint: Text(
                      "Select Gender",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    icon: const SizedBox.shrink(),
                    style: _valueStyle,
                    items: genderOptions
                        .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                        .toList(),
                    onChanged: (value) {
                      setState(() => selectedGender = value);
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Father's/Husband's Name
              _fieldBox(
                icon: Icons.person_outline,
                label: "Father's/Husband's Name",
                child: TextFormField(
                  controller: fatherNameController,
                  onChanged: (_) => setState(() {}),
                  style: _valueStyle,
                  decoration: _innerDecoration.copyWith(hintText: "Full Name"),
                ),
              ),
              SizedBox(height: 20.h),

              // Secure Verification note
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7F0FF),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: AppColors.primaryclr.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.verified_user_outlined,
                        size: 16.sp,
                        color: const Color(0xFF2E9E5B),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Secure Verification",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Your data is encrypted and shared only with state regulators for KYC\ncompliance.",
                            style: TextStyle(
                              fontSize: 12.5.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),

              PrimaryButton(
                width: double.infinity,
                text: "Continue",
                icon: Icons.arrow_forward,
                onPressed: _isFormValid
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Step3Page(),
                          ),
                        );
                      }
                    : () {},
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
