import 'package:flutter/material.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/more_screens_widgets.dart';

class AllActionsScreen extends StatefulWidget {
  const AllActionsScreen({super.key});

  @override
  State<AllActionsScreen> createState() => _AllActionsScreenState();
}

class _AllActionsScreenState extends State<AllActionsScreen> {
  int _navIndex = 2; // QR tab highlighted like the screenshot context

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          children: [
            _buildAppBar(),
            const SizedBox(height: 20),
            buildSectionLabel('MONEY & PAYMENTS'),
            const SizedBox(height: 12),
            _buildActionGrid([
              _ActionItem(Icons.qr_code_scanner, 'Scan QR'),
              _ActionItem(Icons.qr_code_2, 'My QR'),
              _ActionItem(Icons.send, 'Send Money'),
              _ActionItem(Icons.request_page_outlined, 'Request'),
              _ActionItem(Icons.compare_arrows, 'Transfer'),
              _ActionItem(Icons.history, 'History'),
            ]),
            const SizedBox(height: 24),
            buildSectionLabel('SERVICES'),
            const SizedBox(height: 12),
            _buildActionGrid([
              _ActionItem(Icons.receipt_long_outlined, 'Bills'),
              _ActionItem(Icons.phone_iphone, 'Top-up'),
              _ActionItem(Icons.storefront_outlined, 'Merchants'),
            ]),
            const SizedBox(height: 24),
            buildSectionLabel('FINANCES'),
            const SizedBox(height: 12),
            _buildActionGrid([
              _ActionItem(Icons.savings_outlined, 'Savings'),
              _ActionItem(Icons.volunteer_activism_outlined, 'Loans'),
              _ActionItem(Icons.credit_card_outlined, 'Cards'),
            ]),
            const SizedBox(height: 24),
            _buildInvestmentBanner(),
            const SizedBox(height: 90),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // ---------- App bar ----------
  Widget _buildAppBar() {
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
        const Icon(Icons.search, size: 22, color: Colors.black87),
        const SizedBox(width: 18),
        const Icon(Icons.more_vert, size: 22, color: Colors.black87),
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
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
              color: AppColors.primaryclr.withOpacity(0.12),
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
    );
  }

  // ---------- Investment banner ----------
  Widget _buildInvestmentBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1E1B),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Stack(
        children: [
          // Decorative soft circles in the background
          Positioned(
            right: -20,
            top: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryclr.withOpacity(0.18),
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
                color: AppColors.primaryclr.withOpacity(0.14),
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
                        color: Colors.white.withOpacity(0.75),
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
                  color: Colors.white.withOpacity(0.15),
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
    );
  }

  Widget _buildBottomNavBar() {
    final items = [
      {'icon': Icons.home_filled, 'label': 'Home'},
      {'icon': Icons.payments_outlined, 'label': 'Payments'},
      null, // placeholder for the raised QR button
      {'icon': Icons.history, 'label': 'History'},
      {'icon': Icons.person_outline, 'label': 'Profile'},
    ];

    return SizedBox(
      height: 78,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (index) {
                if (items[index] == null) {
                  return const SizedBox(width: 60);
                }
                final item = items[index] as Map<String, dynamic>;
                final selected = _navIndex == index;
                final color = selected ? AppColors.primaryclr : Colors.black54;
                return InkWell(
                  onTap: () => setState(() => _navIndex = index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(item['icon'] as IconData, color: color, size: 22),
                        const SizedBox(height: 3),
                        Text(
                          item['label'] as String,
                          style: TextStyle(fontSize: 11, color: color),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          Positioned(
            top: -18,
            child: GestureDetector(
              onTap: () => setState(() => _navIndex = 2),
              child: Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1C),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.qr_code_2,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 46,
            child: Text(
              'QR',
              style: TextStyle(fontSize: 11, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionItem {
  final IconData icon;
  final String label;
  const _ActionItem(this.icon, this.label);
}
