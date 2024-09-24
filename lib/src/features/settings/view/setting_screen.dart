import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaring_lab/connection_controller.dart';
import 'package:soaring_lab/main.dart';
import 'package:soaring_lab/src/core/constants.dart';
import 'package:soaring_lab/src/features/auth/view/login_page.dart';
import 'package:soaring_lab/src/features/profile/controller/profile_view_model.dart';
import 'package:soaring_lab/src/features/splash/instructionPage.dart';
import 'package:soaring_lab/src/services/hive_storage.dart';
import 'package:soaring_lab/src/themes/app_theme.dart';
import 'package:soaring_lab/src/widgets/common_button.dart';
import 'package:soaring_lab/src/widgets/dynamic_toast.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, viewModel, _) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                surfaceTintColor: Colors.white,
                backgroundColor: Colors.white,
              ),
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      applogo,
                      height: mq.height * 0.18,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: CommonButton(
                        text: 'Log out',
                        fontSize: 16,
                        width: double.infinity,
                        backgroundColor: AppTheme.primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          authstoragebox.clear();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                              (route) => false);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: CommonButton(
                        text: 'Delete Your account',
                        fontSize: 16,
                        width: double.infinity,
                        backgroundColor: AppTheme.primaryColor,
                        textColor: Color.fromARGB(255, 255, 5, 5),
                        onPressed: () {
                          viewModel.deleteaccount(context).then(
                            (value) {
                              if (value = true) {
                                authstoragebox.clear();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                    (route) => false);
                              } else {
                                DynamicToast.show("Unable to delete account");
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ]),
            ),
            if (viewModel.isLoading)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                child: Container(
                  alignment: Alignment.center,
                ),
              ),
            viewModel.isLoading
                ? const Center(
                    child: CupertinoActivityIndicator(
                    radius: 15,
                  ))
                : const SizedBox(),
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
                          size: 80,
                          color: const Color.fromARGB(255, 204, 53, 42)),
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
      },
    );
  }
}
