import 'package:flutter/material.dart';
import 'package:pakpay/Models/Ttransaction_model.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/view/transferscreens/Transfer_method_screen.dart';

class SendMoneyScreen extends StatefulWidget {
  final String? recipientName;
  final String? recipientDetail;
  final PaymentMethod method;

  const SendMoneyScreen({
    super.key,
    this.recipientName,
    this.recipientDetail,
    this.method = PaymentMethod.accountNumber,
  });

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final _searchController = TextEditingController();

  // Mock data
  final List<Map<String, String>> _recentBeneficiaries = [
    {'name': 'Ahmed', 'initials': 'A'},
    {'name': 'Zoya', 'initials': 'Z'},
    {'name': 'Bilal', 'initials': 'B'},
    {'name': 'Fatima', 'initials': 'F'},
    {'name': 'Hassan', 'initials': 'H'},
  ];

  final List<Map<String, String>> _favoriteContacts = [
    {'name': 'Sara Khan', 'account': '**** 4492', 'initials': 'SK'},
    {'name': 'Usman Ali', 'account': '**** 8821', 'initials': 'UA'},
    {'name': 'Rabia B.', 'account': '**** 1102', 'initials': 'RB'},
    {'name': 'Kashif M.', 'account': '**** 5634', 'initials': 'KM'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openTransferMethod({String? recipientName, String? account}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TransferMethodScreen(
          recipientName: recipientName,
          account: account,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Send Money',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none_outlined,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Search bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Beneficiary',
                hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: Colors.black38),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Quick Actions
          const Text(
            'QUICK ACTIONS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryclr,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _quickActionCard(
                icon: Icons.qr_code_scanner,
                label: 'Scan QR',
                onTap: () => _openTransferMethod(),
              ),
              const SizedBox(width: 12),
              _quickActionCard(
                icon: Icons.person_add_alt_1_outlined,
                label: 'New\nBeneficiary',
                onTap: () => _openTransferMethod(),
              ),
              const SizedBox(width: 12),
              _quickActionCard(
                icon: Icons.calendar_today_outlined,
                label: 'Schedule\nTransfer',
                onTap: () => _openTransferMethod(),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Recent Beneficiaries
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'RECENT BENEFICIARIES',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryclr,
                  letterSpacing: 1.1,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: AppColors.primaryclr,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _recentBeneficiaries.length,
              itemBuilder: (context, index) {
                final b = _recentBeneficiaries[index];
                final isFirst = index == 0;
                return GestureDetector(
                  onTap: () => _openTransferMethod(recipientName: b['name']),
                  child: Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                            border: isFirst
                                ? Border.all(
                                    color: AppColors.primaryclr,
                                    width: 2.5,
                                  )
                                : null,
                          ),
                          child: CircleAvatar(
                            backgroundColor: AppColors.primaryclr.withValues(
                              alpha: 0.15,
                            ),
                            child: Text(
                              b['initials']!,
                              style: const TextStyle(
                                color: AppColors.primaryclr,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          b['name']!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // Favorite Contacts
          const Text(
            'FAVORITE CONTACTS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryclr,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.9,
            ),
            itemCount: _favoriteContacts.length,
            itemBuilder: (context, index) {
              final contact = _favoriteContacts[index];
              return _favoriteContactCard(contact);
            },
          ),

          const SizedBox(height: 24),

          // Add New Beneficiary button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryclr,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () => _openTransferMethod(),
              icon: const Icon(Icons.add_circle_outline, color: Colors.white),
              label: const Text(
                'Add New Beneficiary',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _quickActionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.primaryclr.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: AppColors.primaryclr, size: 22),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _favoriteContactCard(Map<String, String> contact) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: AppColors.primaryclr.withValues(alpha: 0.12),
            child: Text(
              contact['initials']!,
              style: const TextStyle(
                color: AppColors.primaryclr,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            contact['name']!,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          const SizedBox(height: 2),
          Text(
            contact['account']!,
            style: const TextStyle(fontSize: 11, color: Colors.black45),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B3A4B),
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 0,
              ),
              onPressed: () => _openTransferMethod(
                recipientName: contact['name'],
                account: contact['account'],
              ),
              child: const Text(
                'Send',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
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
