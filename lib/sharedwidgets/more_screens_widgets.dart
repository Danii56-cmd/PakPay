  import 'package:flutter/material.dart';
import 'package:pakpay/core/app_colors.dart';

Widget buildSectionLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: AppColors.secondaryclr.withValues(alpha: 0.7),
      ),
    );
  }
  