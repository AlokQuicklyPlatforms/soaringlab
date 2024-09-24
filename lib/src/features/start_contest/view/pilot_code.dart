import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaring_lab/src/features/start_contest/controller/startr_contest_controller.dart';
import 'package:soaring_lab/src/widgets/custom_button.dart';
import 'package:soaring_lab/src/widgets/custom_text_form_field.dart';
import '../../../../main.dart';
import '../../../core/constants.dart';

class PilotCode extends StatelessWidget {
  const PilotCode({super.key});

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final viewModel = context.watch<AuthViewModel>();
    final theme = Theme.of(context);
    final font = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false,
      body: Consumer<StartrContestController>(
        builder: (context, viewModel, _) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: mq.height * 0.1),

                        Image.asset(
                          applogo,
                          height: mq.height * 0.18,
                        ),
                        SizedBox(height: mq.height * 0.1),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Pilot Code',
                            style: font.titleMedium,
                          ),
                        ),
                        const SizedBox(height: 8),

                        CustomTextFormField(
                          controller: viewModel.pilotCodeController,
                          hintText: '',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your code';
                            }
                            return null;
                          },
                          onTap: () {},
                          keyboardType: TextInputType.number,
                          readOnly: false,
                          autoValidate: true,
                        ),
                        // // getEmailField(),
                        const SizedBox(height: 15),

                        ReuseButton(
                            button_name: 'Submit',
                            buttonaction: () {
                              if (_formKey.currentState!.validate()) {
                                // viewModel.submitLoginForm(context);
                                // Navigator.pushAndRemoveUntil(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => BottomNavBar(),
                                //     ),
                                //     (route) => false);
                                viewModel.verifyPilotCode(context);
                              }
                            }),

                        const SizedBox(height: 15),
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
    // <uses-permission android:name="android.permission.INTERNET"/>
    // <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
