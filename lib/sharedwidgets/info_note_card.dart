import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoNoteCard extends StatelessWidget {
  const InfoNoteCard({
    super.key,
    required this.description,
    this.title,
    this.icon = Icons.info_outline,
    this.backgroundColor = const Color(0xFFE7F0FF),
    this.iconColor = const Color(0xFF2E9E5B),
    this.iconHasBackground = true,
  });

  final String description;
  final String? title;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final bool iconHasBackground;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (iconHasBackground)
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 16.sp, color: iconColor),
            )
          else
            Icon(icon, size: 22.sp, color: iconColor),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4.h),
                ],
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
