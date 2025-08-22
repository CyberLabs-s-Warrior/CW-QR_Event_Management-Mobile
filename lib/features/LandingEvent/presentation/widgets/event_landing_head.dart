import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';

class EventLandingHead extends StatelessWidget {
  final int tabIndex;

  const EventLandingHead({super.key, required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 27.0,
        left: 20.0,
        right: 20.0,
        bottom: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "Events",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
            ],
          ),
          Row(
            children: [
              CustomHeadIconButton(iconify: Iconify(Ic.round_bookmark_added)),
              Gap(10),
              CustomHeadIconButton(iconify: Iconify(MaterialSymbols.search_rounded)),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomHeadIconButton extends StatelessWidget {
  final Iconify iconify;

  const CustomHeadIconButton({super.key, required this.iconify});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(217, 217, 217, 1000),
        ),
        child: iconify,
      ),
    );
  }
}
