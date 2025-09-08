import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:provider/provider.dart';
import '../../../../gen/alert/toastification.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../core/constant/enum_status.dart';
import '../../../../core/provider/network_status_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../gen/alert/snack_bar.dart';
import '../../../../widgets/general_back_button.dart';
import '../../../Authentication/presentation/provider/authentication_provider.dart';
import '../provider/event_dashboard_provider.dart';
import '../widgets/check_in_and_not_check_in.dart';
import '../widgets/event_dashboard_error.dart';
import '../widgets/event_dashboard_loading.dart';
import '../widgets/event_registration_percentage.dart';
import 'event_dashboard_qr_scanner.dart';

class EventDashboardPage extends StatefulWidget {
  final int eventId;

  const EventDashboardPage({super.key, required this.eventId});

  @override
  State<EventDashboardPage> createState() => _EventDashboardPageState();
}

class _EventDashboardPageState extends State<EventDashboardPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    final eventDashboardProvider = context.read<EventDashboardProvider>();
    final authProvider = context.read<AuthenticationProvider>();

    eventDashboardProvider.getEventById(
      authProvider.authorization?.token,
      widget.eventId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isOnline = context.select<NetworkStatusProvider, bool>(
      (p) => p.isOnline,
    );
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: GeneralBackButton(
          iconColor: AppColors.secondary,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColors.eventDashboard,
        centerTitle: true,
        title: Text(
          'Event Dashboard ${widget.eventId}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.secondary,
          ),
        ),
      ),
      body: Consumer<EventDashboardProvider>(
        builder: (context, eventDashboardProvider, child) {
          if (eventDashboardProvider.eventStatus == ResponseStatus.loading) {
            return EventDashboardLoading();
          } else if (!isOnline) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showCustomToast(
                context: context,
                message: "Connection must be stable",
                backgroundColor: AppColors.warning,
                foregroundColor: AppColors.white,
                primaryColor: AppColors.white,
              );
            });
            return EventDashboardError(message: "No internet connection");
          } else if (eventDashboardProvider.eventStatus ==
              ResponseStatus.error) {
            return EventDashboardError(
              message: eventDashboardProvider.cleanErrorMessage,
            );
          } else {
            return SafeArea(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 550,
                        decoration: BoxDecoration(
                          color: AppColors.eventDashboard,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Gap(30),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${eventDashboardProvider.event?.title}",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.secondary,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Iconify(
                                              Bi.clock_fill,
                                              color: AppColors.secondary,
                                              size: 20,
                                            ),
                                            Gap(5),
                                            Text(
                                              "${eventDashboardProvider.event?.endDate}",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.secondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Gap(10),

                                  ZoomTapAnimation(
                                    onTap: () {},
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(9999),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: AppColors.secondary,
                                        ),
                                        child: SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color: AppColors.primary,
                                            strokeWidth: 10,
                                          ),
                                        ),
                                        // child: Iconify(
                                        //   Ic.twotone_refresh,
                                        //   color: AppColors.primary,
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Gap(50),

                              EventRegistrationPercentage(),

                              Gap(50),

                              CheckInAndNotCheckIn(),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40.0,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text('Event Logs')],
                        ),
                      ),
                    ],
                  ),

                  Positioned(
                    bottom: 15,
                    left: 15,
                    right: 15,
                    child: ZoomTapAnimation(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => QRViewTest()),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(9999),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: AppColors.buttonBackgroundPrimary,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Iconify(
                                Bi.qr_code_scan,
                                color: AppColors.secondary,
                              ),
                              Gap(5),
                              Text(
                                'Scan QR',
                                style: TextStyle(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
