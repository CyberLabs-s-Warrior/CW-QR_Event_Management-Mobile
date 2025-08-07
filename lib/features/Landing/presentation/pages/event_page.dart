import 'package:flutter/material.dart';

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

class _EventLandingPageState extends State<EventLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: SingleChildScrollView(child: Column(children: [
            
          ],
        )),
    );
  }
}
