import 'package:flutter/material.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/app_state.dart';
import 'package:pakpay/view/Transfer_success_screen.dart';

class InternalTransferScreen extends StatefulWidget {
  final String? recipientName;
  final String? account;

  const InternalTransferScreen({super.key, this.recipientName, this.account});

  @override
  State<InternalTransferScreen> createState() => _InternalTransferScreenState();
}

class _InternalTransferScreenState extends State<InternalTransferScreen> {
  String _amountDisplay = '0';
  final _noteController = TextEditingController();

  final List<int> _quickAmounts = [1000, 5000, 10000];

  void _setQuickAmount(int amount) {
    setState(() => _amountDisplay = amount.toString());
  }

  void _setMax() {
    final balance = AppState.instance.balance.value;
    setState(() => _amountDisplay = balance.toStringAsFixed(0));
  }

  void _onKeyTap(String key) {
    setState(() {
      if (key == '⌫') {
        if (_amountDisplay.length > 1) {
          _amountDisplay = _amountDisplay.substring(
            0,
            _amountDisplay.length - 1,
          );
        } else {
          _amountDisplay = '0';
        }
      } else if (key == '.') {
        if (!_amountDisplay.contains('.')) {
          _amountDisplay += '.';
        }
      } else {
        if (_amountDisplay == '0') {
          _amountDisplay = key;
        } else {
          _amountDisplay += key;
        }
      }
    });
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final balance = AppState.instance.balance.value;

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
          'Internal Transfer',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: AppColors.primaryclr),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // FROM ACCOUNT card
                Container(
                  padding: const EdgeInsets.all(16),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'FROM ACCOUNT',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                              letterSpacing: 0.8,
                            ),
                          ),
                          Icon(
                            Icons.check_circle,
                            color: AppColors.primaryclr,
                            size: 18,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: AppColors.primaryclr.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.account_balance_wallet_outlined,
                              color: AppColors.primaryclr,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Digital Wallet',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                const Text(
                                  '0982-1234567-01',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Available\nBalance',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black45,
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Rs. ${balance.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: AppColors.primaryclr,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Swap icon
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryclr.withValues(alpha: 0.3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.swap_vert,
                      color: AppColors.primaryclr,
                      size: 20,
                    ),
                  ),
                ),

                // TO ACCOUNT card
                Container(
                  padding: const EdgeInsets.all(16),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'TO ACCOUNT',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black45,
                            size: 18,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(
                            Icons.account_balance_outlined,
                            color: AppColors.primaryclr,
                            size: 22,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.recipientName != null
                                ? '${widget.recipientName}  (${widget.account ?? '....8772'})'
                                : 'Habib Bank Limited  (....8772)',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Tap to change destination',
                        style: TextStyle(fontSize: 12, color: Colors.black38),
                      ),
                      const SizedBox(height: 4),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.black26,
                        size: 16,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Amount entry
                const Center(
                  child: Text(
                    'Enter Amount',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Big amount display
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Rs.',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryclr,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _amountDisplay,
                      style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.w300,
                        color: _amountDisplay == '0'
                            ? Colors.black12
                            : Colors.black87,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Quick amount chips
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ..._quickAmounts.map(
                      (a) => GestureDetector(
                        onTap: () => _setQuickAmount(a),
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Text(
                            _formatAmount(a),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _setMax,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: const Text(
                          'Max',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Note field
                const Text(
                  'Note (Optional)',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextField(
                    controller: _noteController,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: "What's this for?",
                      hintStyle: const TextStyle(
                        color: Colors.black26,
                        fontSize: 13,
                      ),
                      suffixIcon: const Icon(
                        Icons.edit_note,
                        color: Colors.black26,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Instant Transfer info
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.primaryclr.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.primaryclr.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.info_outline,
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
                              'Instant Transfer',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Funds will be moved instantly between your accounts. No transaction fees apply for internal transfers.',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                height: 1.4,
                              ),
                            ),
                          ],
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
                  final amount = double.tryParse(_amountDisplay) ?? 0;
                  if (amount <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Enter an amount to transfer'),
                      ),
                    );
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TransferSuccessScreen(
                        amount: amount,
                        recipientLabel: widget.recipientName != null
                            ? '${widget.recipientName} (${widget.account ?? '....8772'})'
                            : 'Savings Account (${widget.account ?? '....8772'})',
                        bankName:
                            widget.recipientName ?? 'PakPay Microfinance Bank',
                        transactionId:
                            'PK-${DateTime.now().millisecondsSinceEpoch % 1000000000}',
                        dateTime: DateTime.now(),
                      ),
                    ),
                  );
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
                    Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatAmount(int amount) {
    if (amount >= 1000) return '${amount ~/ 1000},000';
    return amount.toString();
  }
}
