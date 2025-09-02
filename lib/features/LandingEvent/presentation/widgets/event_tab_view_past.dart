import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:provider/provider.dart';
import '../../../../gen/loading/wave_loading.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constant/enum_status.dart';
import '../../../Authentication/presentation/provider/authentication_provider.dart';
import '../provider/landing_event_provider.dart';

import '../../../../gen/scroll/scroll_to_up_button.dart';
import 'event_landing_card.dart';

class EventTabViewPast extends StatefulWidget {
  const EventTabViewPast({super.key});

  @override
  State<EventTabViewPast> createState() => _EventTabViewPastState();
}

class _EventTabViewPastState extends State<EventTabViewPast> {
  late ScrollController _scrollController;
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    final user = context.read<AuthenticationProvider>();

    final landingEventProvider = context.read<LandingEventProvider>();
    landingEventProvider.getEventPast(
      token: user.currentUser!.token,
      userId: user.currentUser!.id,
    );
  }

  void _scrollListener() {
    if (_scrollController.offset > 200 && !_showBackToTop) {
      setState(() {
        _showBackToTop = true;
      });
    } else if (_scrollController.offset <= 200 && _showBackToTop) {
      setState(() {
        _showBackToTop = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LandingEventProvider, AuthenticationProvider>(
      builder: (context, landingEventProvider, authProvider, child) {
        return SizedBox(
          height: MediaQuery.of(context).size.height - 250,
          child: Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  await landingEventProvider.getEventPast(
                    token: authProvider.currentUser!.token,
                    userId: authProvider.currentUser!.id,
                  );
                },
                child:
                    landingEventProvider.landingEventPastStatus ==
                            ResponseStatus.loading
                        ? WaveLoading()
                        : landingEventProvider.landingEventPastStatus ==
                            ResponseStatus.error
                        ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(9999),
                                child: Container(
                                  padding: EdgeInsets.all(25),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondary,
                                  ),
                                  child: Iconify(
                                    Bi.calendar2_date_fill,
                                    size: 50,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                              Gap(25),
                              Text(
                                landingEventProvider.cleanErrorMessage,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Gap(100),
                            ],
                          ),
                        )
                        : (landingEventProvider.landingEventPast?.isEmpty ??
                            true)
                        ? const Center(child: Text('No event history yet'))
                        : ListView.separated(
                          shrinkWrap: true,
                          itemCount:
                              landingEventProvider.landingEventPast!.length,
                          separatorBuilder: (_, __) => const Gap(0),
                          itemBuilder: (context, index) {
                            final event =
                                landingEventProvider.landingEventPast![index];

                            final isLastItem =
                                index ==
                                landingEventProvider.landingEventPast!.length -
                                    1;

                            return Column(
                              children: [
                                EventLandingCard(
                                  id: event.id,
                                  title: event.title,
                                  location: event.location,
                                  createdBy: event.createdBy,
                                  startDate: event.startDate,
                                  endDate: event.endDate,
                                  banner: event.banner,
                                ),

                                if (isLastItem) Gap(75),
                              ],
                            );
                          },
                        ),
              ),
              if (_showBackToTop)
                scrollToUpButton(scrollController: _scrollController),
            ],
          ),
        );
      },
    );
  }
}
