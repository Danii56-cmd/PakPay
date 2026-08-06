import 'package:flutter/material.dart';
import 'package:pakpay/core/app_colors.dart';

class ProfileAppBar extends StatelessWidget {
  final VoidCallback onBack;

  const ProfileAppBar({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onBack,
          child: const Icon(
            Icons.arrow_back,
            size: 24,
            color: AppColors.primaryclr,
          ),
        ),

        const Expanded(
          child: Text(
            'Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryclr,
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.all(6),
          child: const Icon(
            Icons.settings_outlined,
            size: 24,
            color: AppColors.primaryclr,
          ),
        ),
      ],
    );
  }
}

// ---------- Profile header ----------
Widget buildProfileHeader() {
  return Column(
    children: [
      Stack(
        children: [
          const CircleAvatar(
            radius: 46,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primaryclr,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(Icons.edit, color: Colors.white, size: 14),
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      const Text(
        'Ahmed Ali',
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      const SizedBox(height: 8),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.txtfieldclr,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Personal Account',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.secondaryclr,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}

// ---------- Become a merchant banner ----------
Widget buildMerchantBanner() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: AppColors.primaryclr,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: AppColors.primaryclr.withValues(alpha: 0.3),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.storefront_outlined,
            color: Colors.white,
            size: 22,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Become a Merchant',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Start accepting payments for your business',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right, color: Colors.white),
      ],
    ),
  );
} // ---------- Section label ----------

Widget buildSectionLabel(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      color: AppColors.secondaryclr.withValues(alpha: 0.7),
    ),
  );
}

// ---------- Group card wrapping multiple rows ----------
Widget buildGroupCard(List<Widget> rows) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(children: rows),
  );
}

// ---------- Individual settings row ----------
Widget buildRow({
  required IconData icon,
  required String label,
  bool isLast = false,
  String? trailingText,
  Widget? trailing,
}) {
  return Column(
    children: [
      InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, size: 21, color: AppColors.secondaryclr),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 14.5, color: Colors.black87),
                ),
              ),
              if (trailing != null)
                trailing
              else ...[
                if (trailingText != null)
                  Text(
                    trailingText,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: AppColors.secondaryclr,
                    ),
                  ),
                const SizedBox(width: 4),
                const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
              ],
            ],
          ),
        ),
      ),
      if (!isLast) const Divider(height: 1, indent: 16, endIndent: 16),
    ],
  );
}
// ---------- Log out button ----------
  Widget buildLogoutButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(18),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout, color: Colors.red, size: 18),
              SizedBox(width: 8),
              Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }