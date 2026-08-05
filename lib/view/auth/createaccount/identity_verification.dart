import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/primary_button.dart';
import 'package:pakpay/Models/user_model.dart';

class IdentityVerificationScreen extends StatelessWidget {
  const IdentityVerificationScreen({super.key, required this.user});

  final UserModel user;

  void _handleContinue(BuildContext context) {
    // TODO: navigate to whatever screen follows a completed sign-up
    // (e.g. a success screen or straight into the Dashboard).
  }

  void _handleTakeAgain(BuildContext context) {
    // TODO: re-open the camera / re-run the face-scan capture flow.
  }

  void _handleNeedHelp(BuildContext context) {
    // TODO: open a help sheet or support link.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryclr),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Identity Verification',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              const _FaceScanFrame(),
              SizedBox(height: 30.h),

              Text(
                'Position your face within the frame',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 10.h),
              Text(
                'Ensure good lighting and avoid wearing glasses or hats for the best result.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 24.h),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 46.w,
                      height: 46.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F2F6),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: const Icon(
                        Icons.image_outlined,
                        color: Colors.black45,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 13.sp,
                            height: 1.4,
                            color: Colors.black54,
                          ),
                          children: const [
                            TextSpan(text: 'Secure verification powered by '),
                            TextSpan(
                              text: 'PakPay AI',
                              style: TextStyle(
                                color: AppColors.primaryclr,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '. Your biometric data is encrypted and never stored locally.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 26.h),

              PrimaryButton(
                width: double.infinity,
                text: 'Continue',
                onPressed: () => _handleContinue(context),
              ),
              SizedBox(height: 16.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => _handleTakeAgain(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.refresh, size: 16, color: AppColors.secondaryclr),
                        SizedBox(width: 4.w),
                        Text(
                          'Take Again',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryclr,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _handleNeedHelp(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.help_outline, size: 16, color: Colors.black54),
                        SizedBox(width: 4.w),
                        Text(
                          'Need Help?',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

/// The circular face-scan frame. This is a stylised placeholder (dark
/// gradient circle + face icon + scanning ring) rather than a real
/// camera preview — wire your camera package's preview widget in here
/// once you set up live face capture.
class _FaceScanFrame extends StatelessWidget {
  const _FaceScanFrame();

  @override
  Widget build(BuildContext context) {
    final size = 260.w;
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primaryclr, width: 3),
      ),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [Color(0xFF2B3A42), Color(0xFF10171B)],
            radius: 0.9,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.face_retouching_natural,
            size: size * 0.45,
            color: Colors.white24,
          ),
        ),
      ),
    );
  }
}