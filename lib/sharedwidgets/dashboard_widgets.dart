import 'package:flutter/material.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/view/dashboard_screens.dart';
import 'package:pakpay/view/more_screen.dart';

Widget buildAppBar() {
  return Row(
    children: [
      const CircleAvatar(
        radius: 20,
        backgroundColor: Color(0xFFE3F1FF),
        backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
      ),
      const SizedBox(width: 10),
      const Text(
        'PakPay',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryclr,
        ),
      ),
      const Spacer(),
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: const Icon(
          Icons.notifications_none,
          size: 22,
          color: Colors.black87,
        ),
      ),
    ],
  );
}

Widget buildWelcome() {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Welcome back,', style: TextStyle(fontSize: 15, color: Colors.grey)),
      SizedBox(height: 2),
      Text(
        'Khan',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    ],
  );
}

// ---------- Quick actions ----------
  Widget buildQuickActions(BuildContext context) {
    final actions = [
      {
        'icon': Icons.send,
        'label': 'Send',
        'onTap': () {
          print("Send tapped");
        },
      },
      {
        'icon': Icons.add_card,
        'label': 'Deposit',
        'onTap': () {
          print("Deposit tapped");
        },
      },
      {
        'icon': Icons.receipt_long,
        'label': 'Bills',
        'onTap': () {
          print("Bills tapped");
        },
      },
      {
        'icon': Icons.more_horiz,
        'label': 'More',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AllActionsScreen()),
          );
        },
      },
    ];
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: actions.map((a) {
      return InkWell(
  borderRadius: BorderRadius.circular(40),
  onTap: a['onTap'] as VoidCallback,
  child: Column(
    children: [
      Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: AppColors.txtfieldclr,
          shape: BoxShape.circle,
        ),
        child: Icon(
          a['icon'] as IconData,
          color: AppColors.primaryclr,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        a['label'] as String,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.black87,
        ),
      ),
    ],
  ),
);
    }).toList(),
  );
}

// ---------- Save smarter banner ----------
Widget buildSaveSmarterBanner() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: AppColors.txtfieldclr,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Save Smarter',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryclr,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Automate your savings with Round-Up vaults.',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.secondaryclr.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Icon(Icons.savings_outlined, size: 34, color: AppColors.primaryclr),
      ],
    ),
  );
}

// ---------- Recent activity header ----------
Widget buildRecentActivityHeader() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        'Recent Activity',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      Text(
        'View All',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryclr,
        ),
      ),
    ],
  );
}

// ---------- Transaction tile ----------
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
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F2F6),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.black54, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: isCredit ? AppColors.primaryclr : Colors.red,
          ),
        ),
      ],
    ),
  );
}
