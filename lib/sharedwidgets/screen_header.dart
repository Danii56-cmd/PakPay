import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenHeader extends StatelessWidget {     // inheritance
  const ScreenHeader({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10.h),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
