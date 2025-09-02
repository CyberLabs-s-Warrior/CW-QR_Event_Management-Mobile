import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import '../../../../core/controller/inner_tab_controller.dart';
import '../../../../core/scope/landing_tabs_scope.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:qr_event_management/features/Home/presentation/provider/home_provider.dart'
    show HomeStatus, HomeProvider;
import 'package:qr_event_management/features/Home/presentation/widgets/home_event_history_item.dart';

Widget eventHistory({
  required BuildContext context,
  required HomeProvider homeProvider,
}) {
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
                eventInnerTabIndex.value = 2;
                // lalu pindah ke tab Events (index 1)
                final controller = LandingTabsScope.of(context)?.controller;
                controller?.animateTo(1);
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

      homeProvider.homeEventHistoryStatus == HomeStatus.loading
          ? Center(child: CircularProgressIndicator())
          : homeProvider.homeEventHistoryStatus == HomeStatus.error
          ? Center(
            child: Text(
              // homeProvider.cleanErrorMessage,
              'Something happened :)',
              textAlign: TextAlign.center,
            ),
          )
          : (homeProvider.homeEventHistory?.isEmpty ?? true)
          ? const Center(child: Text('No event history yet'))
          : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: homeProvider.homeEventHistory!.length,
            separatorBuilder: (_, __) => const Gap(0),
            itemBuilder: (context, index) {
              final event = homeProvider.homeEventHistory![index];
              return HomeEventHistoryItem(
                title: event?.title ?? 'Untitled',
                category:
                    (event?.category?.isNotEmpty ?? false)
                        ? event!.category!
                        : "doesn't have a category",
                endDate: event?.endDate ?? '0 ago',
                banner: event.banner,
                id: event.id,
              );
            },
          ),

      Gap(100),
    ],
  );
}
