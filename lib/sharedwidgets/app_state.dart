import 'package:flutter/material.dart';
import 'package:pakpay/Models/Ttransaction_model.dart';
import 'package:pakpay/Models/user_model.dart';

class Contact {
  final String name;
  final String initials;
  final String accountNumber;
  final String iban;
  final Color avatarColor;

  Contact({
    required this.name,
    required this.initials,
    required this.accountNumber,
    required this.iban,
    this.avatarColor = const Color(0xFF6C5CE7),
  });
}

/// Single source of truth for the prototype's dummy data.
/// Replace with real API/storage calls later — the rest of the app
/// only talks to this class, so that swap stays contained here.
class AppState {
  AppState._internal();
  static final AppState instance = AppState._internal();

  final UserModel user = UserModel(
    firstName: 'Abdul',
    lastName: 'Waris',
    phone: '923093838338',
    email: 'awmdknfe@gmail.com',
  );

  final String accountNumber = '01023456789012';
  final String iban = 'PK36SCBL0000001123456702';

  final ValueNotifier<double> balance = ValueNotifier<double>(148250.75);

  final ValueNotifier<List<TransactionModel>> transactions =
      ValueNotifier<List<TransactionModel>>([
        TransactionModel(
          id: 't1',
          title: 'Groceries Plus',
          subtitle: 'Yesterday, 4:20 PM',
          amount: 2450,
          isCredit: false,
          icon: Icons.shopping_bag_outlined,
          method: PaymentMethod.accountNumber,
        ),
        TransactionModel(
          id: 't2',
          title: 'Salary Deposit',
          subtitle: 'Oct 01, 2023',
          amount: 125000,
          isCredit: true,
          icon: Icons.account_balance_outlined,
        ),
        TransactionModel(
          id: 't3',
          title: 'KE Electric Bill',
          subtitle: 'Sep 28, 2023',
          amount: 14320,
          isCredit: false,
          icon: Icons.bolt_outlined,
          method: PaymentMethod.iban,
        ),
        TransactionModel(
          id: 't4',
          title: 'Ali Raza',
          subtitle: 'Sep 24, 2023',
          amount: 5000,
          isCredit: false,
          icon: Icons.qr_code_2,
          method: PaymentMethod.qrCode,
        ),
      ]);

  final List<Contact> contacts = [
    Contact(
      name: 'Ali Raza',
      initials: 'AR',
      accountNumber: '01098765432101',
      iban: 'PK12SCBL0000009876543210',
      avatarColor: const Color(0xFFE17055),
    ),
    Contact(
      name: 'Sara Khan',
      initials: 'SK',
      accountNumber: '01011122233344',
      iban: 'PK45SCBL0000001112223334',
      avatarColor: const Color(0xFF00B894),
    ),
    Contact(
      name: 'Bilal Ahmed',
      initials: 'BA',
      accountNumber: '01055566677788',
      iban: 'PK78SCBL0000005556667778',
      avatarColor: const Color(0xFF0984E3),
    ),
    Contact(
      name: 'Hina Farooq',
      initials: 'HF',
      accountNumber: '01099988877766',
      iban: 'PK90SCBL0000009998887776',
      avatarColor: const Color(0xFFE84393),
    ),
    Contact(
      name: 'Usman Tariq',
      initials: 'UT',
      accountNumber: '01044455566677',
      iban: 'PK23SCBL0000004445556667',
      avatarColor: const Color(0xFFFDCB6E),
    ),
  ];

  /// Sends [amount] to [recipientName] via [method].
  /// Returns true on success, false if the balance is insufficient
  /// or the amount is invalid.
  bool sendMoney({
    required String recipientName,
    required double amount,
    required PaymentMethod method,
    String? note,
  }) {
    if (amount <= 0 || amount > balance.value) return false;

    balance.value -= amount;

    final updated = List<TransactionModel>.from(transactions.value);
    updated.insert(
      0,
      TransactionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: recipientName,
        subtitle: (note != null && note.isNotEmpty) ? note : 'Just now',
        amount: amount,
        isCredit: false,
        icon: method == PaymentMethod.qrCode
            ? Icons.qr_code_2
            : Icons.send_outlined,
        method: method,
      ),
    );
    transactions.value = updated;
    return true;
  }
}
