import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:qr_event_management/core/theme/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class EventDashboardFloatingButton extends StatelessWidget {
  const EventDashboardFloatingButton({
    super.key, this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 15,
      left: 15,
      right: 15,
      child: ZoomTapAnimation(
        onTap: onTap,
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
    );
  }
}