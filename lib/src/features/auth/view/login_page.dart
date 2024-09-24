import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaring_lab/Showcaseview.dart';
import 'package:soaring_lab/src/features/auth/view/signup_page.dart';
import 'package:soaring_lab/src/themes/app_theme.dart';
import 'package:soaring_lab/src/widgets/custom_button.dart';
import 'package:soaring_lab/src/widgets/custom_text_form_field.dart';
import '../../../../main.dart';
import '../../../core/constants.dart';
import '../controller/auth_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey one = GlobalKey();
  final GlobalKey two = GlobalKey();

  @override
  void initState() {
    // if( showcasebox.get('loginScreen')=='done'){
    //    WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ShowCaseWidget.of(context).startShowCase([one, two]);
    //   showcasebox.put('loginScreen', 'done');
    // });
    // }

    // TODO: implement initState
    super.initState();
  }

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // final viewModel = context.watch<AuthViewModel>();
    final theme = Theme.of(context);
    final font = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Consumer<AuthViewModel>(
        builder: (context, viewModel, _) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Image.asset(
                            applogo,
                            height: mq.height * 0.18,
                          ),
                          Text(
                            'Login',
                            style: font.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 40),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Email',
                              style: font.titleMedium,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // TextFormField(
                          //   controller: viewModel.emailController,
                          //   decoration: const InputDecoration(
                          //     labelText: 'Email',
                          //     border: OutlineInputBorder(),
                          //   ),
                          //   keyboardType: TextInputType.emailAddress,
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'Please enter your email';
                          //     }
                          //     return null;
                          //   },
                          //   onChanged: (value) {
                          //     viewModel.setEmail(value);
                          //   },
                          // ),

                          CustomTextFormField(
                            controller: viewModel.emailController,
                            hintText: '',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            onTap: () {},
                            keyboardType: TextInputType.emailAddress,
                            readOnly: false,
                            autoValidate: true,
                          ),
                          // getEmailField(),
                          const SizedBox(height: 15),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Password',
                              style: font.titleMedium,
                            ),
                          ),
                          const SizedBox(height: 8),

                          CustomTextFormField(
                              controller: viewModel.passController,
                              hintText: '',
                              autoValidate: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                } else if (value.length < 8) {
                                  return 'password should be contain atleast 8 characters';
                                }
                                return null;
                              },
                              onTap: () {},
                              keyboardType: TextInputType.text,
                              readOnly: false),

                          const SizedBox(height: 20),

                          ShowCaseView(
                            height: 200,
                            gkey: one,
                            title: "Login",
                            description: "click here to login",
                            child: ReuseButton(
                                button_name: 'Login',
                                buttonaction: () {
                                  if (formKey.currentState!.validate()) {
                                    viewModel.submitLoginForm(context).then(
                                          (value) {
                                            
                                          },
                                        );
                                  }
                                }),
                          ),

                          const SizedBox(height: 15),
                          // TextButton(
                          //   onPressed: () {
                          //     viewModel.clearFields();
                          //     Navigator.of(context).pushReplacementNamed('/signup');
                          //   },
                          //   child: const Text(
                          //     "Don't have an account? Sign Up",
                          //     style: TextStyle(
                          //       color: Colors.blue,
                          //     ),
                          //   ),
                          // ),

                          ShowCaseView(
                            height: 200,
                            gkey: two,
                            title: "Signup",
                            description: "click here to sign up screen",
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: "Don't have an account? ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Montserrat Light",
                                        fontSize: 12,
                                        color: Color(0xff747474)),
                                  ),
                                  TextSpan(
                                      text: 'Sign Up',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Montserrat Light",
                                        fontSize: 12,
                                        color: Color(0xff1F4CE0),
                                        // color: Color.fromARGB(255, 21, 96, 130),
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          print('on Click');
                                          viewModel.clearFields();
                                          // Navigator.of(context)
                                          //     .pushReplacementNamed('/signup');
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return const SignupPage();
                                            },
                                          ));
                                        }),
                                ],
                              ),
                            ),
                          ),

                          // TextButton(
                          //   onPressed: () {
                          //     // viewModel.clearFields();
                          //     AppInitializer()
                          //         .storage
                          //         .write('token', "DemoToken");
                          //     // Navigator.of(context).pushNamedAndRemoveUntil(
                          //     //   '/bottom-bar',
                          //     //   (route) => false,
                          //     // );
                          //     Navigator.pushAndRemoveUntil(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) => BottomNavBar(),
                          //         ),
                          //         (route) => false);
                          //   },
                          //   child: const Text(
                          //     "Demo Login",
                          //     style: TextStyle(
                          //       color: Colors.blue,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
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
              ),
              //  Visibility(
              //             visible: viewModel.connectiontype == 'Offline',
              //             child: BackdropFilter(
              //               filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              //               child: Container(
              //                 color: Colors.black.withOpacity(0.5),
              //               ),
              //             )),
              //         Visibility(
              //           visible: viewModel.connectiontype == 'Offline',
              //           child: Center(
              //             child: Container(
              //               margin: EdgeInsets.all(10),
              //               padding: EdgeInsets.all(10),
              //               height: mq.height * 0.25,
              //               // width: double.infinity,
              //               decoration: BoxDecoration(
              //                   color: AppTheme.primaryColor,
              //                   borderRadius: BorderRadius.circular(25)),
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: <Widget>[
              //                   Icon(CupertinoIcons.wifi_slash,
              //                       size: 80,
              //                       color:
              //                           const Color.fromARGB(255, 204, 53, 42)),
              //                   SizedBox(height: 20),
              //                   Material(
              //                     color: AppTheme.primaryColor,
              //                     child: Text(
              //                       'No Internet Connection',
              //                       style: TextStyle(
              //                           fontSize: 24,
              //                           color: const Color.fromARGB(
              //                               255, 255, 255, 255)),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
            ],
          );
        },
      ),
    );
  }
}
