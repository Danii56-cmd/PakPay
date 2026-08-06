import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/password_field.dart';
import 'package:pakpay/sharedwidgets/password_strengthbar.dart';

import 'package:pakpay/sharedwidgets/primary_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _newPassword = '';
  String _confirmPassword = '';
  bool _isSaving = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _hasMinLength => _newPassword.length >= 8;

  bool get _hasNumberOrSymbol =>
      RegExp(r'[0-9!@#\$%^&*(),.?":{}|<>]').hasMatch(_newPassword);

  bool get _passwordsMatch =>
      _newPassword.isNotEmpty && _newPassword == _confirmPassword;

  bool get _canSubmit =>
      _hasMinLength && _hasNumberOrSymbol && _passwordsMatch && !_isSaving;

  Future<void> _onSave() async {
    if (!_canSubmit) return;
    FocusScope.of(context).unfocus();
    setState(() => _isSaving = true);

    // Replace with the actual "set new password" API call.
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;
    setState(() => _isSaving = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Password updated successfully"),
        backgroundColor: AppColors.primaryclr,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );

    // Clear the whole forgot-password stack and drop the user back on
    // the Login screen (which should be the first route).
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final strength = calculatePasswordStrength(_newPassword);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primaryclr,
            size: 22.sp,
          ),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.bgclr),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Create a new strong password for your account.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 24.h),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PasswordField(
                        label: 'New Password',
                        controller: _newPasswordController,
                        onChanged: (value) =>
                            setState(() => _newPassword = value),
                      ),
                      SizedBox(height: 10.h),
                      PasswordStrengthBar(strength: strength),
                      SizedBox(height: 20.h),

                      PasswordField(
                        label: 'Confirm Password',
                        controller: _confirmPasswordController,
                        onChanged: (value) =>
                            setState(() => _confirmPassword = value),
                      ),
                      if (_confirmPassword.isNotEmpty && !_passwordsMatch) ...[
                        SizedBox(height: 6.h),
                        Text(
                          "Passwords don't match",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.red.shade400,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                      SizedBox(height: 18.h),

                      _RequirementRow(
                        text: 'At least 8 characters',
                        met: _hasMinLength,
                      ),
                      SizedBox(height: 8.h),
                      _RequirementRow(
                        text: 'Contains a number or symbol',
                        met: _hasNumberOrSymbol,
                      ),
                      SizedBox(height: 24.h),

                      PrimaryButton(
                        width: double.infinity,
                        text: _isSaving ? 'Saving...' : 'Save New Password',
                        onPressed: _canSubmit ? _onSave : null,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A single "✓ requirement text" row that turns green once [met] is true.
class _RequirementRow extends StatelessWidget {
  const _RequirementRow({required this.text, required this.met});

  final String text;
  final bool met;

  @override
  Widget build(BuildContext context) {
    final color = met ? AppColors.primaryclr : Colors.black38;
    return Row(
      children: [
        Icon(
          met ? Icons.check_circle : Icons.check_circle_outline,
          size: 16.sp,
          color: color,
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 12.5.sp,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
