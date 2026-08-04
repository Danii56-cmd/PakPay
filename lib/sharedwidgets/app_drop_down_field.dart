import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';


class AppDropdownField<T> extends StatelessWidget {
  const AppDropdownField({
    super.key,
    required this.hint,
    required this.items,
    required this.itemLabel,
    this.value,
    this.label,
    this.onChanged,
    this.enabled = true,
    this.fillColor,
    this.helperText,
  });

  final String hint;
  final List<T> items;
  final String Function(T item) itemLabel;
  final T? value;
  final String? label;
  final ValueChanged<T?>? onChanged;
  final bool enabled;
  final Color? fillColor;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    final dropdown = DropdownButtonFormField<T>(
      initialValue: value,
      isExpanded: true,
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: enabled ? AppColors.primaryclr : Colors.grey.shade400,
      ),
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(14.r),
      hint: Text(
        hint,
        style: TextStyle(
          color: Colors.black45,
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
        fillColor:
            enabled ? (fillColor ?? AppColors.txtfieldclr) : Colors.grey.shade100,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        helperText: helperText,
        helperStyle: TextStyle(
          color: Colors.orange.shade700,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1.w),
          borderRadius: BorderRadius.circular(14.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1.w),
          borderRadius: BorderRadius.circular(14.r),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1.w),
          borderRadius: BorderRadius.circular(14.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryclr, width: 1.5.w),
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
      items: enabled
          ? items
              .map(
                (item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(itemLabel(item), style: TextStyle(fontSize: 15.sp)),
                ),
              )
              .toList()
          : const [],
      onChanged: enabled ? onChanged : null,
    );

    if (label == null) return dropdown;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label!,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryclr,
          ),
        ),
        SizedBox(height: 6.h),
        dropdown,
      ],
    );
  }
}