import 'dart:developer';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:soaring_lab/Showcaseview.dart';
import 'package:soaring_lab/connection_controller.dart';
import 'package:soaring_lab/connectivity.dart';
import 'package:soaring_lab/main.dart';
import 'package:soaring_lab/src/features/bottom_nav_bar/bottom_nav_bar.dart';

import 'package:soaring_lab/src/features/home/model/CalculatedScore.dart';
import 'package:soaring_lab/src/features/home/view/widgets/round_detail_card.dart';
import 'package:soaring_lab/src/features/profile/controller/profile_view_model.dart';
import 'package:soaring_lab/src/services/hive_storage.dart';
import 'package:soaring_lab/src/themes/app_fonts.dart';
import 'package:soaring_lab/src/themes/app_theme.dart';
import 'package:soaring_lab/src/widgets/dynamic_toast.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/title_card_widget.dart';
import '../controller/home_view_model.dart';
import 'round_form.dart';
import 'widgets/round_card.dart';
import 'widgets/sub_tite_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // GlobalKey one = GlobalKey();
  // GlobalKey two = GlobalKey();
  // GlobalKey three = GlobalKey();
  // GlobalKey four = GlobalKey();
  // GlobalKey five = GlobalKey();
  List<GlobalKey> globalKeys =
      List<GlobalKey>.generate(17, (index) => GlobalKey());
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
  // if (showcasebox.get('roundScreen') != 'done') {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     ShowCaseWidget.of(context).startShowCase(
  //       globalKeys,
  //     );

  //     showcasebox.put('roundScreen', 'done');

  //     log("Demo done>>>>>>");
  //   });
  // }

  // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    int i = 1;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: Visibility(
            visible: context.watch<HomeViewModel>().currentmatch == 0 ||
                context.watch<HomeViewModel>().roundcomplete
            // showcasebox.get('roundScreen') != 'done'
            ,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ShowCaseView(
                fun: (val) {
                  if (val == 'next' || val == 'skip') {
                    setState(() {
                      log("setState called");
                    });
                  }
                },
                tooltipPosition: TooltipPosition.top,
                height: 0.8,

                // onBarrierClick: () {
                //   setState(() {});
                // },
                title: "Back",
                description:
                    "Tap here to get back after complete 10 round of the match or finish the match ",
                gkey: globalKeys[16],
                child: CommonButton(
                  text: 'New game',
                  onPressed: () {
                    context.read<HomeViewModel>().resetdialer();
                    context.read<HomeViewModel>().roundComplete(false);

                    context.read<HomeViewModel>().matchchange(0);

                    context.read<HomeViewModel>().nextround(true);
                    context.read<HomeViewModel>().clearRounds();
                    // if (i == 0) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return const BottomNavBar();
                    }));

                    // Navigator.of(context).pushReplacementNamed('/bottom-bar');
                    // } else {
                    //   DynamicToast.show(
                    //       "Tap twice to get back to homepage for new game");
                    //   i--;
                    //   Future.delayed(const Duration(seconds: 2), () {
                    //     i++;
                    //   });
                    // }
                  },
                  backgroundColor: AppTheme.primaryColor,
                  textColor: theme.colorScheme.onPrimary,
                  width: mq.width * 0.47,
                  fontSize: mq.width * 0.045,
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<HomeViewModel>(
              builder: (__, viewModel, _) {
                return Stack(
                  children: [
                    ListView(
                      primary: true,
                      shrinkWrap: true,
                      children: [
                        // TextButton(
                        //   onPressed: () {
                        //     AppInitializer().storage.erase();
                        //     // Navigator.of(context).pushNamedAndRemoveUntil(
                        //     //   '/login',
                        //     //   (route) => false,
                        //     // );

                        //     Navigator.pushAndRemoveUntil(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => const LoginPage(),
                        //         ),
                        //         (route) => false);
                        //   },
                        //   child: const Text("logout"),
                        // ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          child: TitleCardWidget(
                            t1: 'Scoring',
                            t2: 'Soaring Lab',
                          ),
                        ),
                        const SizedBox(height: 5),
                        Consumer<ProfileViewModel>(
                            builder: (context, viewModel2, _) {
                          log("current match ${viewModel.currentmatch}");

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: SubTitleCard(
                              title: " ${viewModel2.currentuser.pilotName} ",
                              bgColor: AppTheme
                                  .titlecard, // Color.fromARGB(255, 88, 203, 140),
                              fgColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }),
                        const SizedBox(height: 5),
                        viewModel.currentmatch == 0
                            ? SizedBox()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                child: RoundCard(
                                  change: () {
                                    setState(() {});
                                  },
                                  keys: [
                                    globalKeys[0],
                                    globalKeys[1],
                                    globalKeys[2],
                                    globalKeys[3]
                                  ],
                                  next: () {
                                    viewModel.nextroundupdate();
                                  },
                                  prev: () {
                                    viewModel.prevroundupdate();
                                  },
                                  title1:
                                      "${viewModel.currentmatch == 0 ? 'Pending' : viewModel.currentmatch}",
                                  title: viewModel.round == 10
                                      ? 'Final Round'
                                      : "Round : ${viewModel.round}",
                                  bgColor: AppTheme.primaryColor,
                                  fgColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        const SizedBox(height: 5),
                        RoundForm(
                          change: () {
                            setState(() {});
                          },
                          keys: [
                            globalKeys[4],
                            globalKeys[5],
                            globalKeys[6],
                            globalKeys[7],
                            globalKeys[8],
                            globalKeys[9]
                          ],
                        ),
                        // Visibility(
                        //   visible: !viewModel.saveflight &&
                        //       viewModel.currentround == viewModel.round,
                        //   child: Padding(
                        //     padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        //     child: CommonButton(
                        //       text: 'Submit Record ',
                        //       onPressed: () {
                        //         //  viewModel.   matchchange();
                        //         log("user id: ${authstoragebox.get('userId')}");
                        //         // viewModel.addtestMatch(context);

                        //         if (viewModel.round <= 10) {
                        //           log("round${viewModel.rounds.length}");
                        //           // ;
                        //           viewModel.addtestMatch(context).then(
                        //             (value) {
                        //               if (value == true) {
                        //                 viewModel.fetchroundsdata(context).then(
                        //                       (value) => viewModel.changebutton(),
                        //                     );
                        //               } else {
                        //                 DynamicToast.show("Something went wrong");
                        //               }
                        //             },
                        //           );
                        //         } else {
                        //           Fluttertoast.showToast(
                        //               msg: "This is the last round",
                        //               toastLength: Toast.LENGTH_SHORT,
                        //               gravity: ToastGravity.CENTER,
                        //               timeInSecForIosWeb: 1,
                        //               backgroundColor: Colors.red,
                        //               textColor: Colors.white,
                        //               fontSize: 16.0);
                        //         }
                        //       },
                        //       backgroundColor: AppTheme.primaryColor,
                        //       textColor: theme.colorScheme.onPrimary,
                        //       width: size.width * 0.94,
                        //       fontSize: size.width * 0.045,
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 5),

                        if (viewModel.round > 0)
                          const SizedBox(
                            height: 5,
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // create and join contest
                            // Visibility(
                            //   visible: viewModel.currentmatch == 0,
                            //   // viewModel.saveflight,
                            //   child: Expanded(
                            //     child: CommonButton(
                            //       text: 'Create contest',
                            //       onPressed: () {
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
                            //               backgroundColor:
                            //                   AppTheme.primaryColor,
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
                            //               backgroundColor:
                            //                   AppTheme.primaryColor,
                            //               textColor: Colors.white,
                            //               onPressed: () {
                            //                 viewModel
                            //                     .finishtestMatch(context)
                            //                     .then(
                            //                   (value) {
                            //                     if (value == true) {
                            //                       // viewModel.changebutton();
                            //                       // if (viewModel.updated == false) {
                            //                       //   viewModel.updatebutton();
                            //                       // }
                            //                       viewModel.resetdialer();

                            //                       viewModel
                            //                           .matchchange(0);

                            //                       viewModel
                            //                           .fetchroundsdata(
                            //                               context);

                            //                       viewModel
                            //                           .nextround(true);
                            //                       log("Save Flight");
                            //                     } else {
                            //                       DynamicToast.show(
                            //                           "Something went wrong");
                            //                     }
                            //                   },
                            //                 );

                            //                 Navigator.of(context)
                            //                     .pop(); // Close the dialog
                            //               },
                            //             ),
                            //           ],
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );

                            //         // if (viewModel.round <= 10) {
                            //         //   log("round${viewModel.rounds.length}");
                            //         //   // ;
                            //         //   viewModel.addtestMatch(context).then(
                            //         //     (value) {
                            //         //       if (value == true) {
                            //         //         viewModel
                            //         //             .fetchroundsdata(context)
                            //         //             .then((value) {
                            //         //           if (viewModel.updated == false) {
                            //         //             viewModel.updatebutton();
                            //         //           }
                            //         //           viewModel.resetdialer();

                            //         //           if (viewModel.round == 10) {
                            //         //             viewModel.matchchange(0);

                            //         //             viewModel
                            //         //                 .fetchroundsdata(context);
                            //         //           }
                            //         //           viewModel.nextround(false);
                            //         //           log("Save Flight");
                            //         //         }
                            //         //                 //  => viewModel.changebutton(),
                            //         //                 );
                            //         //       } else {
                            //         //         DynamicToast.show(
                            //         //             "Something went wrong");
                            //         //       }
                            //         //     },
                            //         //   );
                            //         // } else {
                            //         //   Fluttertoast.showToast(
                            //         //       msg: "This is the last round",
                            //         //       toastLength: Toast.LENGTH_SHORT,
                            //         //       gravity: ToastGravity.CENTER,
                            //         //       timeInSecForIosWeb: 1,
                            //         //       backgroundColor: Colors.red,
                            //         //       textColor: Colors.white,
                            //         //       fontSize: 16.0);
                            //         // }

                            //         // viewModel.changebutton();
                            //       },
                            //       height: 30,
                            //       backgroundColor: AppTheme.primaryColor,
                            //       textColor: theme.colorScheme.onPrimary,
                            //       width: size.width * 0.2,
                            //       fontSize: size.width * 0.04,
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(width: 7),
                            // Visibility(
                            //   visible: viewModel.currentmatch == 0,
                            //   child: Expanded(
                            //     child: CommonButton(
                            //       text: 'Join contest',
                            //       onPressed: () {
                            //         showDialog(
                            //           context: context,
                            //           builder: (BuildContext context) {
                            //             return AlertDialog(
                            //               title: Text(
                            //                 'Enter contest code',
                            //                 textAlign: TextAlign.center,
                            //                 style: AppFonts.headline2,
                            //               ),
                            //               content: CustomTextFormField(
                            //                 controller:
                            //                     viewModel.contestCodeController,
                            //                 hintText: '',
                            //                 validator: (value) {
                            //                   if (value == null ||
                            //                       value.isEmpty) {
                            //                     return 'Please enter your code';
                            //                   }
                            //                   return null;
                            //                 },
                            //                 onTap: () {},
                            //                 keyboardType: TextInputType.number,
                            //                 readOnly: false,
                            //                 autoValidate: true,
                            //               ),
                            //               actions: [
                            //                 Row(
                            //                   mainAxisAlignment:
                            //                       MainAxisAlignment.spaceEvenly,
                            //                   children: [
                            //                     CommonButton(
                            //                       text: 'Cancel',
                            //                       fontSize: 12,
                            //                       width: 80,
                            //                       backgroundColor:
                            //                           AppTheme.primaryColor,
                            //                       textColor: Colors.white,
                            //                       onPressed: () {
                            //                         Navigator.of(context)
                            //                             .pop(); // Close the dialog
                            //                       },
                            //                     ),
                            //                     CommonButton(
                            //                       text: 'Join',
                            //                       fontSize: 12,
                            //                       width: 80,
                            //                       backgroundColor:
                            //                           AppTheme.primaryColor,
                            //                       textColor: Colors.white,
                            //                       onPressed: () {
                            //                         DynamicToast.show(
                            //                             "Joined successfully");

                            //                         Navigator.of(context)
                            //                             .pop(); // Close the dialog
                            //                       },
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ],
                            //             );
                            //           },
                            //         );
                            //         // matchdatabox.clear();
                            //         // matchdatabox.put('match_number', 6);
                            //         // log("Update Flight");
                            //         // viewModel
                            //         //     .addtestMatch(context, update: true)
                            //         //     .then(
                            //         //   (value) {
                            //         //     if (value == true) {
                            //         //       viewModel.fetchroundsdata(context);
                            //         //       // .then(
                            //         //       //   (value) =>
                            //         //       //       // viewModel.updatebutton(),
                            //         //       // );
                            //         //     } else {
                            //         //       DynamicToast.show(
                            //         //           "Something went wrong");
                            //         //     }
                            //         //   },
                            //         // );
                            //       },
                            //       height: 30,
                            //       backgroundColor: AppTheme.primaryColor,
                            //       textColor: theme.colorScheme.onPrimary,
                            //       width: size.width * 0.2,
                            //       fontSize: size.width * 0.04,
                            //     ),
                            //   ),
                            // ),

                            // save and update flights

                            Visibility(
                              visible:
                                  viewModel.currentround == viewModel.round &&
                                      viewModel.currentmatch != 0 &&
                                      viewModel.roundcomplete == false,
                              // viewModel.saveflight,
                              child: Expanded(
                                child: ShowCaseView(
                                  fun: (val) {
                                    if (val == 'skip') {
                                      setState(() {
                                        log("setState called");
                                      });
                                    }
                                  },
                                  height: 0.26,
                                  gkey: globalKeys[10],
                                  title: "Save Round",
                                  description:
                                      "After filling all the data above you can save your currentround from here and play next round",
                                  child: CommonButton(
                                    text: 'Save match',
                                    onPressed: () {
                                      if (viewModel.round <= 10) {
                                        log("round${viewModel.rounds.length}");
                                        // ;
                                        viewModel.addtestMatch(context).then(
                                          (value) {
                                            if (value == true) {
                                              viewModel
                                                  .fetchroundsdata(context)
                                                  .then((value) {
                                                if (viewModel.updated ==
                                                    false) {
                                                  viewModel.updatebutton();
                                                }
                                                viewModel.resetdialer();
                                                log("Round ${viewModel.round}");

                                                if (viewModel.round == 10) {
                                                  viewModel.resetdialer();
                                                  viewModel.roundComplete(true);

                                                  // viewModel
                                                  //     .matchchange(0);

                                                  // viewModel
                                                  //     .fetchroundsdata(
                                                  //         context);

                                                  // viewModel.nextround(
                                                  //     true);

                                                  viewModel
                                                      .fetchroundsdata(context);
                                                }
                                                viewModel.nextround(false);
                                                log("Save Flight");
                                              }
                                                      //  => viewModel.changebutton(),
                                                      );
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      'Somthing Went Wrong',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: AppFonts.headline2,
                                                    ),
                                                    actions: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          CommonButton(
                                                            text: 'Retry',
                                                            fontSize: 12,
                                                            width: 80,
                                                            backgroundColor:
                                                                AppTheme
                                                                    .primaryColor,
                                                            textColor:
                                                                Colors.white,
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
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
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "This is the last round",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }

                                      // viewModel.changebutton();
                                    },
                                    backgroundColor: AppTheme.primaryColor,
                                    textColor: theme.colorScheme.onPrimary,
                                    width: size.width * 0.47,
                                    fontSize: size.width * 0.045,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 2),
                            Visibility(
                              visible: !viewModel.saveflight &&
                                  viewModel.currentround > 1 &&
                                  viewModel.currentround == viewModel.round &&
                                  viewModel.roundcomplete == false
                              //     ||
                              // showcasebox.get('roundScreen') != 'done'
                              ,
                              child: Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: ShowCaseView(
                                    fun: (val) {
                                      if (val == 'skip') {
                                        setState(() {
                                          log("setState called");
                                        });
                                      }
                                    },
                                    height: 0.26,
                                    gkey: globalKeys[11],
                                    title: "Finish Match",
                                    description:
                                        "Tap here to get exit from this contest or close the contest",
                                    child: CommonButton(
                                      text: 'Finish Match ',
                                      onPressed: () {
                                        //  viewModel.   matchchange();
                                        log("user id: ${authstoragebox.get('userId')}");
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                'Are you sure you want to finish the match?',
                                                textAlign: TextAlign.center,
                                                style: AppFonts.headline2,
                                              ),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    CommonButton(
                                                      text: 'No',
                                                      fontSize: 12,
                                                      width: 80,
                                                      backgroundColor:
                                                          AppTheme.primaryColor,
                                                      textColor: Colors.white,
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(); // Close the dialog
                                                      },
                                                    ),
                                                    CommonButton(
                                                      text: 'Yes',
                                                      fontSize: 12,
                                                      width: 80,
                                                      backgroundColor:
                                                          AppTheme.primaryColor,
                                                      textColor: Colors.white,
                                                      onPressed: () {
                                                        viewModel
                                                            .finishtestMatch(
                                                                context)
                                                            .then(
                                                          (value) {
                                                            if (value == true) {
                                                              // viewModel.changebutton();
                                                              // if (viewModel.updated == false) {
                                                              //   viewModel.updatebutton();
                                                              // }
                                                              // viewModel
                                                              //     .roundComplete();
                                                              viewModel
                                                                  .resetdialer();

                                                              viewModel
                                                                  .matchchange(
                                                                      0);

                                                              viewModel
                                                                  .fetchroundsdata(
                                                                      context);

                                                              viewModel
                                                                  .nextround(
                                                                      true);
                                                              log("Save Flight");
                                                            } else {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                      'Somthing Went Wrong',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: AppFonts
                                                                          .headline2,
                                                                    ),
                                                                    actions: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          CommonButton(
                                                                            text:
                                                                                'Retry',
                                                                            fontSize:
                                                                                12,
                                                                            width:
                                                                                80,
                                                                            backgroundColor:
                                                                                AppTheme.primaryColor,
                                                                            textColor:
                                                                                Colors.white,
                                                                            onPressed:
                                                                                () {
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

                                                        Navigator.of(context)
                                                            .pop(); // Close the dialog
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        // viewModel.addtestMatch(context);

                                        // else {
                                        //   Fluttertoast.showToast(
                                        //       msg: "This is the last round",
                                        //       toastLength: Toast.LENGTH_SHORT,
                                        //       gravity: ToastGravity.CENTER,
                                        //       timeInSecForIosWeb: 1,
                                        //       backgroundColor: Colors.red,
                                        //       textColor: Colors.white,
                                        //       fontSize: 16.0);
                                        // }
                                      },
                                      backgroundColor: AppTheme.primaryColor,
                                      textColor: theme.colorScheme.onPrimary,
                                      width: size.width * 0.94,
                                      fontSize: size.width * 0.045,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 2),
                            Visibility(
                              visible: viewModel.saveflight &&
                                      viewModel.updated ||
                                  viewModel.currentround != viewModel.round ||
                                  viewModel.roundcomplete == true
                              // ||
                              // showcasebox.get('roundScreen') != 'done'
                              ,
                              child: Expanded(
                                child: ShowCaseView(
                                  fun: (val) {
                                    if (val == 'skip') {
                                      setState(() {
                                        log("setState called");
                                      });
                                    }
                                  },
                                  height: 0.26,
                                  gkey: globalKeys[12],
                                  title: "Update Round",
                                  description:
                                      "Tap here to Update your round data ",
                                  child: CommonButton(
                                    text: 'Update Flight',
                                    onPressed: () {
                                      // matchdatabox.clear();
                                      // matchdatabox.put('match_number', 6);
                                      log("Update Flight");
                                      viewModel
                                          .addtestMatch(context, update: true)
                                          .then(
                                        (value) {
                                          if (value == true) {
                                            while (viewModel.round <
                                                viewModel.currentround) {
                                              viewModel.nextroundupdate();
                                            }

                                            setState(() {});

                                            viewModel.fetchroundsdata(context);
                                            // .then(
                                            //   (value) =>
                                            //       // viewModel.updatebutton(),
                                            // );
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
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        CommonButton(
                                                          text: 'Retry',
                                                          fontSize: 12,
                                                          width: 80,
                                                          backgroundColor:
                                                              AppTheme
                                                                  .primaryColor,
                                                          textColor:
                                                              Colors.white,
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
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
                                    },
                                    backgroundColor: AppTheme.primaryColor,
                                    textColor: theme.colorScheme.onPrimary,
                                    width: size.width * 0.47,
                                    fontSize: size.width * 0.045,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (viewModel.currentround > 1)
                          const SizedBox(height: 5),
                        if (viewModel.round_1.length != 0)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              // width: 730,
                              width:1000,
                              child: ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 5),
                                    decoration: const BoxDecoration(
                                      color: AppTheme.titlecard,
                                      // Color.fromARGB(255, 88, 203, 140),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: 50,
                                          child: Text(
                                            "Round",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.martianMono(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: Text(
                                            "Pilot",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.martianMono(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        // SizedBox(width: mq.width * 0.01),
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            "Time",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.martianMono(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            "Landing",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.martianMono(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            "Height",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.martianMono(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            "Penalty",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.martianMono(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        // SizedBox(width: mq.width * 0.01),
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            "Score",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.martianMono(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Container(
                                      // height: 400,
                                      child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 10,
                                        itemBuilder: (context, index) {
                                          List<Rounds> selectedRound;

                                          switch (index) {
                                            case 0:
                                              selectedRound = viewModel.round_1;
                                              break;
                                            case 1:
                                              selectedRound = viewModel.round_2;
                                              break;
                                            case 2:
                                              selectedRound = viewModel.round_3;
                                              break;
                                            case 3:
                                              selectedRound = viewModel.round_4;
                                              break;
                                            case 4:
                                              selectedRound = viewModel.round_5;
                                              break;
                                            case 5:
                                              selectedRound = viewModel.round_6;
                                              break;
                                            case 6:
                                              selectedRound = viewModel.round_7;
                                              break;
                                            case 7:
                                              selectedRound = viewModel.round_8;
                                              break;
                                            case 8:
                                              selectedRound = viewModel.round_9;
                                              break;
                                            case 9:
                                              selectedRound =
                                                  viewModel.round_10;
                                              break;
                                            default:
                                              selectedRound = [];
                                              break;
                                          }
                                          return RoundDetailCard(
                                              index: index + 1,
                                              round: selectedRound);
                                          // Container(
                                          //   color: Colors.black12,
                                          //   height: 299,
                                          //   child: Column(
                                          //     children: [
                                          //       Text(index1.toString()),
                                          //       ListView.builder(
                                          //         shrinkWrap: true,
                                          //         itemCount: ,
                                          //         itemBuilder: (context, index) {
                                          //           return
                                          //         },
                                          //       ),
                                          //     ],
                                          //   ),
                                          // );

                                          // round.testMatches[0].rounds[0]
                                          //             .roundNumber ==xx
                                          //         1
                                          //     ? Text(round
                                          //         .testMatches[0].rounds[0].landing
                                          //         .toString())
                                          //     : Text("data");

                                          // Text("data");
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        const SizedBox(height: 5),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: ShowCaseView(
                                fun: (val) {
                                  if (val == 'skip') {
                                    setState(() {
                                      log("setState called");
                                    });
                                  }
                                },
                                tooltipPosition: TooltipPosition.top,
                                height: 0.6,
                                gkey: globalKeys[13],
                                title: "History",
                                description: "Here you can see match history",
                                child: CommonButton(
                                  text: 'Match update',
                                  onPressed: () {
                                   
                                  },
                                  backgroundColor: AppTheme.primaryColor,
                                  textColor: theme.colorScheme.onPrimary,
                                  width: size.width * 0.47,
                                  fontSize: size.width * 0.03,
                                ),
                              ),
                            ),
                            const SizedBox(width: 3),
                            Expanded(
                              child: ShowCaseView(
                                fun: (val) {
                                  if (val == 'skip') {
                                    setState(() {
                                      log("setState called");
                                    });
                                  }
                                },
                                tooltipPosition: TooltipPosition.top,
                                height: 0.6,
                                gkey: globalKeys[14],
                                title: "OverAll Score",
                                description:
                                    "Tap here to get overall score of the match",
                                child: CommonButton(
                                  text: 'Overall Score',
                                  onPressed: () {
                                  
                                  },
                                  backgroundColor: AppTheme.primaryColor,
                                  textColor: theme.colorScheme.onPrimary,
                                  width: size.width * 0.47,
                                  fontSize: size.width * 0.03,
                                ),
                              ),
                            ),
                            const SizedBox(width: 3),
                            Expanded(
                              child: ShowCaseView(
                                fun: (val) {
                                  if (val == 'skip') {
                                    setState(() {
                                      log("setState called");
                                    });
                                  }
                                },
                                tooltipPosition: TooltipPosition.top,
                                height: 0.6,
                                gkey: globalKeys[15],
                                title: "Current Standing",
                                description:
                                    "Tap here to get your current standing average",
                                child: CommonButton(
                                  text: 'Stats',
                                  onPressed: () {
                                   
                                  },
                                  backgroundColor: AppTheme.primaryColor,
                                  textColor: theme.colorScheme.onPrimary,
                                  width: size.width * 0.47,
                                  fontSize: size.width * 0.03,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
                        visible: context
                                .watch<ConnectionController>()
                                .connectiontype ==
                            'Not Connected',
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Container(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        )),
                    Visibility(
                      visible: context
                              .watch<ConnectionController>()
                              .connectiontype ==
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
                                  color:
                                      const Color.fromARGB(255, 204, 53, 42)),
                              SizedBox(height: 20),
                              Material(
                                color: AppTheme.primaryColor,
                                child: Text(
                                  'No Internet Connection',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255)),
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
          ),
        ),
      ),
    );
  }
}
