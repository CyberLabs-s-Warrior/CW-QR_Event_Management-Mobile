import 'dart:io';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/clarity.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/mi.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import '../widgets/event_dashboard_result_item.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../core/theme/app_colors.dart';
import 'package:iconify_flutter/icons/jam.dart';
import 'package:iconify_flutter/icons/ph.dart';
import '../../../../widgets/general_back_button.dart';

class QRViewTest extends StatefulWidget {
  const QRViewTest({super.key});

  @override
  State<QRViewTest> createState() => _QRViewTestState();
}

enum ScanMode { attendance, identityCheck }

class _QRViewTestState extends State<QRViewTest>
    with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  late AnimationController _animationController;
  late Animation<double> _animation;

  ScanMode _currentScanMode = ScanMode.attendance;

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

        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: AppColors.backgroundPage,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                builder:
                    (context) => Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Options',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            leading: const Iconify(Ri.qr_scan_fill),
                            title: const Text('Scanner Options'),
                            onTap: () {
                              Navigator.pop(context);
                              scannerOptionsModalBottomSheet(context);
                            },
                          ),
                          ListTile(
                            leading: const Iconify(MaterialSymbols.flash_on),
                            title: const Text('Toggle Flash'),
                            onTap: () {
                              controller?.toggleFlash();
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: const Iconify(
                              MaterialSymbols.flip_camera_ios,
                            ),
                            title: const Text('Flip Camera'),
                            onTap: () {
                              controller?.flipCamera();
                              Navigator.pop(context);
                            },
                          ),
                          Gap(20),
                        ],
                      ),
                    ),
              );
            },
            icon: const Icon(Icons.more_vert, color: AppColors.black),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          // qrscanner
          // QRView(
          //   key: qrKey,
          //   onQRViewCreated: _onQRViewCreated,
          //   overlay: QrScannerOverlayShape(
          //     borderColor: Colors.blue,
          //     borderRadius: 10,
          //     borderLength: 30,
          //     borderWidth: 8,
          //     cutOutSize: cutOutSize,
          //     overlayColor: Colors.black.withOpacity(0.5),
          //   ),
          // ),

          // scan line
          // Positioned.fill(
          //   child: Center(
          //     child: ClipRRect(
          //       borderRadius: BorderRadius.circular(14),
          //       child: SizedBox(
          //         width: cutOutSize,
          //         height: cutOutSize,
          //         child: AnimatedBuilder(
          //           animation: _animation,
          //           builder: (context, child) {
          //             return Align(
          //               alignment: Alignment(0, (2 * _animation.value) - 1),
          //               child: ImageFiltered(
          //                 imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          //                 child: Container(
          //                   height: 4,
          //                   width: cutOutSize,
          //                   color: Colors.blueAccent.withOpacity(0.8),
          //                 ),
          //               ),
          //             );
          //           },
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          // result & tab
          Positioned(
            bottom: 49,
            right: 15,
            left: 15,
            child: Container(
              padding: EdgeInsets.all(20),
              height: 180.0,

              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: EventDashboardScanIdentityCheckResult(),

              // child: Center(
              //   child:
              //       (result != null)
              //           ? Text(
              //             'Barcode Type: ${result!.format.name}\nData: ${result!.code}',
              //             textAlign: TextAlign.center,
              //           )
              //           : const Text('Arahkan QR Code ke dalam kotak'),
              // ),
            ),
          ),

          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _currentScanMode == ScanMode.attendance
                        ? Icons.people_alt_outlined
                        : Icons.badge_outlined,
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(width: 4),
                  Text(
                    _currentScanMode == ScanMode.attendance
                        ? 'Attendance Mode'
                        : 'Identity Check Mode',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> scannerOptionsModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundPage,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Scanner Options',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: Iconify(
                    Ph.user_focus_bold,
                    color:
                        _currentScanMode == ScanMode.attendance
                            ? AppColors.white
                            : AppColors.black,
                  ),
                  title: Text(
                    'Attendance',
                    style: TextStyle(
                      color:
                          _currentScanMode == ScanMode.attendance
                              ? AppColors.white
                              : AppColors.black,
                    ),
                  ),
                  tileColor:
                      _currentScanMode == ScanMode.attendance
                          ? AppColors.primary
                          : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(99),
                  ),
                  onTap: () {
                    setState(() {
                      _currentScanMode = ScanMode.attendance;
                    });
                    Navigator.pop(context);
                  },
                ),
                Gap(5),
                ListTile(
                  leading: Iconify(
                    Uil.qrcode_scan,
                    color:
                        _currentScanMode == ScanMode.identityCheck
                            ? AppColors.white
                            : AppColors.black,
                  ),
                  title: Text(
                    'Identity Check',
                    style: TextStyle(
                      color:
                          _currentScanMode == ScanMode.identityCheck
                              ? AppColors.white
                              : AppColors.black,
                    ),
                  ),
                  tileColor:
                      _currentScanMode == ScanMode.identityCheck
                          ? AppColors.primary
                          : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(99),
                  ),
                  onTap: () {
                    setState(() {
                      _currentScanMode = ScanMode.identityCheck;
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
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

class EventDashboardScanIdentityCheckResult extends StatelessWidget {
  const EventDashboardScanIdentityCheckResult({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Column(
              children: [
                EventDashboardResultItem(
                  title: 'Name',
                  isBadge: false,
                  icon: Iconify(Uil.user, color: AppColors.primary),
                  textContent: "Admin 1",
                ),
                Gap(15),
                EventDashboardResultItem(
                  title: 'Details',
                  isBadge: false,
                  icon: Iconify(
                    Ph.file_text,
                    color: AppColors.primary,
                  ),
                  onTap: () {
                    print('clicked');
                  },
                  textContent: "Click Me!",
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Column(
              children: [
                EventDashboardResultItem(
                  title: 'Status',
                  isBadge: true,
                  icon: Iconify(
                    Ph.check_circle,
                    color: AppColors.primary,
                  ),
                  isScannedStatus: true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class EventDashboardScanAttendanceResult extends StatelessWidget {
  const EventDashboardScanAttendanceResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Column(
              children: [
                EventDashboardResultItem(
                  title: 'Name',
                  isBadge: false,
                  icon: Iconify(Uil.user, color: AppColors.primary),
                  textContent: "Admin 1",
                ),
                Gap(15),
                EventDashboardResultItem(
                  title: 'Phone Number',
                  isBadge: false,
                  icon: Iconify(Uil.phone, color: AppColors.primary),

                  textContent: "Admin 1",
                ),
                Gap(15),
                EventDashboardResultItem(
                  title: 'Details',
                  isBadge: false,
                  icon: Iconify(Uil.phone, color: AppColors.primary),

                  textContent: "Click Me!",
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Column(
              children: [
                EventDashboardResultItem(
                  title: 'Id Number',
                  isBadge: false,
                  icon: Iconify(
                    MaterialSymbols.numbers_rounded,
                    color: AppColors.primary,
                  ),

                  textContent: "Admin 1",
                ),
                Gap(15),
                EventDashboardResultItem(
                  title: 'Status',
                  isBadge: true,
                  icon: Iconify(Ph.check_circle, color: AppColors.primary),

                  textContent: "Success",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

