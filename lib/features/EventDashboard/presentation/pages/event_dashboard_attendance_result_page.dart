import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_event_management/core/theme/app_colors.dart';
import 'package:qr_event_management/widgets/general_back_button.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class EventDashboardAttendanceResultPage extends StatefulWidget {
  const EventDashboardAttendanceResultPage({super.key});

  @override
  State<EventDashboardAttendanceResultPage> createState() =>
      _EventDashboardAttendanceResultPageState();
}

class _EventDashboardAttendanceResultPageState
    extends State<EventDashboardAttendanceResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scan Attendance Result',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: GeneralBackButton(
          onTap: () {
            Navigator.pop(context);
          },
        ),
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Lottie.asset(
                    'assets/lottie/success_nabildzr.json',
                    width: 100,
                  ),
                  Gap(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Success',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.black.withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Checked-In',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.black.withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Gap(10),
              Divider(color: AppColors.grey1, thickness: 2),
              Gap(10),
              Text(
                'Title Event',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Gap(10),
              Text(
                'Name Attendee',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Gap(10),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'QR Code',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'A3IO3VIHO3AOAoi33qnoi1',
                            style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 20,
                            ),
                          ),
                          Gap(5),
                          ZoomTapAnimation(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: AppColors.backgroundPage,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(32),
                                  ),
                                ),
                                builder:
                                    (context) => Container(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            'Code Details',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 16),

                                          ListTile(
                                            leading: const Iconify(
                                              MaterialSymbols.qr_code,
                                            ),
                                            title: const Text('A3IO3VIHO3AOAoi33qnoi1'),
                                          ),
                                          Gap(20),
                                        ],
                                      ),
                                    ),
                              );
                            },
                            child: Iconify(
                              Ic.outline_remove_red_eye,
                              color: AppColors.primary,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Attend Date',
                          style: TextStyle(
                            color: AppColors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'July 23, 2026',
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Time',
                          style: TextStyle(
                            color: AppColors.grey,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '10:00:00',
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(10),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'example@mail.duar',
                        style: TextStyle(
                          color: AppColors.black,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Gap(10),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Phone Number',
                        style: TextStyle(
                          color: AppColors.grey,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '+62 888-9999-0000',
                        style: TextStyle(
                          color: AppColors.black,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Gap(10),
              Divider(color: AppColors.grey1, thickness: 2),
              Gap(10),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status',
                        style: TextStyle(
                          color: AppColors.grey,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Present',
                        style: TextStyle(
                          color: AppColors.black,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
