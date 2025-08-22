import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:qr_event_management/core/provider/network_status_provider.dart';
import 'package:qr_event_management/core/theme/app_colors.dart';

class ConnectionContainer extends StatelessWidget {
  final bool? top;
  final bool? bottom;
  final bool? topAndBottom;
  final double gap;

  const ConnectionContainer({
    super.key,
    this.top,
    this.bottom,
    this.topAndBottom,
    required this.gap,
  });

  @override
  Widget build(BuildContext context) {
    final isOnline = context.select<NetworkStatusProvider, bool>(
      (p) => p.isOnline,
    );
    return Column(
      children: [
        if ((top != null) || (topAndBottom != null)) Gap(gap),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          child:
              isOnline
                  ? const SizedBox.shrink(key: ValueKey('online'))
                  : Container(
                    key: const ValueKey('offline'),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.warning, color: AppColors.grey1, size: 20,),
                        Gap(13),
                        Expanded(
                          child: const Text(
                              'No internet connection. Some features may be unavailable.',
                            style: TextStyle(
                              color: AppColors.grey1,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
        ),
        if ((bottom != null) || (topAndBottom != null)) Gap(gap),
      ],
    );
  }
}
