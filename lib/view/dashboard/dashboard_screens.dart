// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/app_state.dart';
import 'package:pakpay/sharedwidgets/dashboard_widgets.dart';
import 'package:pakpay/Models/Ttransaction_model.dart';
import 'package:pakpay/view/QRscreens/QR_code_screen.dart';
import 'package:pakpay/view/contactpickerscreen/contact_picker_screen.dart';
import 'package:pakpay/view/historyscreen/history_screen.dart';
import 'package:pakpay/view/profilescreen/profile_screen.dart';

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
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            children: [
              buildAppBar(),
              SizedBox(height: 20.h),
              buildWelcome(),
              SizedBox(height: 16.h),
              _buildBalanceCard(),
              SizedBox(height: 30.h),
              buildQuickActions(context),
              SizedBox(height: 20.h),
              buildSaveSmarterBanner(),
              SizedBox(height: 24.h),
              buildRecentActivityHeader(onViewAll: () => _openHistory(context)),
              SizedBox(height: 12.h),
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
              SizedBox(height: 90.h),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  void _openHistory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const HistoryScreen()),
    );
  }

  void _openMyQr(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ScanQrScreen()),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.h),
      decoration: BoxDecoration(
        color: AppColors.primaryclr,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryclr.withValues(alpha: 0.35),
            blurRadius: 20.r,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Total Balance',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              SizedBox(width: 6.w),
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
          SizedBox(height: 18.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _balanceHidden
                    ? Row(
                        children: List.generate(
                          8,
                          (i) => Padding(
                            padding: EdgeInsets.only(right: 6.w),
                            child: Container(
                              width: 9.w,
                              height: 9.h,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      )
                    : ValueListenableBuilder<double>(
                        valueListenable: AppState.instance.balance,
                        builder: (context, balance, _) => Text(
                          'PKR ${balance.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(999.r),
                onTap: () => _openMyQr(context),
                child: Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.qr_code_2,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.trending_up, color: Colors.white, size: 14),
                SizedBox(width: 4.w),
                const Text(
                  '+2.4%',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  'vs last month',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 12,
                  ),
                ),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ContactPickerScreen()),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const HistoryScreen()),
          );
          break;
        case 4:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfileScreen()),
          );
          break;
      }
    }

    return SizedBox(
      height: 78.h,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 12.r,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (index) {
                if (items[index] == null) {
                  return SizedBox(width: 60.w);
                }
                final item = items[index] as Map<String, dynamic>;
                final selected = _navIndex == index;
                final color = selected ? AppColors.primaryclr : Colors.black54;
                return InkWell(
                  onTap: () => handleTap(index),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
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
              onTap: () {
                setState(() => _navIndex = 2);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ScanQrScreen()),
                );
              },
              child: Container(
                width: 58.w,
                height: 58.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1C),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
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
          Positioned(
            top: 46.h,
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
