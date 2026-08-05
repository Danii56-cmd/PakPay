import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/Selecatable_grid_card.dart';
import 'package:pakpay/sharedwidgets/already_have_account_row.dart';
import 'package:pakpay/sharedwidgets/app_drop_down_field.dart';

import 'package:pakpay/sharedwidgets/info_note_card.dart';
import 'package:pakpay/sharedwidgets/primary_button.dart';
import 'package:pakpay/sharedwidgets/reusbale_textfiel.dart';
import 'package:pakpay/sharedwidgets/screen_header.dart';
import 'package:pakpay/Models/user_model.dart';
import 'package:pakpay/view/auth/createaccount/appbar_steps_widget.dart';
import 'package:pakpay/view/auth/createaccount/mobile_verification.dart';

class EmploymentIncomeScreen extends StatefulWidget {
  const EmploymentIncomeScreen({super.key, required this.user});

  final UserModel user;

  @override
  State<EmploymentIncomeScreen> createState() => _EmploymentIncomeScreenState();
}

class _EmploymentIncomeScreenState extends State<EmploymentIncomeScreen> {
  final _occupationController = TextEditingController();
  final _employerNameController = TextEditingController();
  final _ntnController = TextEditingController();

  int _selectedEmploymentIndex = -1;
  String? _selectedSalaryRange;
  String? _selectedSource;

  static const _employmentTypes = [
    _EmploymentType("Salaried", Icons.work_outline),
    _EmploymentType("Self-Employed", Icons.store_outlined),
    _EmploymentType("Student", Icons.school_outlined),
    _EmploymentType("Homemaker", Icons.mobile_friendly),
  ];

  static const _salaryRanges = [
    "Below PKR 25,000",
    "PKR 25,000 - 50,000",
    "PKR 50,001 - 100,000",
    "PKR 100,001 - 200,000",
    "PKR 200,001 - 500,000",
    "PKR 500,001 - 1,000,000",
    "Above PKR 1,000,000",
  ];

  static const _incomeSources = [
    "Salary",
    "Business",
    "Freelancing",
    "Investments",
    "Rental Income",
    "Pension",
    "Other",
  ];

  @override
  void dispose() {
    _occupationController.dispose();
    _employerNameController.dispose();
    _ntnController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    final selectedType = _selectedEmploymentIndex == -1
        ? null
        : _employmentTypes[_selectedEmploymentIndex].label;

    final updatedUser = widget.user.copyWith(
      occupation: _occupationController.text.trim(),
      employmentType: selectedType,
      employerName: _employerNameController.text.trim(),
      monthlyIncomeRange: _selectedSalaryRange,
      incomeSource: _selectedSource,
      ntn: _ntnController.text.trim(),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MobileVerificationScreen(user: updatedUser),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StepAppBar(currentStep: 4),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.bgclr),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ScreenHeader(
                title: "Employement & Income",
                subtitle:
                    'Please provide your professional details for account classification.',
              ),
              SizedBox(height: 10.h),

              AppTextField(
                controller: _occupationController,
                label: "Occupation",
                hint: "Search occupation...",
                suffixIcon: const Icon(Icons.search),
                fillColor: Colors.white,
              ),
              SizedBox(height: 20.h),

              Text(
                "Employment Type",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.secondaryclr,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                height: 230.h,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _employmentTypes.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 110,
                    mainAxisSpacing: 15.h,
                    crossAxisSpacing: 10.w,
                  ),
                  itemBuilder: (context, index) {
                    final type = _employmentTypes[index];
                    return SelectableGridCard(
                      icon: type.icon,
                      label: type.label,
                      selected: _selectedEmploymentIndex == index,
                      onTap: () {
                        setState(() {
                          _selectedEmploymentIndex =
                              _selectedEmploymentIndex == index ? -1 : index;
                        });
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),

              AppTextField(
                controller: _employerNameController,
                label: "Employer Name (Optional)",
                hint: "e.g. Codexdev",
              ),
              SizedBox(height: 20.h),

              AppDropdownField<String>(
                label: "Monthly Income Range",
                hint: "Select your monthly income range",
                value: _selectedSalaryRange,
                items: _salaryRanges,
                itemLabel: (r) => r,
                onChanged: (value) =>
                    setState(() => _selectedSalaryRange = value),
              ),
              SizedBox(height: 10.h),

              AppDropdownField<String>(
                label: "Source of Income",
                hint: "Select source",
                value: _selectedSource,
                items: _incomeSources,
                itemLabel: (s) => s,
                onChanged: (value) => setState(() => _selectedSource = value),
              ),
              SizedBox(height: 20.h),

              AppTextField(
                controller: _ntnController,
                label: "NTN (Optional)",
                hint: "Enter 7 or 8-digit NTN",
              ),
              SizedBox(height: 20.h),

              const InfoNoteCard(
                icon: Icons.info_outline,
                backgroundColor: Color(0xffEEF4FF),
                iconColor: Color(0xFF1D4ED8),
                iconHasBackground: false,
                description:
                    "This information is required by the central bank for regulatory KYC (Know Your Customer) compliance and to secure your transactions.",
              ),
              SizedBox(height: 30.h),

              PrimaryButton(
                width: double.infinity,
                text: "Continue",
                icon: Icons.arrow_forward,
                onPressed: _handleContinue,
              ),
              SizedBox(height: 20.h),

              const AlreadyHaveAccountRow(),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmploymentType {
  final String label;
  final IconData icon;
  const _EmploymentType(this.label, this.icon);
}
