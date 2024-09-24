import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaring_lab/connection_controller.dart';
import 'package:soaring_lab/connectivity.dart';
import 'package:soaring_lab/main.dart';
import 'package:soaring_lab/src/core/constants.dart';
import 'package:soaring_lab/src/features/auth/controller/auth_view_model.dart';
import 'package:soaring_lab/src/features/home/controller/home_view_model.dart';
import 'package:soaring_lab/src/features/profile/controller/profile_view_model.dart';
import 'package:soaring_lab/src/features/splash/appunavailable.dart';
import 'package:soaring_lab/src/features/splash/instructionPage.dart';
import 'package:soaring_lab/src/services/hive_storage.dart';
import 'package:soaring_lab/src/themes/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final MyConnectivity _connectivity = MyConnectivity.instance;

  void initState() {
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      if (mounted) {
        context.read<ConnectionController>().setconnection(source);
      }
    });

    // TODO: implement onInit
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // log("conn typr ${context.read<ConnectionController>().connectiontype}");

    if (context.watch<ConnectionController>().connectiontype !=
            'Not Connected' &&
        context.watch<ConnectionController>().connectiontype != null) {
      context.read<AuthViewModel>().getAppstatus(context).then((value) {
        if (context.read<AuthViewModel>().appstatusdata['items']['status'] !=
                'empty' &&
            context.read<AuthViewModel>().appstatusdata['items']['status'] !=
                true) {
          Future.delayed(const Duration(seconds: 3), () {
            bool isLoginUser = authstoragebox.get('islogin') ?? false;

            if (isLoginUser) {
              final viewModelhome = context.read<HomeViewModel>();

              context.read<ProfileViewModel>().getProfile(context).then(
                (value) {
                  context.read<HomeViewModel>().fetchroundsdata(context).then(
                    (value) {
                      if (viewModelhome.currentmatch == 0) {
                        Navigator.of(context)
                            .pushReplacementNamed('/bottom-bar');
                        // Navigator.of(context)
                        //     .pushReplacementNamed('/Matchjoinandcreate');
                      } else {
                        // Navigator.of(context).pushReplacementNamed('/bottom-bar');
                        Navigator.of(context).pushReplacementNamed('/home');
                      }
                    },
                  );
                  // context.read<HomeViewModel>().matchchange(1);
                  // matchdatabox.put('round_number', value!.round_number);
                  // matchdatabox.put('match_number', value.match_number);
                },
              );

              // ('/home');
            } else {
              // if (showcasebox.get('roundScreen') != 'done') {
              //   Navigator.pushReplacement(context,
              //       MaterialPageRoute(builder: (context) {
              //     return const Instructionpage();
              //   }));
              // } else {
              Navigator.of(context).pushReplacementNamed('/login');
              // }

              // Navigator.of(context).pushReplacementNamed('/home');
            }
          });
        } else {
          showPrivacyPolicyBottomSheet();
        }
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(applogo),
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

          // Visibility(
          //   visible: context.read()<AuthViewModel>().appstatusdata['items']
          //           ['status'] ==
          //       true,
          //   child: Center(
          //     child: Container(
          //       margin: EdgeInsets.all(10),
          //       padding: EdgeInsets.all(10),
          //       height: mq.height * 0.25,
          //       // width: double.infinity,
          //       decoration: BoxDecoration(
          //           color: AppTheme.primaryColor,
          //           borderRadius: BorderRadius.circular(25)),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: <Widget>[
          // Icon(Icons.warning,
          //     size: 80,
          //     color: const Color.fromARGB(255, 204, 53, 42)),
          //           SizedBox(height: 20),
          //           Material(
          //             color: AppTheme.primaryColor,
          //             child: Text(
          // context
          //     .read<AuthViewModel>()
          //     .appstatusdata['items']['status']
          //     .toString(),
          //               style: TextStyle(
          //                   fontSize: 24,
          //                   color: const Color.fromARGB(255, 255, 255, 255)),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  void showPrivacyPolicyBottomSheet() {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.privacy_tip,
                        size: 48.0,
                        color: const Color.fromARGB(255, 204, 53, 42)),
                    const SizedBox(width: 8.0),
                    Text(
                      'App unavailable',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 204, 53, 42)),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),

                Column(
                  children: [
                    Text(
                      context
                          .read<AuthViewModel>()
                          .appstatusdata['items']['message']
                          .toString(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[700],
                            fontSize: 16.0,
                          ),
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                    
                         " We apologize for any inconvenience caused and appreciate your understanding in this matter. For further inquiries or assistance, feel free to contact us for more detailed information regarding the service status.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                            fontSize: 14.0,
                          ),
                    ),
                  ],
                ),
                //   ),
                // ),
                // const Spacer(),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
