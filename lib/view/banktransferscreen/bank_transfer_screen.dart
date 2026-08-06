import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/view/auth/internal_transfer_screen.dart';

class BankTransferScreen extends StatefulWidget {
  final String? recipientName;
  final String? account;

  const BankTransferScreen({super.key, this.recipientName, this.account});

  @override
  State<BankTransferScreen> createState() => _BankTransferScreenState();
}

class _BankTransferScreenState extends State<BankTransferScreen> {
  String _selectedBank = 'Habib Bank Limited';
  final _accountController = TextEditingController();
  bool _saveAsBeneficiary = false;

  final List<String> _banks = [
    'Habib Bank Limited',
    'United Bank Limited',
    'MCB Bank',
    'Allied Bank',
    'Bank Alfalah',
    'Meezan Bank',
    'Standard Chartered',
    'Faysal Bank',
    'Askari Bank',
    'Bank of Punjab',
  ];

  @override
  void dispose() {
    _accountController.dispose();
    super.dispose();
  }

  void _showBankPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 16.h),
          const Text(
            'Select Bank',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 8.h),
          ...(_banks.map(
            (bank) => ListTile(
              leading: const Icon(
                Icons.account_balance_outlined,
                color: AppColors.primaryclr,
              ),
              title: Text(bank),
              trailing: _selectedBank == bank
                  ? const Icon(Icons.check_circle, color: AppColors.primaryclr)
                  : null,
              onTap: () {
                setState(() => _selectedBank = bank);
                Navigator.pop(context);
              },
            ),
          )),
          SizedBox(height: 16.h),
        ],
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
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryclr),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Bank Transfer',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
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
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.h),
              children: [
                // Hero banner card
                Container(
                  width: double.infinity,
                  height: 160.h,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1B6B45), Color(0xFF2E9B66)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      // Watermark icon
                      Positioned(
                        right: -10,
                        bottom: -10,
                        child: Icon(
                          Icons.account_balance,
                          size: 120,
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Secure Link',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Transfer funds instantly to any bank\nin Pakistan.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                // Form card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Select Bank label
                      const Text(
                        'Select Bank',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.primaryclr,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Bank dropdown
                      GestureDetector(
                        onTap: _showBankPicker,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F4F7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.account_balance_outlined,
                                  color: AppColors.primaryclr,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    _selectedBank,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black45,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Account Number / IBAN label
                      const Text(
                        'Account Number or IBAN',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.primaryclr,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // IBAN input
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F4F7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: _accountController,
                          style: const TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'PK00 HABB 0000 0000 0000 0000',
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                              fontSize: 13,
                            ),
                            suffixIcon: const Icon(
                              Icons.info_outline,
                              color: Colors.black26,
                              size: 18,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF2F4F7),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Save as Beneficiary toggle
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F4F7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: AppColors.primaryclr.withValues(
                                  alpha: 0.1,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.person_add_alt_1_outlined,
                                color: AppColors.primaryclr,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Save as Beneficiary',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    'Add to quick transfers list',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Switch(
                              value: _saveAsBeneficiary,
                              activeThumbColor: Colors.white,
                              activeTrackColor: AppColors.primaryclr,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: AppColors.txtfieldclr,
                              trackOutlineColor: WidgetStateProperty.all(
                                Colors.black12,
                              ),
                              onChanged: (v) =>
                                  setState(() => _saveAsBeneficiary = v),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Security note
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.verified_user_outlined,
                        color: AppColors.primaryclr,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Your transaction is protected by 256-bit AES encryption. PakPay ensures that your financial data remains private and secure at all times.',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primaryclr.withValues(alpha: 0.85),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),

          // Continue button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryclr,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  () {
                    final account = _accountController.text.trim();
                    if (account.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please enter an account number or IBAN',
                          ),
                        ),
                      );
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InternalTransferScreen(
                          recipientName: _selectedBank,
                          account: account,
                        ),
                      ),
                    );
                  };
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.chevron_right, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
