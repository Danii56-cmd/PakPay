import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';


class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hint,
    this.controller,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.maxLines = 1,
    this.readOnly = false,
    this.enabled = true,
    this.onTap,
    this.onChanged,
    this.fillColor,
  });

  final String hint;
  final TextEditingController? controller;
  final String? label;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool readOnly;
  final bool enabled;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    final field = TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      readOnly: readOnly,
      enabled: enabled,
      onTap: onTap,
      onChanged: onChanged,
      style: TextStyle(
        color: Colors.black,
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.black54,
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: Colors.black)
            : null,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: enabled
            ? (fillColor ?? AppColors.txtfieldclr)
            : Colors.grey.shade100,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(14.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(14.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryclr, width: 1.5.w),
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
    );

    if (label == null) return field;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label!,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryclr,
          ),
        ),
        SizedBox(height: 6.h),
        field,
      ],
    );
  }
}