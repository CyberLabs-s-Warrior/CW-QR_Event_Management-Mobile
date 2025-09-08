import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:provider/provider.dart';
import 'package:qr_event_management/features/EventDashboard/presentation/widgets/event_dashboard_floating_button.dart';
import 'package:qr_event_management/features/EventDashboard/presentation/widgets/event_dashboard_head.dart';
import 'package:qr_event_management/features/EventDashboard/presentation/widgets/event_dashboard_refresh_data.dart';
import '../../../../gen/alert/toastification.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../core/constant/enum_status.dart';
import '../../../../core/provider/network_status_provider.dart';
import '../../../../core/theme/app_colors.dart';
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
      body: Consumer2<EventDashboardProvider, AuthenticationProvider>(
        builder: (context, eventDashboardProvider, authProvider, child) {
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

                              EventDashboardHead(
                                widget: widget,
                                eventDashboardProvider: eventDashboardProvider,
                                authProvider: authProvider,
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

                  EventDashboardFloatingButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => QRViewTest()),
                      );
                    },
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
