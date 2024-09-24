import 'package:flutter/material.dart';
import 'package:soaring_lab/Showcaseview.dart';

import '../../../../main.dart';
import '../../../themes/app_fonts.dart';
import 'widgets/fight_window_picker.dart';
import 'widgets/fight_time_picker.dart';
import 'widgets/flight_height_picker.dart';
import 'widgets/flight_landing_picker.dart';
import 'widgets/flight_penalty_picker.dart';
import 'widgets/flight_sec_picker.dart';

class RoundForm extends StatelessWidget {
  RoundForm({super.key, required this.keys, required this.change});

  final List<GlobalKey> keys;

  var formKey = GlobalKey<FormState>();
  final Function() change;

  @override
  Widget build(BuildContext context) {
    final font = Theme.of(context).textTheme;

    return Form(
      key: formKey,
      child: ListView(
        primary: false,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: mq.height * 0.08,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: mq.width * 0.5,
                    child: Padding(
                      padding: EdgeInsets.only(left: mq.width * 0.06),
                      child: Text(
                        "Flight Window",
                        style: AppFonts.headline3.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: mq.width * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ShowCaseView(
                          fun: (val) {
                            if (val == 'skip') {
                              change();
                            }
                          },
                          height: 0.66,
                          gkey: keys[0],
                          title: "Flight Window",
                          description: "Tap here and set the flight window",
                          child: const FlightWindowPicker(),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: mq.height * 0.09,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: mq.width * 0.5,
                    child: Padding(
                      padding: EdgeInsets.only(left: mq.width * 0.06),
                      child: Text(
                        "Flight Time",
                        style: AppFonts.headline3.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: mq.width * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ShowCaseView(
                          fun: (val) {
                            if (val == 'skip') {
                              change();
                            }
                          },
                          height: 0.55,
                          gkey: keys[1],
                          title: "Flight Time",
                          description: "Set the flight time here",
                          child: const FlightTimePicker(),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ShowCaseView(
                          fun: (val) {
                            if (val == 'skip') {
                              change();
                            }
                          },
                          height: 0.55,
                          gkey: keys[2],
                          title: "Flight Seconds",
                          description: "Set the flight seconds here",
                          child: const FlightSecPicker(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: mq.height * 0.08,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: mq.width * 0.5,
                    child: Padding(
                      padding: EdgeInsets.only(left: mq.width * 0.06),
                      child: Text(
                        "Start Height",
                        style: AppFonts.headline3.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: mq.width * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ShowCaseView(
                          fun: (val) {
                            if (val == 'skip') {
                              change();
                            }
                          },
                          height: 0.5,
                          gkey: keys[3],
                          title: "Start Height",
                          description: "Set the start height here",
                          child: const FlightHeightPicker(),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: mq.height * 0.06,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: mq.width * 0.5,
                    child: Padding(
                      padding: EdgeInsets.only(left: mq.width * 0.06),
                      child: Text(
                        "Landing",
                        style: AppFonts.headline3.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: mq.width * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ShowCaseView(
                          fun: (val) {
                            if (val == 'skip') {
                              change();
                            }
                          },
                          height: 0.42,
                          gkey: keys[4],
                          title: "Landing",
                          description: "Set the landing here",
                          child: const FlightLandingPicker(),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: mq.height * 0.08,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: mq.width * 0.5,
                    child: Padding(
                      padding: EdgeInsets.only(left: mq.width * 0.06),
                      child: Text(
                        "Penalty",
                        style: AppFonts.headline3.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: mq.width * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ShowCaseView(
                          fun: (val) {
                            if (val == 'skip') {
                              change();
                            }
                          },
                          height: 0.35,
                          gkey: keys[5],
                          title: "Penalty",
                          description: "Set the penalty here",
                          child: const FlightPenaltyPicker(),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
