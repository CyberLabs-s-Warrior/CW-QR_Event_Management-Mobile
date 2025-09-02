import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:qr_event_management/core/theme/app_colors.dart';

class EventRegistrationPercentage extends StatelessWidget {
  const EventRegistrationPercentage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularPercentIndicator(
        radius: 120.0,
        lineWidth: 25.0,
        animation: true,
        percent: 0.7,
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              CrossAxisAlignment.center,
          children: [
            const Text(
              "70%",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 70.0,
                height: 0,
                fontStyle: FontStyle.italic,
                color: AppColors.secondary,
              ),
            ),
            const Text(
              "All Registrations",
              style: TextStyle(
                height: 0,
                fontWeight: FontWeight.w600,
                color: AppColors.secondary,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
                              
        backgroundColor: AppColors.primary,
        circularStrokeCap: CircularStrokeCap.round,
        progressBorderColor: AppColors.primary,
        progressColor: AppColors.darkPrimary,
      ),
    );
  }
}
