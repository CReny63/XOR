import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart'; // Make sure to import this package

class QRCodePage extends StatelessWidget {
  // Method to show QR code modal
  void _showQRCodeModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Scan Here"),
          content: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                // White container with colored border
                SizedBox(
                  height: 200,
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 160,
                      width: 160,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: QrImageView(
                          data: 'This is a simple QR code',
                          version: QrVersions.auto,
                          size: 120,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showQRCodeModal(context); // Trigger the modal on button press
          },
          child: const Text('Show QR Code'),
        ),
      ),
    );
  }
}
