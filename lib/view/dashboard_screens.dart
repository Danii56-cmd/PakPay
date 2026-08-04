import 'package:flutter/material.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/app_state.dart';
import 'package:pakpay/sharedwidgets/dashboard_widgets.dart';
import 'package:pakpay/view/QR_code_screen.dart';
import 'package:pakpay/view/auth/Models/Ttransaction_model.dart';
import 'package:pakpay/view/contact_picker_screen.dart';
import 'package:pakpay/view/history_screen.dart';
import 'package:pakpay/view/profile_screen.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _balanceHidden = true;
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(gradient: AppColors.bgclr),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            children: [
              buildAppBar(),
              const SizedBox(height: 20),
              buildWelcome(),
              const SizedBox(height: 16),
              _buildBalanceCard(),
              const SizedBox(height: 24),
              buildQuickActions(context),
              const SizedBox(height: 20),
              buildSaveSmarterBanner(),
              const SizedBox(height: 24),
              buildRecentActivityHeader(onViewAll: () => _openHistory(context)),
              const SizedBox(height: 12),
              ValueListenableBuilder<List<TransactionModel>>(
                valueListenable: AppState.instance.transactions,
                builder: (context, txs, _) {
                  final recent = txs.take(3).toList();
                  return Column(
                    children: [
                      for (int i = 0; i < recent.length; i++) ...[
                        buildTransactionTile(
                          icon: recent[i].icon,
                          title: recent[i].title,
                          subtitle: recent[i].subtitle,
                          amount: recent[i].formattedAmount,
                          isCredit: recent[i].isCredit,
                        ),
                        if (i != recent.length - 1) const SizedBox(height: 12),
                      ],
                    ],
                  );
                },
              ),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  void _openHistory(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
  }

  void _openMyQr(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const ScanQrScreen()));
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryclr,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: AppColors.primaryclr.withValues(alpha: 0.35), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Total Balance', style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: () => setState(() => _balanceHidden = !_balanceHidden),
                child: Icon(
                  _balanceHidden ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white70,
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _balanceHidden
                    ? Row(
                        children: List.generate(
                          8,
                          (i) => Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: Container(
                              width: 9,
                              height: 9,
                              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            ),
                          ),
                        ),
                      )
                    : ValueListenableBuilder<double>(
                        valueListenable: AppState.instance.balance,
                        builder: (context, balance, _) => Text(
                          'PKR ${balance.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                      ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: () => _openMyQr(context),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), shape: BoxShape.circle),
                  child: const Icon(Icons.qr_code_2, color: Colors.white, size: 24),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.trending_up, color: Colors.white, size: 14),
                const SizedBox(width: 4),
                const Text('+2.4%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(width: 6),
                Text('vs last month', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Bottom navigation bar ----------
  Widget _buildBottomNavBar() {
    final items = [
      {'icon': Icons.home_filled, 'label': 'Home'},
      {'icon': Icons.payments_outlined, 'label': 'Payments'},
      null, // placeholder for the raised QR button
      {'icon': Icons.history, 'label': 'History'},
      {'icon': Icons.person_outline, 'label': 'Profile'},
    ];

    void handleTap(int index) {
      setState(() => _navIndex = index);
      switch (index) {
        case 1:
          Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactPickerScreen()));
          break;
        case 3:
          Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
          break;
        case 4:
          Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
          break;
      }
    }

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
                BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, -2)),
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
                  onTap: () => handleTap(index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(item['icon'] as IconData, color: color, size: 22),
                        const SizedBox(height: 3),
                        Text(item['label'] as String, style: TextStyle(fontSize: 11, color: color)),
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
              onTap: () {
                setState(() => _navIndex = 2);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ScanQrScreen()));
              },
              child: Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1C),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: const Icon(Icons.qr_code_2, color: Colors.white, size: 26),
              ),
            ),
          ),
          const Positioned(
            top: 46,
            child: Text('QR', style: TextStyle(fontSize: 11, color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}