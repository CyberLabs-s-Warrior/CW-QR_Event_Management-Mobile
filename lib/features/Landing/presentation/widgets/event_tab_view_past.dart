import 'package:flutter/material.dart';
import 'event_landing_card.dart';
import '../../../../gen/scroll/scroll_to_up_button.dart';

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
    return SizedBox(
      height: MediaQuery.of(context).size.height - 250,
      child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 1));
            },
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(bottom: 150),
              itemCount: 100,
              itemBuilder: (context, index) {
                return EventLandingCard();
              },
              physics: const AlwaysScrollableScrollPhysics(),
            ),
          ),
          if (_showBackToTop)
            scrollToUpButton(scrollController: _scrollController),
        ],
      ),
    );
  }
}