import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:soaring_lab/Showcaseview.dart';
import 'package:soaring_lab/connection_controller.dart';
import 'package:soaring_lab/connectivity.dart';
import 'package:soaring_lab/main.dart';
import 'package:soaring_lab/src/core/constants.dart';
import 'package:soaring_lab/src/features/home/controller/home_view_model.dart';
import 'package:soaring_lab/src/features/home/view/home_page.dart';
import 'package:soaring_lab/src/features/splash/instructionPage.dart';
import 'package:soaring_lab/src/features/start_contest/controller/startr_contest_controller.dart';
import 'package:soaring_lab/src/services/hive_storage.dart';
import 'package:soaring_lab/src/themes/app_fonts.dart';
import 'package:soaring_lab/src/themes/app_theme.dart';
import 'package:soaring_lab/src/widgets/common_button.dart';
import 'package:soaring_lab/src/widgets/custom_text_form_field.dart';
import 'package:soaring_lab/src/widgets/dynamic_toast.dart';

class Matchjoinandcreate extends StatefulWidget {
  const Matchjoinandcreate({super.key});

  @override
  State<Matchjoinandcreate> createState() => _MatchjoinandcreateState();
}

class _MatchjoinandcreateState extends State<Matchjoinandcreate> {
  GlobalKey one = GlobalKey();
  GlobalKey two = GlobalKey();
  GlobalKey three = GlobalKey();
  GlobalKey four = GlobalKey();
  GlobalKey five = GlobalKey();
  // ShowCaseWidget.of(context).next();
  // showcasebox.get('roundScreen') != 'done',
  final MyConnectivity _connectivity = MyConnectivity.instance;

  void initState() {
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      context.read<ConnectionController>().setconnection(source);
    });
    // TODO: implement onInit
    super.initState();
  }

  // @override
  // void initState() {
  // if (showcasebox.get('contestScreen') != 'done') {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     ShowCaseWidget.of(context).startShowCase([one, two, three, four, five]);

  //     showcasebox.put('contestScreen', 'done');
  //   });
  // }
  // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    log("on bottom nave bar page" +
        context.watch<ConnectionController>().connectiontype.toString());
    final viewModelhome = context.read<HomeViewModel>();
    final theme = Theme.of(context);
    final font = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Consumer<StartrContestController>(
        builder: (context, viewModel, _) {
          return Stack(
            children: [
              // Showcase.withWidget(
              //   height: 100,
              //   width: 100,
              //   container: Text("Skip"),
              //   key: two,
              //   child: ElevatedButton(
              //     child: Text("Skip"),
              //     onPressed: () {},
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: mq.height * 0.1),
                      Image.asset(
                        applogo,
                        height: mq.height * 0.18,
                      ),
                      SizedBox(height: mq.height * 0.05),
                      if (viewModel.visiblebutton)
                        ShowCaseView(
                          height: 0.521,
                          gkey: two,
                          title: "Contest code",
                          description:
                              "Enter your contest code if you get shared",
                          child: CommonButton(
                            text: 'Join contest',
                            onPressed: () {
                              if (viewModel
                                  .contestCodeController.text.isNotEmpty) {
                                int contestcode = int.parse(
                                    viewModel.contestCodeController.text);
                                if (context
                                        .read<HomeViewModel>()
                                        .getcontestcodetemp !=
                                    contestcode) {
                                  viewModelhome
                                      .createandjoinmatch(contestcode)
                                      .then(
                                    (value) {
                                      log("bool value$value");
                                      if (value == true) {
                                        viewModelhome.clearRounds();
                                        context
                                            .read<HomeViewModel>()
                                            .getcontestcodetemp = null;
                                        viewModel.contestCodeController.clear();
                                        // Navigator.of(context).pop();
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const HomePage();
                                        }));
                                      }
                                      // else {
                                      //   DynamicToast.show("Something went wrong");
                                      // }
                                    },
                                  );
                                } else {
                                  DynamicToast.show("Please enter valid code");
                                }

                                print(contestcode);
                              } else {
                                DynamicToast.show("Please enter contest code");
                              }
                              // showDialog(
                              //   context: context,
                              //   builder: (BuildContext context) {
                              //     return AlertDialog(
                              //       title: Text(
                              //         'Enter contest code',
                              //         textAlign: TextAlign.center,
                              //         style: AppFonts.headline2,
                              //       ),
                              //       content: CustomTextFormField(
                              //         controller: viewModel.contestCodeController,
                              //         hintText: 'contest code',
                              //         validator: (value) {
                              //           if (value == null || value.isEmpty) {
                              //             return 'Please enter your code';
                              //           }
                              //           return null;
                              //         },
                              //         onTap: () {},
                              //         keyboardType: TextInputType.number,
                              //         readOnly: false,
                              //         autoValidate: true,
                              //       ),
                              //       actions: [
                              //         Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceEvenly,
                              //           children: [
                              // CommonButton(
                              //   text: 'Cancel',
                              //   fontSize: 12,
                              //   width: 80,
                              //   backgroundColor: AppTheme.primaryColor,
                              //   textColor: Colors.white,
                              //   onPressed: () {
                              //     viewModel.contestCodeController
                              //         .clear();
                              //     Navigator.of(context)
                              //         .pop(); // Close the dialog
                              //   },
                              // ),
                              //             CommonButton(
                              //               text: 'Join',
                              //               fontSize: 12,
                              //               width: 80,
                              //               backgroundColor: AppTheme.primaryColor,
                              //               textColor: Colors.white,
                              //               onPressed: () {
                              //                 if (viewModel.contestCodeController
                              //                     .text.isNotEmpty) {
                              //                   int contestcode = int.parse(
                              //                       viewModel.contestCodeController
                              //                           .text);
                              //                   print(contestcode);

                              //                   viewModelhome
                              //                       .createandjoinmatch(contestcode)
                              //                       .then(
                              //                     (value) {
                              //                       log("bool value" +
                              //                           value.toString());
                              //                       if (value == true) {
                              //                         Navigator.of(context).pop();
                              //                         Navigator.of(context)
                              //                             .pushNamed('/home');
                              //                       } else {
                              //                         DynamicToast.show(
                              //                             "Something went wrong");
                              //                       }
                              //                     },
                              //                   );
                              //                 } else {
                              //                   DynamicToast.show(
                              //                       "Please enter contest code");
                              //                 }

                              //                 // Close the dialog
                              //               },
                              //             ),
                              //           ],
                              //         ),
                              //       ],
                              //     );
                              //   },
                              // );
                              // matchdatabox.clear();
                              // matchdatabox.put('match_number', 6);
                              // log("Update Flight");
                              // viewModel
                              //     .addtestMatch(context, update: true)
                              //     .then(
                              //   (value) {
                              //     if (value == true) {
                              //       viewModel.fetchroundsdata(context);
                              //       // .then(
                              //       //   (value) =>
                              //       //       // viewModel.updatebutton(),
                              //       // );
                              //     } else {
                              //       DynamicToast.show(
                              //           "Something went wrong");
                              //     }
                              //   },
                              // );
                            },
                            height: 30,
                            backgroundColor: AppTheme.primaryColor,
                            textColor: theme.colorScheme.onPrimary,
                            width: size.width * 1,
                            fontSize: size.width * 0.04,
                          ),
                        ),
                      const SizedBox(height: 5),
                      if (viewModel.visiblebutton)
                        // Text(
                        //   'Enter contest code',
                        // textAlign: TextAlign.center,
                        // style: AppFonts.headline3,
                        // ),
                        const SizedBox(height: 20),
                      if (viewModel.visiblebutton)
                        ShowCaseView(
                          height: 0.4,
                          gkey: one,
                          title: "Enter contest code",
                          description:
                              "Enter your contest code if you get shared",
                          child: CustomTextFormField(
                            controller: viewModel.contestCodeController,
                            hintText: 'Enter contest code',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter contest code';
                              }
                              return null;
                            },
                            onTap: () {},
                            inputformaters: true,
                            keyboardType: TextInputType.number,
                            readOnly: false,
                            autoValidate: true,
                          ),
                        ),
                      const SizedBox(height: 25),
                      if (viewModel.visiblebutton)
                        ShowCaseView(
                          height: 0.32,
                          gkey: three,
                          title: "Get contest code",
                          description:
                              "Click here to get a new contest code if you want to create a new contest",
                          child: CommonButton(
                            text: 'Start new contest / Get code',
                            fontSize: 16,
                            width: double.infinity,
                            backgroundColor: AppTheme.primaryColor,
                            textColor: Colors.white,
                            onPressed: () {
                              // setState(() {
                              //   visiblebutton = false;
                              // });
                              viewModelhome.createandjoinmatch(0).then(
                                (value) {
                                  if (value == true) {
                                    viewModel.changebutton();
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Somthing Went Wrong',
                                            textAlign: TextAlign.center,
                                            style: AppFonts.headline2,
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                CommonButton(
                                                  text: 'Retry',
                                                  fontSize: 12,
                                                  width: 80,
                                                  backgroundColor:
                                                      AppTheme.primaryColor,
                                                  textColor: Colors.white,
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    // Close the dialog
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                              );

                              // viewModel.contestCodeController.clear();
                              // Navigator.of(context).pop(); // Close the dialog
                            },
                          ),
                        ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (!viewModel.visiblebutton)
                        ShowCaseView(
                          tooltipPosition: TooltipPosition.top,
                          height: 0.55,
                          gkey: four,
                          title: "Contest code",
                          description:
                              "Here your new contest code will be displayed you can share your friends to join",
                          child: Container(
                            // padding: const EdgeInsets.all(20),

                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                // boxShadow: [
                                //   BoxShadow(
                                //     spreadRadius: 2,
                                //     color: Colors.grey.shade100,
                                //     blurRadius: 1,
                                //   )
                                // ],
                                color: const Color.fromARGB(255, 239, 244, 247),
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: Text(
                              "${context.watch<HomeViewModel>().getcontestcodetemp ?? ''}",
                              style: AppFonts.customSubtitle1.copyWith(
                                  color: const Color.fromARGB(255, 196, 21, 21),
                                  fontSize: 22),
                            )),
                          ),
                        ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (!viewModel.visiblebutton)
                        ShowCaseView(
                          tooltipPosition: TooltipPosition.top,
                          height: 0.627,
                          gkey: five,
                          title: "Start contest",
                          description: "Tap here to start the match",
                          child: CommonButton(
                            text: 'Start new contest',
                            onPressed: () {
                              if (context
                                      .read<HomeViewModel>()
                                      .getcontestcodetemp !=
                                  null) {
                                context
                                    .read<HomeViewModel>()
                                    .getcontestcodetemp = null;
                                viewModel.contestCodeController.clear();
                                viewModel.changebutton();
                                viewModelhome.clearRounds();

                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const HomePage();
                                }));
                              }
                              // Navigator.of(context).pushNamed('/home');
                              // }
                              else {
                                DynamicToast.show(
                                    "Please get contest code first");
                              }
                              // showDialog(
                              //   context: context,
                              //   builder: (BuildContext context) {
                              //     return AlertDialog(
                              //       title: Text(
                              //         'Are you sure you want to create the contest?',
                              //         textAlign: TextAlign.center,
                              //         style: AppFonts.headline2,
                              //       ),
                              //       actions: [
                              //         Row(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceEvenly,
                              //           children: [
                              //             CommonButton(
                              //               text: 'No',
                              //               fontSize: 12,
                              //               width: 80,
                              //               backgroundColor: AppTheme.primaryColor,
                              //               textColor: Colors.white,
                              //               onPressed: () {
                              //                 Navigator.of(context)
                              //                     .pop(); // Close the dialog
                              //               },
                              //             ),
                              //             CommonButton(
                              //               text: 'Yes',
                              //               fontSize: 12,
                              //               width: 80,
                              //               backgroundColor: AppTheme.primaryColor,
                              //               textColor: Colors.white,
                              //               onPressed: () {
                              //                 viewModelhome
                              //                     .createandjoinmatch(0)
                              //                     .then(
                              //                   (value) {
                              //                     if (value == true) {
                              //                       Navigator.of(context).pop();
                              //                       Navigator.of(context)
                              //                           .pushNamed('/home');
                              //                     } else {
                              //                       DynamicToast.show(
                              //                           "Something went wrong");
                              //                     }
                              //                   },
                              //                 );
                              //                 // Close the dialog
                              //               },
                              //             ),
                              //           ],
                              //         ),
                              //       ],
                              //     );
                              //   },
                              // );
                            },
                            height: 30,
                            backgroundColor: AppTheme.primaryColor,
                            textColor: theme.colorScheme.onPrimary,
                            width: size.width * 1,
                            fontSize: size.width * 0.04,
                          ),
                        ),
                      const SizedBox(height: 15),
                      CommonButton(
                        text: 'Contest Instruction',
                        fontSize: 16,
                        width: double.infinity,
                        backgroundColor: AppTheme.primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const Instructionpage();
                          }));
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Visibility(
              //   visible: visiblebutton == false,
              //   child: Positioned(
              //     top: ,
              //     child: Container(
              //       height: 200,
              //       color: Colors.grey,
              //       child: BackdropFilter(
              //         filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              //         child: Container(
              //           color: Colors.transparent,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Visibility(
                visible: viewModel.isloading,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
              Visibility(
                visible: viewModel.isloading,
                child: const Center(
                    child: CupertinoActivityIndicator(
                  color: Colors.white,
                )),
              ),
              Visibility(
                  visible:
                      context.watch<ConnectionController>().connectiontype ==
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
                                color:
                                    const Color.fromARGB(255, 255, 255, 255)),
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
      ),
    );
  }
}
// <uses-permission android:name="android.permission.INTERNET"/>
// <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
