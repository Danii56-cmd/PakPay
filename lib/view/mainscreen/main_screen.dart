import 'package:flutter/material.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/view/QRscreens/QR_code_screen.dart';
import 'package:pakpay/view/contactpickerscreen/contact_picker_screen.dart';
import 'package:pakpay/view/dashboard/dashboard_screens.dart';
import 'package:pakpay/view/historyscreen/history_screen.dart';
import 'package:pakpay/view/profilescreen/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    // const PaymentsScreen(),
    const ContactPickerScreen(),
    const ScanQrScreen(),
    const HistoryScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildBottomNavigation() {
    final items = [
      {'icon': Icons.home_filled, 'label': 'Home'},
      {'icon': Icons.payments_outlined, 'label': 'Payments'},
      null,
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
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (index) {
                if (items[index] == null) {
                  return const SizedBox(width: 60);
                }

                final item = items[index] as Map<String, dynamic>;

                return InkWell(
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item['icon'],
                          color: _currentIndex == index
                              ? AppColors.primaryclr
                              : Colors.grey,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item['label'],
                          style: TextStyle(
                            fontSize: 11,
                            color: _currentIndex == index
                                ? AppColors.primaryclr
                                : Colors.grey,
                          ),
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
                setState(() {
                  _currentIndex = 2;
                });
              },
              child: Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                ),
                child: const Icon(Icons.qr_code_2, color: Colors.white),
              ),
            ),
          ),

          const Positioned(
            top: 46,
            child: Text("QR", style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }
}
