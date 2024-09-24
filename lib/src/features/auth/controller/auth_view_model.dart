import 'dart:developer';

// import '../../repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaring_lab/src/features/auth/view/login_page.dart';
import 'package:soaring_lab/src/features/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:soaring_lab/src/features/home/controller/home_view_model.dart';
import 'package:soaring_lab/src/features/profile/controller/profile_view_model.dart';
import 'package:soaring_lab/src/services/hive_storage.dart';
import 'package:soaring_lab/src/widgets/dynamic_toast.dart';

import '../repo/auth_repo.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthenticationRepository _authRepository = AuthenticationRepository();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  // TextEditingController pilotCodeController = TextEditingController();

  String nameError = "Please enter your name";
  String emailError = "Please enter vaid email";
  String passwordError = "Invalid password";
  String _name = '';
  String _email = '';
  String _password = '';

  String get name => _name;
  String get email => _email;
  String get password => _password;

  bool isloading = false;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  bool validateLoginForm() {
    return emailController.text.isNotEmpty && passController.text.isNotEmpty;
  }

  bool validateSignUpForm() {
    return emailController.text.isNotEmpty &&
        passController.text.isNotEmpty &&
        nameController.text.isNotEmpty;
  }

  // app status
  Map<String, dynamic> appstatusdata = {
    'items': {'status': 'empty','message':''},
  };

  Future<bool> submitLoginForm(BuildContext context) async {
    if (validateLoginForm()) {
      if (isloading) {
        return false;
      }
      try {
        isloading = true;
        notifyListeners();
        final result = await _authRepository.login(
            emailController.text, passController.text);

        return result.fold(
          (error) {
            print('API Error: $error');
            DynamicToast.show('Error: Somthing went wrong');
            return false;
          },
          (data) {
            log("Datas :$data");
            if (data["subCode"] == 200) {
              context.read<ProfileViewModel>().getProfile(context).then(
                (value) {
                  context.read<HomeViewModel>().fetchroundsdata(context).then(
                    (value) {
                      authstoragebox.put('islogin', true);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BottomNavBar(),
                          ),
                          (route) => false);

                      clearFields();
                      isloading = false;
                      notifyListeners();
                    },
                  );
                },
              );
              return true;
            } else {
              DynamicToast.show(data["message"].toString());
              return false;
            }
          },
        );
      } catch (e) {
        DynamicToast.show('An error occurred: $e');
        return false;
      } finally {
        isloading = false;
        notifyListeners();
      }
    } else {
      return false;
    }
  }

  //
  Future<void> getAppstatus(BuildContext context) async {
    final result = await _authRepository.appstatus();

    result.fold((error) {
      // Handle error
      print('profile Error: $error');
    }, (data) {
      log("message" + data.toString());
      if (data['subCode'] == 200) {
        appstatusdata = data;
      } else {
        appstatusdata = {
    'items': {'status': 'empty','message':''},
  };
      }

      notifyListeners();
    });
  }

  // Call the login method from the repository

  // Handle the result accordingly
  //     result.fold(
  //       (error) {
  //         // Handle login error
  //         print('Login Error: $error');
  //         isloading = false;
  //         notifyListeners();
  //       },
  //       (data) {
  //         log("this is login data $data");
  //         if (data["subCode"] == 200) {
  //           context.read<ProfileViewModel>().getProfile(context).then(
  //             (value) {
  //               context.read<HomeViewModel>().fetchroundsdata(context).then(
  //                 (value) {
  //                   authstoragebox.put('islogin', true);
  //                   Navigator.pushAndRemoveUntil(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) => const BottomNavBar(),
  //                       ),
  //                       (route) => false);

  //                   clearFields();
  //                   isloading = false;
  //                   notifyListeners();
  //                 },
  //               );
  //             },
  //           );
  //         } else {
  //           isloading = false;
  //           notifyListeners();
  //         }

  //         // return data;

  //         // Navigate to home page or perform other actions
  //       },
  //     );
  //     notifyListeners();
  //   } else {
  //     // print("validate");
  //   }
  // }
  // Future<void> login(String email, String password) async {
  //   final result = await _authRepository.login(email, password);
  //   result.fold(
  //     (error) {
  //       // Handle error
  //       print('Login Error: $error');
  //     },
  //     (data) {
  //       // Handle successful login
  //       print('Login Success: $data');
  //       // Update your state with the data
  //     },
  //   );
  //   notifyListeners();
  // }

  Future<void> submitSignUpForm(BuildContext context) async {
    if (validateSignUpForm()) {
      isloading = true;
      notifyListeners();
      final result = await _authRepository.signup(
          nameController.text, emailController.text, passController.text);
      result.fold(
        (error) {
          // Handle error
          print('Signup Error: $error');
          isloading = false;
          notifyListeners();
        },
        (data) {
          print('Signup Success: $data');
          if (data["subCode"] == 200) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ));
          }
          isloading = false;
          notifyListeners();

          clearFields();
          // Update your state with the data
        },
      );
      notifyListeners();
    }
  }

  void clearFields() {
    nameController.clear();
    emailController.clear();
    passController.clear();
    _name = '';
    _email = '';
    _password = '';
    nameError = "Please enter your name";
    emailError = "Please enter valid email";
    passwordError = "Invalid password";
    notifyListeners();
  }

  // app status
}
