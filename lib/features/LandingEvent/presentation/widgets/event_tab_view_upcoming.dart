import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:provider/provider.dart';
import '../../../../gen/loading/wave_loading.dart';

import '../../../../core/constant/enum_status.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../gen/scroll/scroll_to_up_button.dart';
import '../../../Authentication/presentation/provider/authentication_provider.dart';
import '../provider/landing_event_provider.dart';
import 'event_landing_card.dart';

class EventTabViewUpcoming extends StatefulWidget {
  const EventTabViewUpcoming({super.key});

  @override
  State<EventTabViewUpcoming> createState() => _EventTabViewUpcomingState();
}

class _EventTabViewUpcomingState extends State<EventTabViewUpcoming> {
  late ScrollController _scrollController;
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    final user = context.read<AuthenticationProvider>();

    final landingEventProvider = context.read<LandingEventProvider>();
    landingEventProvider.getEventUpcoming(
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
                  await landingEventProvider.getEventUpcoming(
                    token: authProvider.currentUser!.token,
                    userId: authProvider.currentUser!.id,
                  );
                },
                child:
                    landingEventProvider.landingEventUpcomingStatus ==
                            ResponseStatus.loading
                        ? WaveLoading()
                        : landingEventProvider.landingEventUpcomingStatus ==
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
                                textAlign: TextAlign.center,
                              ),
                              Gap(100),
                            ],
                          ),
                        )
                        : (landingEventProvider.landingEventUpcoming?.isEmpty ??
                            true)
                        ? const Center(child: Text('No event yet'))
                        : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount:
                              landingEventProvider.landingEventUpcoming!.length,
                          itemBuilder: (context, index) {
                            final event =
                                landingEventProvider
                                    .landingEventUpcoming![index];

                            final isLastItem =
                                index ==
                                landingEventProvider
                                        .landingEventUpcoming!
                                        .length -
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
