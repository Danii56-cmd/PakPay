import 'package:flutter/material.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/app_state.dart';
import 'package:pakpay/view/auth/Models/Ttransaction_model.dart';
import 'package:pakpay/view/send_money_succussful_screen.dart';

class SendMoneyScreen extends StatefulWidget {
  /// If set (e.g. arriving from a contact pick or QR scan), the recipient
  /// is shown as a fixed card instead of an editable field.
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
  late PaymentMethod _method;
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String? _error;

  @override
  void initState() {
    super.initState();
    _method = widget.method;
    if (widget.recipientDetail != null) {
      _recipientController.text = widget.recipientDetail!;
    }
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPrefilled = widget.recipientName != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        title: const Text('Send Money'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (isPrefilled)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primaryclr,
                    child: Text(
                      widget.recipientName![0],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.recipientName!,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'via ${_method.label}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          else ...[
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Text('Account Number'),
                    selected: _method == PaymentMethod.accountNumber,
                    onSelected: (_) =>
                        setState(() => _method = PaymentMethod.accountNumber),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ChoiceChip(
                    label: const Text('IBAN'),
                    selected: _method == PaymentMethod.iban,
                    onSelected: (_) =>
                        setState(() => _method = PaymentMethod.iban),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _recipientController,
              decoration: InputDecoration(
                labelText: _method == PaymentMethod.iban
                    ? 'IBAN'
                    : 'Account Number',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Amount (PKR)',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _noteController,
            decoration: InputDecoration(
              labelText: 'Note (optional)',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 10),
            Text(_error!, style: const TextStyle(color: Colors.redAccent)),
          ],
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryclr,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: _submit,
            child: const Text(
              'Send Money',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    final amount = double.tryParse(_amountController.text.trim());
    final recipient = widget.recipientName ?? _recipientController.text.trim();

    if (recipient.isEmpty) {
      setState(() => _error = 'Please enter a recipient');
      return;
    }
    if (amount == null || amount <= 0) {
      setState(() => _error = 'Please enter a valid amount');
      return;
    }

    final success = AppState.instance.sendMoney(
      recipientName: recipient,
      amount: amount,
      method: _method,
      note: _noteController.text.trim(),
    );

    if (!success) {
      setState(() => _error = 'Insufficient balance');
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            SendMoneySuccessScreen(recipientName: recipient, amount: amount),
      ),
    );
  }
}
