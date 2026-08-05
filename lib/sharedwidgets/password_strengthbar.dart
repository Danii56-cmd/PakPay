import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';

/// Represents how strong a password is, from empty to strong.
enum PasswordStrength { empty, weak, fair, good, strong }

/// Very small heuristic — good enough for a UI hint, not real security
/// validation. Swap this out for whatever rule set your backend uses.
PasswordStrength calculatePasswordStrength(String password) {
  if (password.isEmpty) return PasswordStrength.empty;

  int score = 0;
  if (password.length >= 8) score++;
  if (RegExp(r'[A-Z]').hasMatch(password)) score++;
  if (RegExp(r'[0-9]').hasMatch(password)) score++;
  if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) score++;

  switch (score) {
    case 0:
    case 1:
      return PasswordStrength.weak;
    case 2:
      return PasswordStrength.fair;
    case 3:
      return PasswordStrength.good;
    default:
      return PasswordStrength.strong;
  }
}

/// A 4-segment strength bar + label ("Strength: Weak / Fair / Good /
/// Strong"), shown under the New Password field.
class PasswordStrengthBar extends StatelessWidget {
  const PasswordStrengthBar({super.key, required this.strength});

  final PasswordStrength strength;

  int get _filledSegments {
    switch (strength) {
      case PasswordStrength.empty:
        return 0;
      case PasswordStrength.weak:
        return 1;
      case PasswordStrength.fair:
        return 2;
      case PasswordStrength.good:
        return 3;
      case PasswordStrength.strong:
        return 4;
    }
  }

  Color get _color {
    switch (strength) {
      case PasswordStrength.empty:
      case PasswordStrength.weak:
        return Colors.red.shade400;
      case PasswordStrength.fair:
        return Colors.orange.shade400;
      case PasswordStrength.good:
        return Colors.lightGreen.shade600;
      case PasswordStrength.strong:
        return AppColors.primaryclr;
    }
  }

  String get _label {
    switch (strength) {
      case PasswordStrength.empty:
        return '';
      case PasswordStrength.weak:
        return 'Weak';
      case PasswordStrength.fair:
        return 'Fair';
      case PasswordStrength.good:
        return 'Good';
      case PasswordStrength.strong:
        return 'Strong';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: List.generate(4, (index) {
            final filled = index < _filledSegments;
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: index == 3 ? 0 : 6.w),
                height: 5.h,
                decoration: BoxDecoration(
                  color: filled ? _color : AppColors.txtfieldclr,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            );
          }),
        ),
        if (_label.isNotEmpty) ...[
          SizedBox(height: 6.h),
          Text(
            'Strength: $_label',
            style: TextStyle(fontSize: 12.sp, color: Colors.black54),
          ),
        ],
      ],
    );
  }
}