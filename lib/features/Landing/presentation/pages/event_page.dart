import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qr_event_management/core/theme/app_colors.dart';

class EventLandingPage extends StatefulWidget {
  final ScrollController scrollController;

  final int tabIndex;

  const EventLandingPage({
    super.key,
    required this.scrollController,
    required this.tabIndex,
  });

  @override
  State<EventLandingPage> createState() => _EventLandingPageState();
}

class _EventLandingPageState extends State<EventLandingPage>
    with TickerProviderStateMixin {
  int _selectedTab = 0;

  final List<String> _tabs = ['Upcoming', 'Ongoing', 'Past'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_tabs.length, (index) {
                final isSelected = _selectedTab == index;
                return Expanded(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(15),
                        ),
                        backgroundColor:
                            isSelected ? AppColors.third : AppColors.grey1,
                        shadowColor: Colors.transparent,
                        foregroundColor:
                            isSelected ? AppColors.primary : AppColors.grey2,

                        // elevation: isSelected ? 2 : 0,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        textStyle: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedTab = index;
                        });
                      },
                      child: Text(_tabs[index]),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: _buildTabContent(_selectedTab),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return Column(key: ValueKey(0), children: [EventTabViewUpcoming()]);
      case 1:
        return Column(key: ValueKey(1), children: [EventTabViewOngoing()]);
      case 2:
        return Column(key: ValueKey(2), children: [EventTabViewPast()]);
      default:
        return SizedBox.shrink();
    }
  }
}

class EventTabViewOngoing extends StatelessWidget {
  const EventTabViewOngoing({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        
        return EventLandingCard();
      },
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
     
    );
  }
}

class EventLandingCard extends StatelessWidget {
  const EventLandingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20.0,
            offset: Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSMUi9wHqia_68xlAU7vP3E3sxn5K0KS-nUvBZk5jSJ54p8FPnw20uYV5yxNgF59DZoqc&usqp=CAU',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 130,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
              top: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSMUi9wHqia_68xlAU7vP3E3sxn5K0KS-nUvBZk5jSJ54p8FPnw20uYV5yxNgF59DZoqc&usqp=CAU',
                        fit: BoxFit.cover,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    Gap(10),
                    Text(
                      'CyberLabs Official',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                Gap(5),
                Text(
                  'AI and Associations',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                Text(
                  '2024-09-26 8:00 AM - 09-27 6:00 PM (GMT+08:00)',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.grey),
                ),
                Text(
                  'SpringField Convention Center, VA',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.green),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EventTabViewUpcoming extends StatelessWidget {
  const EventTabViewUpcoming({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [Text('Past EA')]);
  }
}

class EventTabViewPast extends StatelessWidget {
  const EventTabViewPast({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [Text('Past EC')]);
  }
}
