import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:qr_event_management/features/Landing/presentation/pages/setting_page.dart';
import 'package:qr_event_management/features/Landing/presentation/widgets/event_view.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/home_view.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _homeScrollController;
  late AnimationController _borderRadiusController;
  late Animation<double> _borderRadiusAnimation;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    _homeScrollController = ScrollController();

    _borderRadiusController = AnimationController(
      vsync: this,
      // duration: const Duration(milliseconds: 200),
    );

    _borderRadiusAnimation = Tween<double>(begin: 0.0, end: 30.0).animate(
      CurvedAnimation(parent: _borderRadiusController, curve: Curves.easeInOut),
    );

    _homeScrollController.addListener(_onHomeScroll);
  }

  void _onHomeScroll() {
    const double scrollThreshold = 100.0;
    if (_homeScrollController.hasClients) {
      double scrollOffset = _homeScrollController.offset;
      double progress = (scrollOffset / scrollThreshold).clamp(0.0, 1.0);
      _borderRadiusController.animateTo(progress);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _homeScrollController.dispose();
    _borderRadiusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPage,
      body: SafeArea(
        child: Stack(
          children: [
            IndexedStack(
              index: _tabController.index,
              children: [
                // Tab 1: Home
                HomeView(
                  borderRadiusAnimation: _borderRadiusAnimation,
                  tabController: _tabController,
                  homeScrollController: _homeScrollController,
                ),
                // Tab 2: Events
                EventView(
                  borderRadiusAnimation: _borderRadiusAnimation,
                  tabController: _tabController,
                  homeScrollController: _homeScrollController,
                ),
                // Tab 3: Settings
                SettingView(borderRadiusAnimation: _borderRadiusAnimation, tabController: _tabController),
              ],
            ),

            _buildTabBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: AppColors.secondary, blurRadius: 30.0),
            ],
            color: Color(0xFFDDE9FF),
            borderRadius: BorderRadius.circular(25),
          ),
          child: TabBar(
            controller: _tabController,
            padding: EdgeInsets.all(4),
            indicator: BoxDecoration(
              color: AppColors.third,
              borderRadius: BorderRadius.circular(25),
            ),
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            unselectedLabelColor: Color(0xFF3F7CFF),
            labelColor: Colors.white,
            onTap: (value) {
              setState(() {});
            },
            tabs: [
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Iconify(
                    MaterialSymbols.home_rounded,
                    color: AppColors.primary,
                  ),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Iconify(Ri.calendar_2_fill, color: AppColors.primary),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Iconify(Ri.settings_fill, color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class SettingGroupHead extends StatelessWidget {
  final List<Widget> children;
  final String title;

  const SettingGroupHead({
    super.key,
    required this.children,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
        Gap(5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(children: children),
        ),
        Gap(10)
      ],
    );
  }
}

Widget topProfile() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Welcome!",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                "Nabil Dzikrika",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
            ],
          ),
        ],
      ),
      Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(217, 217, 217, 1000),
              ),
              child: Iconify(Ic.baseline_notifications),
            ),
          ),
        ],
      ),
    ],
  );
}
