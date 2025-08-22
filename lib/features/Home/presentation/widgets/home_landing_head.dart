import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:provider/provider.dart';
import 'package:qr_event_management/features/Authentication/presentation/provider/authentication_provider.dart';

class HomeLandingHead extends StatefulWidget {
  final int tabIndex;

  const HomeLandingHead({super.key, required this.tabIndex});

  @override
  State<HomeLandingHead> createState() => _HomeLandingHeadState();
}

class _HomeLandingHeadState extends State<HomeLandingHead> {


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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Gap( 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      const Text(
                        "Welcome!",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                      authProvider.currentUser?.name ?? '',
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                      softWrap: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
      ),
    );
  }
}
