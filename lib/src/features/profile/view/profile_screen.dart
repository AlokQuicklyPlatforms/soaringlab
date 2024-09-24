import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaring_lab/connection_controller.dart';
import 'package:soaring_lab/main.dart';
import 'package:soaring_lab/src/features/auth/view/login_page.dart';
import 'package:soaring_lab/src/features/profile/controller/profile_view_model.dart';
import 'package:soaring_lab/src/features/settings/view/setting_screen.dart';
import 'package:soaring_lab/src/features/splash/instructionPage.dart';
import 'package:soaring_lab/src/services/hive_storage.dart';
import 'package:soaring_lab/src/themes/app_fonts.dart';
import 'package:soaring_lab/src/themes/app_theme.dart';
import 'package:soaring_lab/src/widgets/common_button.dart';

import '../../../core/constants.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                  onPressed: () {
                    // showcasebox.clear();
                    // authstoragebox.clear();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingScreen(),
                      ),
                    );
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const LoginPage(),
                    //     ),
                    //     (route) => false);
                  },
                  icon: const Icon(Icons.settings))
            ],
          ),
          body: Consumer<ProfileViewModel>(
            builder: (context, viewModel, _) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      applogo,
                      height: mq.height * 0.18,
                    ),
                    // SizedBox(
                    //   height: mq.height * 0.15,
                    // ),
                    Align(
                        alignment: Alignment.center,
                        child: Text("MY PROFILE",
                            textAlign: TextAlign.center,
                            style: AppFonts.headline1.copyWith(fontSize: 40)
                            // style: AppFonts.stencilfont
                            )),
                    SizedBox(
                      height: mq.height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: CommonButton(
                        text: 'Name',
                        fontSize: 16,
                        width: double.infinity,
                        backgroundColor: AppTheme.primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          //             Navigator.pushReplacement(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return const Instructionpage();
                          // }));
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              color: Colors.grey.shade100,
                              blurRadius: 1,
                            )
                          ],
                          color: const Color.fromARGB(255, 239, 244, 247),
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          // const Icon(
                          //   Icons.person,
                          //   size: 50,
                          // ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text("Name",
                              //     style: AppFonts.customBody1
                              //         .copyWith(fontWeight: FontWeight.w700)),
                              Text(viewModel.currentuser.pilotName,
                                  style: AppFonts.customBody1
                                      .copyWith(color: Colors.grey))
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: CommonButton(
                        text: 'Email',
                        fontSize: 16,
                        width: double.infinity,
                        backgroundColor: AppTheme.primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          //             Navigator.pushReplacement(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return const Instructionpage();
                          // }));
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              color: Colors.grey.shade100,
                              blurRadius: 1,
                            )
                          ],
                          color: const Color.fromARGB(255, 239, 244, 247),
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          // const Icon(
                          //   Icons.email,
                          //   size: 50,
                          // ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text("Email",
                              //     style: AppFonts.customBody1
                              //         .copyWith(fontWeight: FontWeight.w700)),
                              Text(viewModel.currentuser.email,
                                  style: AppFonts.customBody1
                                      .copyWith(color: Colors.grey))
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(22.0),
                    //   child: CommonButton(
                    //     text: 'Instruction',
                    //     fontSize: 16,
                    //     width: double.infinity,
                    //     backgroundColor: AppTheme.primaryColor,
                    //     textColor: Colors.white,
                    //     onPressed: () {
                    //       Navigator.push(context,
                    //           MaterialPageRoute(builder: (context) {
                    //         return const Instructionpage();
                    //       }));
                    //     },
                    //   ),
                    // ),
                    // Text("Delete your account",
                    //     style: AppFonts.headline1.copyWith(color: Colors.red)),
                    SizedBox(
                      height: 52,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Visibility(
            visible: context.watch<ConnectionController>().connectiontype ==
                'Not Connected',
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            )),
        Visibility(
          visible: context.watch<ConnectionController>().connectiontype ==
              'Not Connected',
          child: Center(
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              height: mq.height * 0.25,
              // width: double.infinity,
              decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(25)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(CupertinoIcons.wifi_slash,
                      size: 80, color: const Color.fromARGB(255, 204, 53, 42)),
                  SizedBox(height: 20),
                  Material(
                    color: AppTheme.primaryColor,
                    child: Text(
                      'No Internet Connection',
                      style: TextStyle(
                          fontSize: 24,
                          color: const Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
