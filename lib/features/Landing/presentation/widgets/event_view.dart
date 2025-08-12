import 'package:flutter/material.dart';
import 'package:qr_event_management/core/theme/app_colors.dart';

import '../pages/event_page.dart';
import 'event_landing_head.dart';

class EventView extends StatelessWidget {
  const EventView({
    super.key,
    required Animation<double> borderRadiusAnimation,
    required TabController tabController,
    required ScrollController homeScrollController,
  }) : _borderRadiusAnimation = borderRadiusAnimation, _tabController = tabController, _homeScrollController = homeScrollController;

  final Animation<double> _borderRadiusAnimation;
  final TabController _tabController;
  final ScrollController _homeScrollController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _borderRadiusAnimation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    _borderRadiusAnimation.value,
                  ),
                  bottomRight: Radius.circular(
                    _borderRadiusAnimation.value,
                  ),
                ),
                border:
                    _borderRadiusAnimation.value > 0
                        ? Border(
                          bottom: BorderSide(
                            width: 2,
                            color: AppColors.primaryLight,
                          ),
                        )
                        : null,
              ),
              child: EventLandingHead(
                tabIndex: _tabController.index,
              ),
            );
          },
        ),
        Expanded(
          child: EventLandingPage(
            tabIndex: _tabController.index,
            scrollController: _homeScrollController,
          ),
        ),
      ],
    );
  }
}