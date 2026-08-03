import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/primary_button.dart';
import 'package:pakpay/view/auth/createaccount/appbar_steps_widget.dart';
import 'package:pakpay/view/auth/createaccount/mobile_verification.dart';
import 'package:pakpay/view/auth/login_screen.dart';

class EmployementIncomeScreen extends StatefulWidget {
  const EmployementIncomeScreen({super.key});

  @override
  State<EmployementIncomeScreen> createState() =>
      _EmployementIncomeScreenState();
}

class _EmployementIncomeScreenState extends State<EmployementIncomeScreen> {
  int selectedIndex = -1;
  String? selectedSource;
  String? selectedSalaryRange;

  final List<String> titles = [
    "Salaried",
    "Self-Employed",
    "Student",
    "Homemaker",
  ];

  final List<IconData> icons = [
    Icons.work_outline,
    Icons.store_outlined,
    Icons.school_outlined,
    Icons.mobile_friendly,
  ];

  final List<String> salaryRanges = [
    "Below PKR 25,000",
    "PKR 25,000 - 50,000",
    "PKR 50,001 - 100,000",
    "PKR 100,001 - 200,000",
    "PKR 200,001 - 500,000",
    "PKR 500,001 - 1,000,000",
    "Above PKR 1,000,000",
  ];

  final List<String> incomeSources = [
    "Salary",
    "Business",
    "Freelancing",
    "Investments",
    "Rental Income",
    "Pension",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StepAppBar(currentStep: 4),
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.bgclr),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 20.h),
              Text(
                "Employement & Income",
                style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10.h),
              Text(
                'Please provide your professional details for account classification.',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Occupation",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.secondaryclr,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.h),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Search occupation...",
                  suffixIcon: Icon(Icons.search),
                  hintStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  fillColor: Colors.white,
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
                  itemCount: titles.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 110,
                    mainAxisSpacing: 15.h,
                    crossAxisSpacing: 10.w,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectedIndex == index) {
                            selectedIndex = -1; // deselect
                          } else {
                            selectedIndex = index; // select
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? AppColors.primaryclr
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: selectedIndex == index
                                ? AppColors.primaryclr
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              icons[index],
                              size: 30.sp,
                              color: selectedIndex == index
                                  ? Colors.white
                                  : AppColors.primaryclr,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              titles[index],
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: selectedIndex == index
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Employer Name (Optional)",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.secondaryclr,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 6.h),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "e.g. Codexdev",
                  hintStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  fillColor: AppColors.txtfieldclr,
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
              Text(
                "Monthly Income Range",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryclr,
                ),
              ),
              SizedBox(height: 5.h),
              DropdownButtonFormField2<String>(
                value: selectedSalaryRange,
                isExpanded: true,
                iconStyleData: IconStyleData(
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.primaryclr,
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 320.h,
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 8.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                ),
                menuItemStyleData: MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                ),
                hint: Text(
                  "Select your monthly income range",
                  style: TextStyle(
                    color: Colors.black54,
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
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide(
                      color: Colors.grey.shade200,
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
                items: salaryRanges
                    .map(
                      (range) => DropdownMenuItem<String>(
                        value: range,
                        child: Text(range, style: TextStyle(fontSize: 15.sp)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSalaryRange = value;
                  });
                },
              ),
              SizedBox(height: 10.h),
              Text(
                "Source of Income",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryclr,
                ),
              ),

              SizedBox(height: 6.h),

              DropdownButtonFormField2<String>(
                value: selectedSource,
                isExpanded: true,
                iconStyleData: IconStyleData(
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.primaryclr,
                  ),
                ),
                decoration: InputDecoration(
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
                ),
                hint: const Text("Select source"),
                items: incomeSources
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSource = value;
                  });
                },
              ),
              SizedBox(height: 20.h),

              Text(
                "NTN (Optional)",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.secondaryclr,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 6.h),

              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter 7 or 8-digit NTN",
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
                ),
              ),
              SizedBox(height: 20.h),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(18.w),
                decoration: BoxDecoration(
                  color: const Color(0xffEEF4FF),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.blue.shade700,
                      size: 22.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        "This information is required by the central bank for regulatory KYC (Know Your Customer) compliance and to secure your transactions.",
                        style: TextStyle(
                          fontSize: 13.sp,
                          height: 1.6,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              PrimaryButton(
                width: double.infinity,
                text: "Continue",
                icon: Icons.arrow_forward,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MobileVerificationScreen(),
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
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
