import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:qr_event_management/core/theme/app_colors.dart';

class CheckInAndNotCheckIn extends StatelessWidget {
  const CheckInAndNotCheckIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment:
          MainAxisAlignment.spaceAround,
      children: [
        Row(
          crossAxisAlignment:
              CrossAxisAlignment.center,
                              
          children: [
            Iconify(
              Mdi.circle_outline,
              color: AppColors.secondary,
            ),
            Gap(5),
            Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  '30',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                Text(
                  'Check In',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w500,
                    height: 0,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          crossAxisAlignment:
              CrossAxisAlignment.center,
                              
          children: [
            Iconify(
              Mdi.circle_slice_8,
              color: AppColors.secondary,
            ),
                              
            Gap(5),
                              
            Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  '70',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                              
                Text(
                  'Not Check In',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w500,
                    height: 0,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

