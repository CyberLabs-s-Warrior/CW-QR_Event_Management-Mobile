import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:qr_event_management/features/Authentication/presentation/provider/authentication_provider.dart';
import '../../../../core/theme/app_colors.dart';

class SettingLandingHead extends StatefulWidget {
  final int tabIndex;

  const SettingLandingHead({super.key, required this.tabIndex});

  @override
  State<SettingLandingHead> createState() => _SettingLandingHeadState();
}

class _SettingLandingHeadState extends State<SettingLandingHead> {
  @override
  Widget build(BuildContext context) {

    final authProvider = context.read<AuthenticationProvider>();


    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
        left: 20.0,
        right: 20,
        bottom: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    height: 70,
                    width: 70,
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSMUi9wHqia_68xlAU7vP3E3sxn5K0KS-nUvBZk5jSJ54p8FPnw20uYV5yxNgF59DZoqc&usqp=CAU',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        authProvider.currentUser?.name ?? '',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          height: 1,
                        ),
                      ),
                      Text(
                     authProvider.currentUser?.email ?? '',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
