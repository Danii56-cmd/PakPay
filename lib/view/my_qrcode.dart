import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pakpay/core/app_colors.dart';
import 'package:pakpay/sharedwidgets/app_state.dart';

class MyQrScreen extends StatelessWidget {
  const MyQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AppState.instance.user;
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        title: const Text('Receive Money'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 16)],
              ),
              child: Column(
                children: [
                  Text('${user.firstName} ${user.lastName}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 4),
                  Text(user.phone, style: const TextStyle(color: Colors.black54)),
                  const SizedBox(height: 20),
                  _FakeQrCode(seed: AppState.instance.accountNumber),
                  const SizedBox(height: 20),
                  _CopyRow(label: 'Account Number', value: AppState.instance.accountNumber),
                  const SizedBox(height: 10),
                  _CopyRow(label: 'IBAN', value: AppState.instance.iban),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Share this QR code or your account details so others can send you money.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class _CopyRow extends StatelessWidget {
  final String label;
  final String value;
  const _CopyRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 11, color: Colors.black54)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.copy, size: 18, color: AppColors.primaryclr),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: value));
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$label copied')));
          },
        ),
      ],
    );
  }
}

/// Prototype-only stand-in for a real QR code (no external qr package
/// dependency). Deterministically "looks like" a QR based on [seed].
class _FakeQrCode extends StatelessWidget {
  final String seed;
  const _FakeQrCode({required this.seed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(12)),
      child: CustomPaint(painter: _QrPainter(seed)),
    );
  }
}

class _QrPainter extends CustomPainter {
  final String seed;
  _QrPainter(this.seed);

  @override
  void paint(Canvas canvas, Size size) {
    const cells = 14;
    final cellSize = size.width / cells;
    final random = Random(seed.hashCode);
    final paint = Paint()..color = Colors.black;

    for (int y = 0; y < cells; y++) {
      for (int x = 0; x < cells; x++) {
        final isFinder = (x < 3 && y < 3) || (x > cells - 4 && y < 3) || (x < 3 && y > cells - 4);
        final filled = isFinder || random.nextBool();
        if (filled) {
          canvas.drawRect(Rect.fromLTWH(x * cellSize, y * cellSize, cellSize, cellSize), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _QrPainter oldDelegate) => oldDelegate.seed != seed;
}