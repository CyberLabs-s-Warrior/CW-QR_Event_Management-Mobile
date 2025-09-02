import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../widgets/text_fields.dart';
import '../../../Authentication/presentation/widgets/back_button.dart';

class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({super.key});

  @override
  State<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  final TextEditingController _nameController = TextEditingController(
    text: "Example User",
  );
  final TextEditingController _emailController = TextEditingController(
    text: "example@gmail.com",
  );
  final TextEditingController _phoneNumberController = TextEditingController(
    text: "+62 878-8888-9999",
  );
  final TextEditingController _roleController = TextEditingController(
    text: "Administrator",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPage,
      appBar: AppBar(
        title: Text(
          'Edit your Account Details',
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
                child: Stack(
                  children: [
                    ClipRRect(
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
                              decoration: BoxDecoration(
                                color: AppColors.secondary,
                              ),
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
                              decoration: BoxDecoration(
                                color: AppColors.secondary,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.broken_image,
                                  color: AppColors.primary,
                                  size: 100
                                ),
                              ),
                            ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          print('clicked open photo');
                        },
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   top: 8,
                    //   right: 8,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       print('clicked delete photo');
                    //     },
                    //     child: Container(
                    //       width: 48,
                    //       height: 48,
                    //       decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         shape: BoxShape.circle,
                    //         border: Border.all(color: Colors.white, width: 3),
                    //       ),
                    //       child: const Iconify(
                    //         SystemUicons.cross,
                    //         color: Colors.red,
                    //         size: 24,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Gap(40),
              GeneralTextField(
                controller: _nameController,
                hintText: 'Your Name',
                prefixIcon: Icons.verified_user_outlined,
              ),
              Gap(20),
              GeneralTextField(
                controller: _emailController,
                hintText: 'Your Email',
                prefixIcon: Icons.email_outlined,
                readOnly: true,
              ),
              Gap(20),
              GeneralTextField(
                controller: _phoneNumberController,
                hintText: 'Your Phone Number',
                prefixIcon: Icons.phone_outlined,
              ),
              Gap(20),
              GeneralTextField(
                controller: _roleController,
                hintText: 'Nabil Dzikrika',
                prefixIcon: Icons.supervised_user_circle_outlined,
                readOnly: true,
              ),

              Spacer(),
              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    minimumSize: Size(100, 55),
                  ),
                  onPressed: () {
                    print('confirm editing...');
                  },
                  child: const Text(
                    'Confirm my Editing',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFCED4FF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
