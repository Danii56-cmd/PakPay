import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLabeledFieldBox extends StatelessWidget {
  const AppLabeledFieldBox({
    super.key,
    required this.icon,
    required this.label,
    required this.child,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Widget child;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
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
            Text(
              label,
              style: TextStyle(
                color: const Color.fromARGB(255, 65, 95, 141),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Icon(icon, color: Colors.black, size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(child: child),
                if (trailing != null) trailing!,
              ],
            ),
          ],
        ),
      ),
    );
  }


  static InputDecoration innerDecoration({String? hintText}) {
    return InputDecoration(
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      isDense: true,
      isCollapsed: true,
      contentPadding: EdgeInsets.zero,
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.black,
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  static TextStyle get valueStyle => TextStyle(
        color: Colors.black,
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
      );
}