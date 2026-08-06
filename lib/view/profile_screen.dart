import 'package:flutter/material.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/profile_screen_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _biometricEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          children: [
            ProfileAppBar(onBack: () => Navigator.pop(context)),
            const SizedBox(height: 20),
            buildProfileHeader(),
            const SizedBox(height: 24),
            buildMerchantBanner(),
            const SizedBox(height: 24),
            buildSectionLabel('ACCOUNT SETTINGS'),
            const SizedBox(height: 10),
            buildGroupCard([
              buildRow(
                icon: Icons.person_outline,
                label: 'Personal Information',
              ),
              buildRow(
                icon: Icons.credit_card_outlined,
                label: 'Account Limits',
              ),
              buildRow(
                icon: Icons.description_outlined,
                label: 'My Documents',
                isLast: true,
              ),
            ]),
            const SizedBox(height: 24),
            buildSectionLabel('SECURITY'),
            const SizedBox(height: 10),
            buildGroupCard([
              buildRow(icon: Icons.lock_outline, label: 'Change Password'),
              buildRow(icon: Icons.apps_outlined, label: 'Change MPIN'),
              buildRow(
                icon: Icons.fingerprint,
                label: 'Biometric Login',
                isLast: true,
                trailing: Switch(
                  value: _biometricEnabled,
                  activeThumbColor: Colors.white,
                  activeTrackColor: AppColors.primaryclr,
                  onChanged: (val) => setState(() => _biometricEnabled = val),
                ),
              ),
            ]),
            const SizedBox(height: 24),
            buildSectionLabel('PREFERENCES'),
            const SizedBox(height: 10),
            buildGroupCard([
              buildRow(icon: Icons.notifications_none, label: 'Notifications'),
              buildRow(
                icon: Icons.language,
                label: 'Language',
                trailingText: 'English',
              ),
              buildRow(
                icon: Icons.dark_mode_outlined,
                label: 'Theme',
                trailingText: 'Light',
                isLast: true,
              ),
            ]),
            const SizedBox(height: 24),
            buildSectionLabel('SUPPORT & LEGAL'),
            const SizedBox(height: 10),
            buildGroupCard([
              buildRow(icon: Icons.help_outline, label: 'Help Center'),
              buildRow(
                icon: Icons.privacy_tip_outlined,
                label: 'Privacy Policy',
              ),
              buildRow(
                icon: Icons.gavel_outlined,
                label: 'Terms of Service',
                isLast: true,
              ),
            ]),
            const SizedBox(height: 20),
            buildLogoutButton(),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'PakPay Version 2.4.1 (Build 108)',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}
