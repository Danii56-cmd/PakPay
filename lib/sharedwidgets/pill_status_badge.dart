import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A small rounded pill with an icon and a short message. Used for
/// status hints like "Email sent successfully" or "Automatic OTP
/// detection is active".
class PillStatusBadge extends StatelessWidget {
  const PillStatusBadge({
    super.key,
    required this.icon,
    required this.text,
    this.backgroundColor = const Color(0xFFDFF5E7),
    this.foregroundColor = const Color(0xFF1E8E4F),
  });

  final IconData icon;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15.sp, color: foregroundColor),
          SizedBox(width: 6.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w600,
              color: foregroundColor,
            ),
          ),
        ],
      ),
    );
  }
}