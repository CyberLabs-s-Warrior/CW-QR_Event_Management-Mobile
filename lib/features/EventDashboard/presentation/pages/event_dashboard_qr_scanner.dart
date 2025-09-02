import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../widgets/general_back_button.dart';

class QRViewTest extends StatefulWidget {
  const QRViewTest({super.key});

  @override
  State<QRViewTest> createState() => _QRViewTestState();
}

class _QRViewTestState extends State<QRViewTest>
    with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double cutOutSize = MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
      appBar: AppBar(
        leading: GeneralBackButton(
          onTap: () {
            Navigator.pop(context);
          },
        ),

        title: Text(
          'Scan QR Attendees',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: <Widget>[
          // qrscanner
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.blue,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 8,
              cutOutSize: cutOutSize,
              overlayColor: Colors.black.withOpacity(0.5),
            ),
          ),

          // scan line
          Positioned.fill(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(
                  width: cutOutSize,
                  height: cutOutSize,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Align(
                        alignment: Alignment(0, (2 * _animation.value) - 1),
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            height: 4,
                            width: cutOutSize,
                            color: Colors.blueAccent.withOpacity(0.8),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          // result & tab
          Positioned(
            bottom: 15,
            right: 15,
            left: 15,
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child:
                    (result != null)
                        ? Text(
                          'Barcode Type: ${result!.format.name}\nData: ${result!.code}',
                          textAlign: TextAlign.center,
                        )
                        : const Text('Arahkan QR Code ke dalam kotak'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }
}
