import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/primary_button.dart';

class OtpExpiredScreen extends StatelessWidget {
  const OtpExpiredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primaryclr,
            size: 22.sp,
          ),
          onPressed: () => Navigator.maybePop(context),
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
                SizedBox(height: 60.h),

                Center(child: _ExpiredClockIllustration()),
                SizedBox(height: 32.h),

                Text(
                  'OTP Expired',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'The code we sent you is no longer valid. Please request a new one.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 32.h),

                PrimaryButton(
                  text: 'Resend OTP',
                  onPressed: () {
                    // This screen is expected to have been pushed (not
                    // pushReplacement'd) on top of the OTP verification
                    // screen, so popping returns there and its existing
                    // resend logic/timer can run again.
                    // Trigger the actual resend-OTP API call here
                    // if this screen is reached via a route replacement
                    // instead of a simple push.
                    Navigator.maybePop(context);
                  },
                ),
                SizedBox(height: 14.h),

                OutlinedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 56.h),
                    side: BorderSide(
                      color: AppColors.secondaryclr,
                      width: 1.2.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Text(
                    'Back to Login',
                    style: TextStyle(
                      color: AppColors.secondaryclr,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Need help? ',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Open a support chat / help center link.
                      },
                      child: Text(
                        'Contact Support',
                        style: TextStyle(
                          color: AppColors.primaryclr,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
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

/// The clock-with-a-red-"expired"-badge illustration inside a white
/// rounded square, matching the design.
class _ExpiredClockIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final boxSize = 150.w;
    return Container(
      width: boxSize,
      height: boxSize,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Clock face
          Container(
            width: boxSize * 0.62,
            height: boxSize * 0.62,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300, width: 3),
            ),
            child: CustomPaint(painter: _ClockHandsPainter()),
          ),
          // Red "expired" badge
          Positioned(
            right: boxSize * 0.12,
            bottom: boxSize * 0.14,
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFFE5484D),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: const Icon(
                Icons.history_toggle_off,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Draws the two clock hands (minute hand in teal, hour hand in navy)
/// pointing roughly to the position shown in the design.
class _ClockHandsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final minutePaint = Paint()
      ..color = AppColors.primaryclr
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      center,
      Offset(center.dx, center.dy - size.height * 0.36),
      minutePaint,
    );

    final hourPaint = Paint()
      ..color = AppColors.secondaryclr
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      center,
      Offset(center.dx + size.width * 0.22, center.dy + size.height * 0.22),
      hourPaint,
    );

    canvas.drawCircle(center, 3, Paint()..color = AppColors.secondaryclr);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
