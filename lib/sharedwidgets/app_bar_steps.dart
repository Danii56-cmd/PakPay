import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';

/// AppBar shown on every step of the sign-up flow: a back arrow, a
/// "Step X of Y" label, and a slim progress bar underneath.
class StepAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StepAppBar({super.key, required this.currentStep, this.totalSteps = 6});

  final int currentStep;
  final int totalSteps;

  @override
  Size get preferredSize => Size.fromHeight(76.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      toolbarHeight: preferredSize.height,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.maybePop(context),
                  child: const Icon(Icons.arrow_back, color: Colors.black87),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Step $currentStep of $totalSteps",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 24.w), // balances the back icon's width
              ],
            ),
            SizedBox(height: 10.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: LinearProgressIndicator(
                value: currentStep / totalSteps,
                minHeight: 5.h,
                backgroundColor: AppColors.txtfieldclr,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primaryclr,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
