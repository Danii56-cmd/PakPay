import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/primary_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({
    super.key,
    required this.contact,
    this.otpLength = 6,
    this.expirySeconds = 58,
  });

  final String contact;
  final int otpLength;
  final int expirySeconds;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;
  late int _secondsLeft;
  Timer? _timer;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    _controllers =
        List.generate(widget.otpLength, (_) => TextEditingController());
    _focusNodes = List.generate(widget.otpLength, (_) => FocusNode());
    _secondsLeft = widget.expirySeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsLeft = widget.expirySeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 0) {
        timer.cancel();
        return;
      }
      setState(() => _secondsLeft--);
    });
  }

  String get _formattedTime {
    final minutes = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String get _code => _controllers.map((c) => c.text).join();

  bool get _isComplete => _code.length == widget.otpLength;

  void _onChanged(int index, String value) {
    if (value.isNotEmpty && index < widget.otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  Future<void> _onVerify() async {
    if (!_isComplete || _isVerifying) return;
    FocusScope.of(context).unfocus();
    setState(() => _isVerifying = true);

    // TODO: replace with actual API call to verify OTP
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;
    setState(() => _isVerifying = false);

    // TODO: navigate to reset password / next screen on success
  }

  void _onResend() {
    if (_secondsLeft > 0) return;
    for (final c in _controllers) {
      c.clear();
    }
    _focusNodes.first.requestFocus();
    // TODO: replace with actual API call to resend OTP
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool canResend = _secondsLeft <= 0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryclr, size: 22.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'PakPay',
          style: TextStyle(
            color: AppColors.primaryclr,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.bgclr),
        child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40.h),

              // Icon avatar
              Center(
                child: Container(
                  width: 88.w,
                  height: 88.w,
                  decoration: BoxDecoration(
                    color: AppColors.primaryclr.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.phonelink_lock_rounded,
                    color: AppColors.primaryclr,
                    size: 36.sp,
                  ),
                ),
              ),
              SizedBox(height: 28.h),

              Text(
                'Verify OTP',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Enter the 6-digit code sent to your mobile\nnumber.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 32.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(widget.otpLength, (index) {
                  final bool isFocused = _focusNodes[index].hasFocus;
                  return SizedBox(
                    width: 48.w,
                    height: 56.w,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: AppColors.txtfieldclr,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryclr, width: 1.5.w),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      onChanged: (value) => _onChanged(index, value),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20.h),

              Center(
                child: Column(
                  children: [
                    Text(
                      'Code expires in $_formattedTime',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    GestureDetector(
                      onTap: canResend ? _onResend : null,
                      child: Text(
                        'Resend OTP',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: canResend
                              ? AppColors.primaryclr
                              : Colors.black26,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),

              PrimaryButton(
                text: _isVerifying ? 'Verifying...' : 'Verify',
                icon: _isVerifying ? null : Icons.arrow_forward,
                onPressed:
                    (_isComplete && !_isVerifying) ? _onVerify : null,
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
        ),
      ),
    );
  }
}