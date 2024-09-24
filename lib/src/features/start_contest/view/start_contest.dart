import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaring_lab/src/features/start_contest/controller/startr_contest_controller.dart';
import 'package:soaring_lab/src/widgets/custom_button.dart';

class StartContest extends StatelessWidget {
  StartContest({super.key});

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final viewModel = context.watch<AuthViewModel>();
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/soaring_lab_logo.png',
                          height: size.height * 0.35,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        ReuseButton(
                            button_name: 'Get pilot code',
                            buttonaction: () {
                              if (formKey.currentState!.validate()) {
                                // viewModel.submitLoginForm(context);

                                // Navigator.push(context, MaterialPageRoute(
                                //   builder: (context) {
                                //     return PilotCode();
                                //   },
                                // ));
                                viewModel.getPilotCode(context);
                                print('On');
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
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
              )
            ],
          );
        },
      ),
    );
  }
}
