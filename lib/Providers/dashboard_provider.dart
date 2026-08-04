import 'package:flutter/material.dart';
import 'package:pakpay/sharedwidgets/app_state.dart';
import 'package:pakpay/view/auth/Models/Ttransaction_model.dart';
import 'package:pakpay/view/auth/Models/user_model.dart';

/// Kept for backward compatibility with any code that still consumes
/// dashboard state via Provider/ChangeNotifierProvider. All real state
/// now lives in [AppState] — this class just mirrors it and notifies
/// listeners when it changes.
///
/// NOTE: verify this file's location matches wherever you import
/// DashboardProvider elsewhere (e.g. main.dart) — move it if needed.
class DashboardProvider extends ChangeNotifier {
  DashboardProvider() {
    AppState.instance.balance.addListener(notifyListeners);
    AppState.instance.transactions.addListener(notifyListeners);
  }

  UserModel get user => AppState.instance.user;

  bool _hideBalance = true;
  bool get hideBalance => _hideBalance;

  List<TransactionModel> get transactions => AppState.instance.transactions.value;

  double get balance => AppState.instance.balance.value;

  void toggleBalance() {
    _hideBalance = !_hideBalance;
    notifyListeners();
  }

  void transaction(TransactionModel newTransaction) {
    final updated = List<TransactionModel>.from(AppState.instance.transactions.value)
      ..insert(0, newTransaction);
    AppState.instance.transactions.value = updated;
  }

  @override
  void dispose() {
    AppState.instance.balance.removeListener(notifyListeners);
    AppState.instance.transactions.removeListener(notifyListeners);
    super.dispose();
  }
}