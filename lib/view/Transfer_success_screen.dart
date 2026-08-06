import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/view/Transfer_screen_recipt_screen.dart';

/// Shown right after a transfer completes successfully.
class TransferSuccessScreen extends StatelessWidget {
  final double amount;
  final String recipientLabel; // e.g. "Savings Account (...8772)"
  final String bankName; // e.g. "PakPay Microfinance Bank"
  final String transactionId; // e.g. "PK-829402184"
  final DateTime dateTime;
  final String paymentMode; // e.g. "Account Transfer"

  const TransferSuccessScreen({
    super.key,
    required this.amount,
    required this.recipientLabel,
    required this.bankName,
    required this.transactionId,
    required this.dateTime,
    this.paymentMode = 'Account Transfer',
  });

  String get _formattedAmount => 'Rs. ${amount.toStringAsFixed(2)}';

  String get _formattedDateTime {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = months[dateTime.month - 1];
    final year = dateTime.year;
    final hour24 = dateTime.hour;
    final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour24 >= 12 ? 'PM' : 'AM';
    return '$day,$month,$year, $hour12:$minute $period';
  }

  void _openReceipt(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TransactionReceiptScreen(
          amount: amount,
          recipientLabel: recipientLabel,
          bankName: bankName,
          transactionId: transactionId,
          dateTime: dateTime,
          paymentMode: paymentMode,
        ),
      ),
    );
  }

  void _copyReceiptSummary(BuildContext context) {
    final text =
        'PakPay Transfer\n$_formattedAmount to $recipientLabel\nTxn ID: $transactionId\n$_formattedDateTime';
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Receipt details copied')));
  }

  void _done(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'PakPay',
                    style: TextStyle(
                      color: AppColors.primaryclr,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.primaryclr.withValues(
                      alpha: 0.12,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: AppColors.primaryclr,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 32),

                    // Success icon
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        color: AppColors.primaryclr.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryclr,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 34,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Transfer Successful',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your funds have been moved successfully.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withValues(alpha: 0.5),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Details card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Amount',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black.withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    _formattedAmount,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryclr,
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(14),
                                onTap: () => _openReceipt(context),
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryclr.withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Icon(
                                    Icons.receipt_long_outlined,
                                    color: AppColors.primaryclr,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          const Divider(height: 1),
                          const SizedBox(height: 18),
                          _DetailRow(
                            label: 'To Recipient',
                            value: recipientLabel,
                          ),
                          const SizedBox(height: 14),
                          _DetailRow(
                            label: 'Transaction ID',
                            value: transactionId,
                          ),
                          const SizedBox(height: 14),
                          _DetailRow(
                            label: 'Date & Time',
                            value: _formattedDateTime,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    InkWell(
                      onTap: () => _openReceipt(context),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.file_download_outlined,
                            size: 18,
                            color: AppColors.primaryclr,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Download Receipt',
                            style: TextStyle(
                              color: AppColors.primaryclr,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    InkWell(
                      onTap: () => _copyReceiptSummary(context),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.ios_share_outlined,
                            size: 18,
                            color: AppColors.primaryclr,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Share Receipt',
                            style: TextStyle(
                              color: AppColors.primaryclr,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Done button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryclr,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => _done(context),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.black.withValues(alpha: 0.5),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
