import 'package:flutter/material.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/view/auth/internal_transfer_screen.dart';
import 'package:pakpay/view/banktransferscreen/bank_transfer_screen.dart';

class TransferMethodScreen extends StatelessWidget {
  final String? recipientName;
  final String? account;

  const TransferMethodScreen({super.key, this.recipientName, this.account});

  @override
  Widget build(BuildContext context) {
    final methods = [
      _MethodItem(
        icon: Icons.account_balance_wallet_outlined,
        title: 'Own Account',
        subtitle: 'Transfer between your PakPay accounts',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => InternalTransferScreen(
              recipientName: recipientName,
              account: account,
            ),
          ),
        ),
      ),
      _MethodItem(
        icon: Icons.person_outline,
        title: 'PakPay User',
        subtitle: 'Send using Phone, Email or ID',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => InternalTransferScreen(
              recipientName: recipientName,
              account: account,
            ),
          ),
        ),
      ),
      _MethodItem(
        icon: Icons.account_balance_outlined,
        title: 'Bank Account',
        subtitle: 'Send to any local bank via IBAN',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BankTransferScreen(
              recipientName: recipientName,
              account: account,
            ),
          ),
        ),
      ),
      _MethodItem(
        icon: Icons.smartphone_outlined,
        title: 'Mobile Number',
        subtitle: 'Quick transfer to mobile wallet',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BankTransferScreen(
              recipientName: recipientName,
              account: account,
            ),
          ),
        ),
      ),
      _MethodItem(
        icon: Icons.badge_outlined,
        title: 'CNIC',
        subtitle: 'Send to any CNIC for cash pickup',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BankTransferScreen(
              recipientName: recipientName,
              account: account,
            ),
          ),
        ),
      ),
      _MethodItem(
        icon: Icons.qr_code_scanner,
        title: 'QR Transfer',
        subtitle: 'Scan to pay instantly',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BankTransferScreen(
              recipientName: recipientName,
              account: account,
            ),
          ),
        ),
      ),
      _MethodItem(
        icon: Icons.storefront_outlined,
        title: 'Merchant Payment',
        subtitle: 'Directly pay at supported stores and vendors',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BankTransferScreen(
              recipientName: recipientName,
              account: account,
            ),
          ),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryclr),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Transfer Method',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black54),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primaryclr.withValues(alpha: 0.15),
              child: const Icon(
                Icons.person,
                color: AppColors.primaryclr,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: const Text(
              "Choose your preferred way to move funds safely and securely with PakPay's encrypted infrastructure.",
              style: TextStyle(
                fontSize: 13,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: methods.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final m = methods[index];
                return GestureDetector(
                  onTap: m.onTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.primaryclr.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            m.icon,
                            color: AppColors.primaryclr,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                m.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                m.subtitle,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black45,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: Colors.black26,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.security_outlined, size: 14, color: Colors.black38),
                SizedBox(width: 6),
                Text(
                  'PCI-DSS Level 1 Encrypted Secure Payments',
                  style: TextStyle(fontSize: 11, color: Colors.black38),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.home_filled, 'Home', false),
          _navItem(Icons.payments_outlined, 'Payments', true),
          _qrButton(),
          _navItem(Icons.history, 'History', false),
          _navItem(Icons.person_outline, 'Profile', false),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool active) {
    final color = active ? AppColors.primaryclr : Colors.black45;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 3),
        Text(label, style: TextStyle(fontSize: 11, color: color)),
      ],
    );
  }

  Widget _qrButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: Color(0xFF1C1C1C),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.qr_code_2, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 2),
        const Text('QR', style: TextStyle(fontSize: 11, color: Colors.black87)),
      ],
    );
  }
}

class _MethodItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MethodItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}
