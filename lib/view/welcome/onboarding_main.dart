import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/view/welcome/onboarding_1.dart';
import 'package:pakpay/view/welcome/onboarding_2.dart';
import 'package:pakpay/view/welcome/onboarding_3.dart';
import 'package:pakpay/view/welcome/welcome_screen.dart';

class OnboardingMain extends StatefulWidget {
  const OnboardingMain({super.key});

  @override
  State<OnboardingMain> createState() => _OnboardingMainState();
}

class _OnboardingMainState extends State<OnboardingMain> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  void nextPage() {
    if (currentIndex < 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _finishOnboarding();
    }
  }

  void skipOnboarding() {
    _finishOnboarding();
  }

  void _finishOnboarding() {
    // Navigate to wherever onboarding should lead
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            controller: _controller,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            children: [
              OnboardingScreen1(onNext: nextPage, onSkip: skipOnboarding),
              OnboardingScreen2(onNext: nextPage, onSkip: skipOnboarding),
              OnboardingScreen3(onNext: nextPage, onSkip: skipOnboarding),
            ],
          ),

          // Dot indicator
          Positioned(
            bottom: 180.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                bool isActive = currentIndex == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  height: 6.h,
                  width: isActive ? 20.w : 8.w,
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primaryclr
                        : Colors.grey.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
