import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../widgets/general_back_button.dart';

class EventDashboardPendingAttendeesPage extends StatefulWidget {
  const EventDashboardPendingAttendeesPage({super.key});

  @override
  State<EventDashboardPendingAttendeesPage> createState() => _EventDashboardPendingAttendeesPageState();
}

class _EventDashboardPendingAttendeesPageState extends State<EventDashboardPendingAttendeesPage> {
  @override
  Widget build(BuildContext context) {
     return  Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: GeneralBackButton(
          iconColor: AppColors.secondary,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColors.eventDashboard,
        title: Text(
          'Pending Attendees',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.secondary,
          ),
        ),
      ),
    );
  }
}