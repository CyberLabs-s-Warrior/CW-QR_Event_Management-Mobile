import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import '../../../../core/theme/app_colors.dart';

class EventEmptyState extends StatelessWidget {
  const EventEmptyState({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(color: AppColors.secondary),
              child: Iconify(
                Bi.calendar2_date_fill,
                size: 50,
                color: AppColors.primary,
              ),
            ),
          ),
          Gap(25),
          Text(
            text,

            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Gap(100),
        ],
      ),
    );
  }
}
