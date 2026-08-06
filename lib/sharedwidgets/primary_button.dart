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
    this.buttonColor,
    this.txtcolor,
    this.iconcolor,
    this.iconLeft = true, // Default: icon on the left
  });

  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final Color? buttonColor;
  final Color? txtcolor;
  final Color? iconcolor;
  final bool iconLeft;

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
              ? buttonColor ?? AppColors.primaryclr
              : (buttonColor ?? AppColors.primaryclr).withValues(alpha: 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          side: BorderSide(color: txtcolor ?? Colors.white),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null && iconLeft) ...[
              Icon(icon, color: iconcolor ?? Colors.white, size: 18.sp),
              SizedBox(width: 8.w),
            ],

            Text(
              text,
              style: TextStyle(
                color: txtcolor ?? Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),

            if (icon != null && !iconLeft) ...[
              SizedBox(width: 8.w),
              Icon(icon, color: iconcolor ?? Colors.white, size: 18.sp),
            ],
          ],
        ),
      ),
    );
  }
}
