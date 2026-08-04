import 'package:flutter/material.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/app_state.dart';
import 'package:pakpay/view/QR_code_screen.dart';
import 'package:pakpay/view/contact_picker_screen.dart';
import 'package:pakpay/view/my_qrcode.dart';

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
    {'icon': Icons.qr_code_2, 'label': 'Receive'},
    {'icon': Icons.add_card_outlined, 'label': 'Top Up'},
    {'icon': Icons.receipt_long_outlined, 'label': 'Bills'},
  ];

  void handle(String label) {
    switch (label) {
      case 'Send':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ContactPickerScreen()),
        );
        break;
      case 'Receive':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MyQrScreen()),
        );
        break;
      default:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$label coming soon')));
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
                color: Colors.white,
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
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: const [
        Icon(Icons.savings_outlined, color: Color(0xFFE17055), size: 30),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            'Save smarter — round up your payments and grow your savings automatically.',
            style: TextStyle(fontSize: 13),
          ),
        ),
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
      TextButton(onPressed: onViewAll, child: const Text('View All')),
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
            color: (isCredit ? Colors.green : Colors.redAccent).withValues(
              alpha: 0.1,
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 20,
            color: isCredit ? Colors.green : Colors.redAccent,
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
