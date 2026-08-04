import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';

class IllustrationCircle extends StatelessWidget {
  const IllustrationCircle({
    super.key,
    required this.icon,
    this.size = 200,
    this.iconSize = 60,
    this.backgroundColor = const Color(0xFFDFF5E7),
    this.iconColor = AppColors.primaryclr,
    this.showBadge = false,
    this.badgeIcon = Icons.check,
    this.badgeColor = AppColors.primaryclr,
  });

  final IconData icon;
  final double size;
  final double iconSize;
  final Color backgroundColor;
  final Color iconColor;
  final bool showBadge;
  final IconData badgeIcon;
  final Color badgeColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.w,
      height: size.w,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size.w,
            height: size.w,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: iconSize.sp, color: iconColor),
          ),
          if (showBadge)
            Positioned(
              right: -4,
              bottom: -4,
              child: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: badgeColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3.w),
                ),
                child: Icon(badgeIcon, color: Colors.white, size: 18.sp),
              ),
            ),
        ],
      ),
    );
  }
}
