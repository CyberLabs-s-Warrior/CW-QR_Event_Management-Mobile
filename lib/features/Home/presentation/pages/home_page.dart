import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:provider/provider.dart';
import 'package:qr_event_management/features/Authentication/presentation/provider/authentication_provider.dart';
import 'package:qr_event_management/features/Home/presentation/provider/home_provider.dart';
import 'package:qr_event_management/features/Home/presentation/widgets/home_event_history_item.dart';
import 'package:qr_event_management/widgets/connection_container.dart';

import '../../../../core/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  final int tabIndex;
  final ScrollController? scrollController;

  const HomePage({super.key, required this.tabIndex, this.scrollController});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    final user = context.read<AuthenticationProvider>();

    print("started home page: ${user.currentUser}");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeProvider = context.read<HomeProvider>();
      if (homeProvider.homeSummaryStatus == HomeStatus.initial) {
        homeProvider.startAutoRefresh(
          token: user.currentUser!.token,
          userId: user.currentUser!.id,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: SingleChildScrollView(
            controller: widget.scrollController,
            child: Column(
              children: [
                if ((homeProvider.homeSummary?.currentMonthCount ?? 0) >= 1)
                  homeAlert(homeProvider: homeProvider),
                ConnectionContainer(gap: 15, bottom: true),
                eventOverview(homeProvider: homeProvider),
                Gap(15),
                eventHistory(),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget homeAlert({required HomeProvider homeProvider}) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primaryLight,
          border: Border.all(
            color: const Color.fromARGB(255, 171, 201, 255),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Reminder!",
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "You’ve got ${homeProvider.homeSummary?.currentMonthCount ?? 0} events scheduled this month.\nMake sure you’re prepared!",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Iconify(
                        MaterialSymbols.arrow_forward_ios_rounded,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Gap(15),
    ],
  );
}

Widget eventOverview({required HomeProvider homeProvider}) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Event Overview",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('clicked');
                },
                child: Iconify(
                  Bi.three_dots_vertical,
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),

          SizedBox(height: 3),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upcoming event",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.secondary,
                    height: 1,
                  ),
                  textAlign: TextAlign.start,
                ),

                if (homeProvider.homeSummaryStatus != HomeStatus.error)
                  Text(
                    homeProvider.homeSummary?.upcomingEvent ??
                        'No Upcoming Event',
                    style: TextStyle(
                      fontSize: 19,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  )
                else
                  Text(
                    homeProvider.cleanErrorMessage,
                    style: TextStyle(
                      fontSize: 19,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),

                SizedBox(height: 3),
                Text(
                  "Total Event Participated",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.secondary,
                    height: 1,
                  ),
                  textAlign: TextAlign.start,
                ),

                if (homeProvider.homeSummaryStatus != HomeStatus.error)
                  Text(
                    homeProvider.homeSummary?.pastCount.toString() ?? '0',
                    style: TextStyle(
                      fontSize: 19,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  )
                else
                    CircularProgressIndicator(color: AppColors.secondary)
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget eventHistory() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Your Event History",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: AppColors.grey,
            ),
          ),
          GestureDetector(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 15),
              ),
              onPressed: () {
                print('clicked');
              },
              child: Row(
                children: [
                  Iconify(
                    Ic.outline_remove_red_eye,
                    color: AppColors.primary,
                    size: 18,
                  ),
                  SizedBox(width: 3),
                  Text(
                    'view all',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return HomeEventHistoryItem();
        },
      ),
      Gap(100),
    ],
  );
}
