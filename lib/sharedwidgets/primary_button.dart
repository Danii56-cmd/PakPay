import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final double? width;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final bool iconOnLeft; // NEW

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.icon,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.iconOnLeft = false, // NEW — default keeps existing behavior
  });

  @override
  Widget build(BuildContext context) {
    final Color resolvedBg = backgroundColor ?? AppColors.primaryclr;
    final bool isTransparent =
        resolvedBg == Colors.transparent || resolvedBg.a == 0;

    final textWidget = Text(
      text,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: textColor ?? Colors.white,
      ),
    );

    final iconWidget = icon != null
        ? Icon(icon, color: textColor ?? Colors.white, size: 24.sp)
        : null;

    return Container(
      width: width,
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: isTransparent
            ? null
            : [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.35),
                  blurRadius: 12.r,
                  spreadRadius: 0,
                  offset: Offset(0, 6.h),
                ),
              ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: resolvedBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
          side: BorderSide(
            color: borderColor ?? AppColors.primaryclr,
            width: 1.w,
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                height: 20.h,
                width: 20.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: textColor ?? Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: iconOnLeft
                    ? [
                        if (iconWidget != null) ...[
                          iconWidget,
                          SizedBox(width: 8.w),
                        ],
                        textWidget,
                      ]
                    : [
                        textWidget,
                        if (iconWidget != null) ...[
                          SizedBox(width: 8.w),
                          iconWidget,
                        ],
                      ],
              ),
      ),
    );
  }
}
