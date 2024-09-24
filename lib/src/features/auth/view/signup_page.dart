import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaring_lab/src/features/auth/view/login_page.dart';
import 'package:soaring_lab/src/widgets/custom_button.dart';
import 'package:soaring_lab/src/widgets/custom_text_form_field.dart';
import '../../../../main.dart';
import '../../../core/constants.dart';
import '../controller/auth_view_model.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var formKey = GlobalKey<FormState>();
  bool isAd = false;
  @override
  Widget build(BuildContext context) {
    // GlobalKey<FormState> formKey = GlobalKey<FormState>();
    // final viewModel = context.watch<AuthViewModel>();
    final theme = Theme.of(context);
    final font = Theme.of(context).textTheme;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Consumer<AuthViewModel>(
        builder: (context, viewModel, _) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: mq.height * 0.03),
                      Image.asset(
                        applogo,
                        height: mq.height * 0.18,
                      ),
                      Text(
                        'Sign up',
                        style: font.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 40),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Name',
                          style: font.titleMedium,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                          autoValidate: true,
                          controller: viewModel.nameController,
                          hintText: '',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          onTap: () {},
                          keyboardType: TextInputType.name,
                          readOnly: false),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email',
                          style: font.titleMedium,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                          controller: viewModel.emailController,
                          hintText: '',
                          autoValidate: true,
                          validator: (value) {
                            // if (value == null || value.isEmpty) {
                            //   return 'Please enter your email';
                            // }
                            // return null;
                            if (value!.isEmpty) {
                              return 'Please enter email address';
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return 'Enter valid email address';
                            } else {
                              return null;
                            }
                          },
                          onTap: () {},
                          keyboardType: TextInputType.emailAddress,
                          readOnly: false),
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
                              return 'password should be contain atleast 8 char..';
                            }
                            return null;
                          },
                          onTap: () {},
                          keyboardType: TextInputType.text,
                          readOnly: false),

                      // check box
                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: isAd,
                            onChanged: (bool? value) {
                              setState(() {
                                isAd = value!;
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                                'By clicking here, you agree to receive exclusive promotioal offer from soaring lab'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      ReuseButton(
                          button_name: 'Sign Up',
                          buttonaction: () {
                            if (formKey.currentState!.validate()) {
                              viewModel.submitSignUpForm(context);
                            }
                          }),
                      const SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Montserrat Light",
                                  fontSize: 12,
                                  color: Color(0xff747474)),
                            ),
                            TextSpan(
                                text: 'Sign in',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat Light",
                                  fontSize: 12,
                                  color: Color(0xff1F4CE0),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('on Click');
                                    viewModel.clearFields();
                                    // Navigator.of(context)
                                    //     .pushReplacementNamed('/login');
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return const LoginPage();
                                      },
                                    ));
                                  }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
