import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/app_state.dart';
import 'package:pakpay/view/morescreen/more_screen.dart';
import 'package:pakpay/view/sendmoney/send_money_screen.dart';

Widget buildAppBar() {
  final user = AppState.instance.user;
  final initials =
      '${user.firstName.isNotEmpty ? user.firstName[0] : ''}${user.lastName.isNotEmpty ? user.lastName[0] : ''}';

  return Row(
    children: [
      CircleAvatar(
        radius: 22,
        backgroundColor: AppColors.primaryclr,
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${user.firstName} ${user.lastName}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              user.phone,
              style: const TextStyle(color: Colors.black54, fontSize: 12),
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
            ),
          ],
        ),
        child: const Icon(Icons.notifications_none, size: 20),
      ),
    ],
  );
}

Widget buildWelcome() {
  final user = AppState.instance.user;
  return Text(
    'Welcome back, ${user.firstName} 👋',
    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  );
}

Widget buildQuickActions(BuildContext context) {
  final actions = [
    {'icon': Icons.send_outlined, 'label': 'Send'},
    {'icon': Icons.add_card_rounded, 'label': 'Deposit'},
    {'icon': Icons.receipt_long_outlined, 'label': ' Bills'},
    {'icon': Icons.more_horiz, 'label': 'Bills'},
  ];

  void handle(String label) {
    switch (label) {
      case 'More':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AllActionsScreen()),
        );
        break;
      case 'Send':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SendMoneyScreen()),
        );
        break;
      case 'Deposit':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AllActionsScreen()),
        );
        break;
      case 'Bills':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AllActionsScreen()),
        );
        break;
    }
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: actions.map((a) {
      return GestureDetector(
        onTap: () => handle(a['label'] as String),
        child: Column(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: AppColors.txtfieldclr,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Icon(a['icon'] as IconData, color: AppColors.primaryclr),
            ),
            const SizedBox(height: 6),
            Text(a['label'] as String, style: const TextStyle(fontSize: 12)),
          ],
        ),
      );
    }).toList(),
  );
}

Widget buildSaveSmarterBanner() {
  return Container(
    padding: EdgeInsets.all(20.h),
    decoration: BoxDecoration(
      color: AppColors.txtfieldclr,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        SizedBox(width: 12.w),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: 'Save Smarter\n',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryclr,
              ),

              children: [
                TextSpan(
                  text: 'Automate your savings with\n',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryclr,
                  ),
                ),
                TextSpan(
                  text: 'Round-Up vaults.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryclr,
                  ),
                ),
              ],
            ),
          ),
        ),
        Icon(Icons.savings_outlined, color: AppColors.primaryclr, size: 35),
        SizedBox(width: 10.w),
      ],
    ),
  );
}

Widget buildRecentActivityHeader({required VoidCallback onViewAll}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        'Recent Activity',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      TextButton(
        onPressed: onViewAll,
        child: const Text(
          'View All',
          style: TextStyle(color: AppColors.primaryclr),
        ),
      ),
    ],
  );
}

Widget buildTransactionTile({
  required IconData icon,
  required String title,
  required String subtitle,
  required String amount,
  required bool isCredit,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color:
                (isCredit
                        ? Colors.blueAccent
                        : Color.fromARGB(255, 186, 26, 26))
                    .withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 20,
            color: isCredit ? Colors.green : Color.fromARGB(255, 186, 26, 26),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isCredit ? Colors.green : Colors.redAccent,
          ),
        ),
      ],
    ),
  );
}
