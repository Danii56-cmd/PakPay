import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';


class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
    this.width,
    this.height = 56,
  });

  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null;

    return SizedBox(
      width: width,
      height: height.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? AppColors.primaryclr
              : AppColors.primaryclr.withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (icon != null) ...[
              SizedBox(width: 8.w),
              Icon(icon, color: Colors.white, size: 18.sp),
            ],
          ],
        ),
      ),
    );
  }
}
