import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../gen/loading/wave_loading.dart';

class EventDashboardError extends StatelessWidget {
  final String? message;
  const EventDashboardError({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
          colors: [
            AppColors.eventDashboard,
            Color.fromARGB(255, 180, 206, 255),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WaveLoading(),

            Gap(20),

          Text(
            textAlign: TextAlign.center,
            message ?? 'Unknown error occured',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: AppColors.primaryLight),
          ),
        ],
      ),
    );
  }
}
