// lib/widgets/qr_code_dialog.dart

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeDialog extends StatelessWidget {
  final String storeName;
  final String qrData;

  const QRCodeDialog({
    Key? key,
    required this.storeName,
    required this.qrData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('$storeName QR Code'),
      content: QrImageView(
        data: qrData,
        version: QrVersions.auto,
        size: 200.0,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
