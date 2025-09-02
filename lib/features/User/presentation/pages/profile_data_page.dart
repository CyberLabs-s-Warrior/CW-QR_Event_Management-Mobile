import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';

import '../../../../widgets/text_fields.dart';
import '../../../Authentication/presentation/widgets/back_button.dart';

class ProfileDataPage extends StatefulWidget {
  const ProfileDataPage({super.key});

  @override
  State<ProfileDataPage> createState() => _ProfileDataPageState();
}

class _ProfileDataPageState extends State<ProfileDataPage> {
  final TextEditingController _nameController = TextEditingController(
    text: "Nabil Dzikrika",
  );
  final TextEditingController _emailController = TextEditingController(
    text: "nabildzikrika@gmail.com",
  );
  final TextEditingController _phoneNumberController = TextEditingController(
    text: "+62 878-1403-7811",
  );
  final TextEditingController _roleController = TextEditingController(
    text: "Administrator",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Your Profile Data',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: AuthenticationCustomBackButton(
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSMUi9wHqia_68xlAU7vP3E3sxn5K0KS-nUvBZk5jSJ54p8FPnw20uYV5yxNgF59DZoqc&usqp=CAU",
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) => Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(color: AppColors.secondary),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                              strokeWidth: 10,
                            ),
                          ),
                        ),
                    errorWidget:
                        (context, url, error) => Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(color: AppColors.secondary),
                          child: Center(
                            child: Icon(
                              Icons.broken_image,
                              color: AppColors.primary,
                              size: 100,
                            ),
                          ),
                        ),
                  ),
                ),
              ),
              Gap(40),
              GeneralTextField(
                controller: _nameController,
                hintText: 'Nabil Dzikrika',
                prefixIcon: Icons.verified_user_outlined,
                readOnly: true,
              ),
              Gap(20),
              GeneralTextField(
                controller: _emailController,
                hintText: 'Nabil Dzikrika',
                prefixIcon: Icons.email_outlined,
                readOnly: true,
              ),
              Gap(20),
              GeneralTextField(
                controller: _phoneNumberController,
                hintText: 'Nabil Dzikrika',
                prefixIcon: Icons.phone_outlined,
                readOnly: true,
              ),
              Gap(20),
              GeneralTextField(
                controller: _roleController,
                hintText: 'Nabil Dzikrika',
                prefixIcon: Icons.supervised_user_circle_outlined,
                readOnly: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
