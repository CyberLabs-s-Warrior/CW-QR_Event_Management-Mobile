import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:qr_event_management/core/theme/app_colors.dart';

class SettingItem extends StatelessWidget {
  final String icon;
  final Color? color;
  final double? size;
  final String title;
  final VoidCallback onTap;
  final bool? isLast;

  const SettingItem({
    super.key,
    required this.icon,
    this.color,
    this.size,
    required this.title,
    required this.onTap,  this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
          child: Iconify(
            icon,
            color: color ?? AppColors.black,
            size: size ?? 24,
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: (isLast ?? false) ? Colors.transparent : AppColors.grey1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: color ?? AppColors.black,
                      height: 2,
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Iconify(Ic.sharp_arrow_forward_ios, color: AppColors.grey3,),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
