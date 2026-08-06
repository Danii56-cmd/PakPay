import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pakpay/sharedwidgets/app_state.dart';
import 'package:pakpay/Models/Ttransaction_model.dart';
import 'package:pakpay/view/sendmoney/send_money_screen.dart';

/// Real camera-based scanner (mobile_scanner). Expects QR payloads produced
/// by MyQrScreen, e.g. pakpay://pay?name=...&account=...&iban=...
class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({super.key});

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );
  bool _handled = false;
  bool _torchOn = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_handled || capture.barcodes.isEmpty) return;
    final raw = capture.barcodes.first.rawValue;
    if (raw == null || raw.isEmpty) return;

    _handled = true;
    _controller.stop();
    _navigateWithPayload(raw);
  }

  void _navigateWithPayload(String raw) {
    String? name;
    String? account;

    try {
      final uri = Uri.parse(raw);
      name = uri.queryParameters['name'];
      account = uri.queryParameters['account'];
    } catch (_) {
      // Not a pakpay:// URI — fall back to treating the raw value
      // itself as the account/reference number.
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => SendMoneyScreen(
          recipientName: (name != null && name.isNotEmpty)
              ? name
              : 'Scanned Contact',
          recipientDetail: (account != null && account.isNotEmpty)
              ? account
              : raw,
          method: PaymentMethod.qrCode,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Scan QR', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(
              _torchOn ? Icons.flash_on : Icons.flash_off,
              color: Colors.white,
            ),
            onPressed: () {
              _controller.toggleTorch();
              setState(() => _torchOn = !_torchOn);
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(controller: _controller, onDetect: _onDetect),
          // Dim overlay with a clear viewfinder cutout.
          IgnorePointer(
            child: Center(
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Column(
              children: [
                const Text(
                  'Point your camera at a PakPay QR code',
                  style: TextStyle(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    if (_handled) return;
                    _handled = true;
                    final contact = AppState.instance.contacts.first;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SendMoneyScreen(
                          recipientName: contact.name,
                          recipientDetail: contact.accountNumber,
                          method: PaymentMethod.qrCode,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Can't scan? Use a test contact instead",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
