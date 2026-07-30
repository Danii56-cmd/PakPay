import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Step3Page extends StatelessWidget {
  const Step3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Step3 Screen",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
