import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/octicon.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:iconify_flutter/icons/uil.dart';
import 'package:qr_event_management/core/theme/app_colors.dart';
import 'package:qr_event_management/features/Landing/presentation/pages/landing_page.dart';
import 'package:qr_event_management/features/Landing/presentation/widgets/setting_item.dart';
import 'package:qr_event_management/features/Landing/presentation/widgets/setting_landing_head.dart';

class SettingView extends StatelessWidget {
  const SettingView({
    super.key,
    required Animation<double> borderRadiusAnimation,
    required TabController tabController,
  }) : _borderRadiusAnimation = borderRadiusAnimation, _tabController = tabController;

  final Animation<double> _borderRadiusAnimation;
  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
          child: SettingLandingHead(tabIndex: _tabController.index),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 5,
            ),
            child: Column(
              children: [
                SettingGroupHead(
                  
                  title: 'ACCOUNT',
                  children: [
                    SettingItem(
                      icon: Uil.user,
                      title: 'Profile Data',
                      onTap: () {
                        print('Profile Data');
                      },
                    ),
                    SettingItem(
                      icon: Ri.logout_circle_r_line,
                      title: 'Sign Out',
                      color: AppColors.red,
                      isLast: true,
                      onTap: () {
                        print('Sign Out');
                      },
                    ),
                  ],
                ),
    
    
                SettingGroupHead(
                  
                  title: 'SETTINGS',
                  children: [
                    SettingItem(
                      icon: Octicon.pencil_24,
                      title: 'Account Details',
                      onTap: () {
                        print('Account Details');
                      },
                    ),
                    SettingItem(
                      icon: Carbon.password,
                      title: 'Change Password',
                      isLast: true,
                      onTap: () {
                        print('Change Password');
                      },
                    ),
                  ],
                ),
    
    
              ],
            ),
          ),
        ),
      ],
    );
  }
}