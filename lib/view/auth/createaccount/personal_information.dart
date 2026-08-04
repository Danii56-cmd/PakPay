import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/already_have_account_row.dart';
import 'package:pakpay/sharedwidgets/app_labeled_fieldbox.dart';
import 'package:pakpay/sharedwidgets/info_note_card.dart';
import 'package:pakpay/sharedwidgets/primary_button.dart';
import 'package:pakpay/sharedwidgets/screen_header.dart';
import 'package:pakpay/view/auth/Models/user_model.dart';
import 'package:pakpay/view/auth/createaccount/address_details.dart';
import 'package:pakpay/view/auth/createaccount/appbar_steps_widget.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key, required this.user});

  final UserModel user;

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState
    extends State<PersonalInformationScreen> {
  final _cnicController = TextEditingController();
  final _dobController = TextEditingController();
  final _fatherNameController = TextEditingController();

  String? _selectedGender;

  static const _genderOptions = ['Male', 'Female', 'Other'];

  @override
  void dispose() {
    _cnicController.dispose();
    _dobController.dispose();
    _fatherNameController.dispose();
    super.dispose();
  }

  bool get _isFormValid =>
      _cnicController.text.isNotEmpty &&
      _dobController.text.isNotEmpty &&
      _selectedGender != null &&
      _fatherNameController.text.isNotEmpty;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  void _handleContinue() {
  
    final updatedUser = widget.user.copyWith(
      cnic: _cnicController.text.trim(),
      dob: _dobController.text.trim(),
      gender: _selectedGender,
      fatherOrHusbandName: _fatherNameController.text.trim(),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddressDetailsScreen(user: updatedUser),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StepAppBar(currentStep: 2),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgclr),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              const ScreenHeader(
                title: 'Personal Information',
                subtitle:
                    'Please provide your details as per your CNIC for identity verification.',
              ),
              SizedBox(height: 24.h),

              // CNIC Number
              AppLabeledFieldBox(
                icon: Icons.badge_outlined,
                label: "CNIC Number",
                child: TextFormField(
                  controller: _cnicController,
                  keyboardType: TextInputType.number,
                  onChanged: (_) => setState(() {}),
                  style: AppLabeledFieldBox.valueStyle,
                  decoration: AppLabeledFieldBox.innerDecoration(
                    hintText: "XXXXX-XXXXXXX-X",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 6.h, left: 4.w),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 14.sp, color: Colors.black45),
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
              AppLabeledFieldBox(
                icon: Icons.calendar_today_outlined,
                label: "Date of Birth",
                onTap: _pickDate,
                child: TextFormField(
                  controller: _dobController,
                  readOnly: true,
                  enabled: false,
                  style: AppLabeledFieldBox.valueStyle,
                  decoration: AppLabeledFieldBox.innerDecoration(
                    hintText: "DD/MM/YYYY",
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Gender
              AppLabeledFieldBox(
                icon: Icons.wc_outlined,
                label: "Gender",
                trailing: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black,
                  size: 22.sp,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedGender,
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
                    style: AppLabeledFieldBox.valueStyle,
                    items: _genderOptions
                        .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                        .toList(),
                    onChanged: (value) => setState(() => _selectedGender = value),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Father's/Husband's Name
              AppLabeledFieldBox(
                icon: Icons.person_outline,
                label: "Father's/Husband's Name",
                child: TextFormField(
                  controller: _fatherNameController,
                  onChanged: (_) => setState(() {}),
                  style: AppLabeledFieldBox.valueStyle,
                  decoration: AppLabeledFieldBox.innerDecoration(
                    hintText: "Full Name",
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              const InfoNoteCard(
                icon: Icons.verified_user_outlined,
                title: "Secure Verification",
                description:
                    "Your data is encrypted and shared only with state regulators for KYC compliance.",
              ),
              SizedBox(height: 40.h),

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