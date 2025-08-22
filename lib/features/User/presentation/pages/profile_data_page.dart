import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qr_event_management/features/Authentication/presentation/widgets/back_button.dart';
import 'package:qr_event_management/widgets/text_fields.dart';

class ProfileDataPage extends StatefulWidget {
  const ProfileDataPage({super.key});

  @override
  State<ProfileDataPage> createState() => _ProfileDataPageState();
}

class _ProfileDataPageState extends State<ProfileDataPage> {
  final TextEditingController _nameController = TextEditingController(
    text: "Nabil Dzikrika",
  );
  final TextEditingController _emailController= TextEditingController(
    text: "nabildzikrika@gmail.com",
  );
  final TextEditingController _phoneNumberController = TextEditingController(
    text: "+62 878-1403-7811",
  );
  final TextEditingController _roleController= TextEditingController(
    text: "Administrator",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Your Profile Data', style: TextStyle(fontWeight: FontWeight.bold),),
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
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSMUi9wHqia_68xlAU7vP3E3sxn5K0KS-nUvBZk5jSJ54p8FPnw20uYV5yxNgF59DZoqc&usqp=CAU',
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
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

// class ProfileDataItem extends StatelessWidget {
//   final String text;
//   final Color? textColor;
//   final String icon;

//   const ProfileDataItem({
//     super.key, required this.text, required this.icon, this.textColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Iconify(icon, size: 25),
//         Gap(10),
//         Text(
//           text,
//           style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: textColor ?? Colors.black),
//         ),
//       ],
//     );
//   }
// }
