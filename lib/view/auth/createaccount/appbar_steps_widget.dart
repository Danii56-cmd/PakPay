import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback? onBack;

  const StepAppBar({
    super.key,
    required this.currentStep,
    this.totalSteps = 6,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.2.r,
      backgroundColor: Colors.white,
      // surfaceTintColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: onBack ?? () => Navigator.pop(context),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Step $currentStep of $totalSteps",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 120,
              child: LinearProgressIndicator(
                value: currentStep / totalSteps,
                minHeight: 6,
                backgroundColor: const Color(0xffD7E7FF),
                valueColor: const AlwaysStoppedAnimation(Colors.green),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
