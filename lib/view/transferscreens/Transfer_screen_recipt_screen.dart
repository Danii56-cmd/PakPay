import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pakpay/core/app_colors.dart';

/// Full transaction receipt, reachable from the success screen or from
/// a transaction tile in History.
class TransactionReceiptScreen extends StatelessWidget {
  final double amount;
  final String recipientLabel; // e.g. "Savings Account ...8772"
  final String bankName; // e.g. "PakPay Microfinance Bank"
  final String transactionId; // e.g. "PK-829402184"
  final DateTime dateTime;
  final String paymentMode; // e.g. "Account Transfer"
  final String status; // e.g. "Completed"

  const TransactionReceiptScreen({
    super.key,
    required this.amount,
    required this.recipientLabel,
    required this.bankName,
    required this.transactionId,
    required this.dateTime,
    this.paymentMode = 'Account Transfer',
    this.status = 'Completed',
  });

  String get _formattedAmount => 'Rs. ${amount.toStringAsFixed(2)}';

  String get _formattedDateTime {
    const months = [
      'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC',
    ];
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = months[dateTime.month - 1];
    final year = dateTime.year;
    final hour24 = dateTime.hour;
    final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour24 >= 12 ? 'PM' : 'AM';
    return '$month $day, $year, $hour12:$minute $period';
  }

  void _copyTransactionId(BuildContext context) {
    Clipboard.setData(ClipboardData(text: transactionId));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transaction ID copied')),
    );
  }

  void _shareReceipt(BuildContext context) {
    final text =
        'PakPay Transaction Receipt\n$_formattedAmount to $recipientLabel\nBank: $bankName\nTxn ID: $transactionId\n$_formattedDateTime\nStatus: $status';
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Receipt copied to clipboard')),
    );
  }

  void _repeatTransfer(BuildContext context) {
    // Pop back to the transfer flow so the user can send again.
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void _downloadReceipt(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Downloading PDF receipt…')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F4F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryclr),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Transaction Receipt',
          style: TextStyle(
            color: AppColors.primaryclr,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share_outlined, color: AppColors.primaryclr),
            onPressed: () => _shareReceipt(context),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            // Receipt card
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    Positioned(
                      right: -30,
                      top: -30,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryclr.withValues(alpha: 0.06),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
                      child: Column(
                        children: [
                          // Logo badge
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryclr,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: const Icon(Icons.bolt, color: Colors.white, size: 16),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'PakPay',
                                style: TextStyle(
                                  color: AppColors.primaryclr,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 22),

                          Container(
                            width: 64,
                            height: 64,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryclr,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check, color: Colors.white, size: 34),
                          ),

                          const SizedBox(height: 16),
                          const Text(
                            'TRANSACTION SUCCESSFUL',
                            style: TextStyle(
                              color: AppColors.primaryclr,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _formattedAmount,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),

                          const SizedBox(height: 20),
                          const Divider(height: 1),
                          const SizedBox(height: 18),

                          _ReceiptRow(label: 'Recipient', value: recipientLabel),
                          const SizedBox(height: 14),
                          _ReceiptRow(label: 'Bank', value: bankName),
                          const SizedBox(height: 14),
                          _ReceiptRow(
                            label: 'Transaction ID',
                            value: transactionId,
                            trailing: InkWell(
                              onTap: () => _copyTransactionId(context),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 6),
                                child: Icon(Icons.copy, size: 14, color: AppColors.primaryclr),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          _ReceiptRow(label: 'Date & Time', value: _formattedDateTime),
                          const SizedBox(height: 14),
                          _ReceiptRow(label: 'Payment Mode', value: paymentMode),
                          const SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Status',
                                style: TextStyle(fontSize: 13, color: Colors.black.withValues(alpha: 0.5)),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryclr.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        color: AppColors.primaryclr,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      status,
                                      style: const TextStyle(
                                        color: AppColors.primaryclr,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 22),
                          Text(
                            "This receipt is electronically generated and doesn't require a signature. For any disputes, please contact PakPay support within 30 days.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 11, color: Colors.black.withValues(alpha: 0.4), height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primaryclr),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () => _repeatTransfer(context),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.refresh, color: AppColors.primaryclr, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Repeat Transfer',
                      style: TextStyle(
                        color: AppColors.primaryclr,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            InkWell(
              onTap: () => _downloadReceipt(context),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.file_download_outlined, size: 18, color: AppColors.primaryclr),
                  SizedBox(width: 8),
                  Text(
                    'Download PDF Receipt',
                    style: TextStyle(color: AppColors.primaryclr, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReceiptRow extends StatelessWidget {
  final String label;
  final String value;
  final Widget? trailing;
  const _ReceiptRow({required this.label, required this.value, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.black.withValues(alpha: 0.5)),
        ),
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ],
    );
  }
}