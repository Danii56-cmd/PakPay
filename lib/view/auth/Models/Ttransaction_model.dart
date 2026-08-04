import 'package:flutter/material.dart';

enum PaymentMethod { qrCode, accountNumber, iban }

extension PaymentMethodLabel on PaymentMethod {
  String get label {
    switch (this) {
      case PaymentMethod.qrCode:
        return 'QR Code';
      case PaymentMethod.accountNumber:
        return 'Account Number';
      case PaymentMethod.iban:
        return 'IBAN';
    }
  }
}

class TransactionModel {
  final String id;
  final String title;
  final String subtitle;
  final double amount;
  final bool isCredit;
  final IconData icon;
  final PaymentMethod? method;

  TransactionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isCredit,
    this.icon = Icons.swap_horiz,
    this.method,
  });

  String get formattedAmount =>
      '${isCredit ? '+' : '-'} PKR ${amount.toStringAsFixed(2)}';
}