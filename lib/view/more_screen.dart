import 'package:flutter/material.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/more_screens_widgets.dart';
import 'package:pakpay/view/QR_code_screen.dart';
import 'package:pakpay/view/contact_picker_screen.dart';
import 'package:pakpay/view/history_screen.dart';
import 'package:pakpay/view/my_qrcode.dart';

class AllActionsScreen extends StatefulWidget {
  const AllActionsScreen({super.key});

  @override
  State<AllActionsScreen> createState() => _AllActionsScreenState();
}

class _AllActionsScreenState extends State<AllActionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          children: [
            _buildAppBar(context),
            const SizedBox(height: 20),
            buildSectionLabel('MONEY & PAYMENTS'),
            const SizedBox(height: 12),
            _buildActionGrid([
              _ActionItem(
                Icons.qr_code_scanner,
                'Scan QR',
                () => _openScanQr(context),
              ),
              _ActionItem(Icons.qr_code_2, 'My QR', () => _openMyQr(context)),
              _ActionItem(
                Icons.send,
                'Send Money',
                () => _openSendMoney(context),
              ),
              _ActionItem(
                Icons.request_page_outlined,
                'Request',
                () => _comingSoon(context, 'Payment requests'),
              ),
              _ActionItem(
                Icons.compare_arrows,
                'Transfer',
                () => _comingSoon(context, 'Bank transfer'),
              ),
              _ActionItem(
                Icons.history,
                'History',
                () => _openHistory(context),
              ),
            ]),
            const SizedBox(height: 24),
            buildSectionLabel('SERVICES'),
            const SizedBox(height: 12),
            _buildActionGrid([
              _ActionItem(
                Icons.receipt_long_outlined,
                'Bills',
                () => _comingSoon(context, 'Bill payments'),
              ),
              _ActionItem(
                Icons.phone_iphone,
                'Top-up',
                () => _comingSoon(context, 'Mobile top-up'),
              ),
              _ActionItem(
                Icons.storefront_outlined,
                'Merchants',
                () => _comingSoon(context, 'Merchant directory'),
              ),
            ]),
            const SizedBox(height: 24),
            buildSectionLabel('FINANCES'),
            const SizedBox(height: 12),
            _buildActionGrid([
              _ActionItem(
                Icons.savings_outlined,
                'Savings',
                () => _comingSoon(context, 'Savings vaults'),
              ),
              _ActionItem(
                Icons.volunteer_activism_outlined,
                'Loans',
                () => _comingSoon(context, 'Loans'),
              ),
              _ActionItem(
                Icons.credit_card_outlined,
                'Cards',
                () => _comingSoon(context, 'Card management'),
              ),
            ]),
            const SizedBox(height: 24),
            _buildInvestmentBanner(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // ---------- navigation helpers ----------
  void _openScanQr(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ScanQrScreen()),
    );
  }

  void _openMyQr(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MyQrScreen()),
    );
  }

  void _openSendMoney(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ContactPickerScreen()),
    );
  }

  void _openHistory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const HistoryScreen()),
    );
  }

  void _comingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature is coming soon'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ---------- App bar ----------
  Widget _buildAppBar(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.maybePop(context),
          child: const Icon(Icons.arrow_back, size: 24, color: Colors.black87),
        ),
        const SizedBox(width: 14),
        const Text(
          'All Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () => _comingSoon(context, 'Search'),
          child: const Icon(Icons.search, size: 22, color: Colors.black87),
        ),
        const SizedBox(width: 18),
        InkWell(
          onTap: () => _comingSoon(context, 'More options'),
          child: const Icon(Icons.more_vert, size: 22, color: Colors.black87),
        ),
      ],
    );
  }

  // ---------- Action grid (3 columns) ----------
  Widget _buildActionGrid(List<_ActionItem> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.92,
      ),
      itemBuilder: (context, index) => _buildActionTile(items[index]),
    );
  }

  Widget _buildActionTile(_ActionItem item) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: item.onTap,
      child: Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.primaryclr.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(item.icon, color: AppColors.primaryclr, size: 22),
            ),
            const SizedBox(height: 10),
            Text(
              item.label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Investment banner ----------
  Widget _buildInvestmentBanner(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () => _comingSoon(context, 'Investment portfolio'),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF0E1E1B),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -30,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryclr.withValues(alpha: 0.18),
                ),
              ),
            ),
            Positioned(
              right: 30,
              bottom: -30,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryclr.withValues(alpha: 0.14),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New Feature',
                        style: TextStyle(
                          color: AppColors.primaryclr,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Investment Portfolio',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Start growing your wealth from as little as \$1.',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.75),
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 46,
                  height: 46,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.trending_up,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ActionItem(this.icon, this.label, this.onTap);
}
