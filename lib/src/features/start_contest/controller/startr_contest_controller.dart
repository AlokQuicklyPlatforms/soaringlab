import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaring_lab/src/features/auth/model/login_model.dart';
import 'package:soaring_lab/src/features/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:soaring_lab/src/features/start_contest/repo/repo.dart';
import 'package:soaring_lab/src/features/start_contest/view/pilot_code.dart';
import 'package:soaring_lab/src/services/hive_storage.dart';
import 'package:soaring_lab/src/widgets/dynamic_toast.dart';

import '../../home/controller/home_view_model.dart';
import '../../profile/controller/profile_view_model.dart';

class StartrContestController extends ChangeNotifier {
  final PilotCodeRepository _pilotecode = PilotCodeRepository();
  TextEditingController contestCodeController = TextEditingController();

  final LoginModel _userModel = LoginModel();
  TextEditingController pilotCodeController = TextEditingController();
  bool isloading = false;
  bool visiblebutton = true;
  void changebutton() {
    visiblebutton = !visiblebutton;
    notifyListeners();
  }

//  bool isLoading = false;

  // Future<void> submitLoginForm(BuildContext context) async {
  //   if (validateLoginForm()) {
  //     isloading = true;
  //     notifyListeners();
  //     // Call the login method from the repository
  //     final result = await _authRepository.login(
  //         emailController.text, passController.text);

  //     // Handle the result accordingly
  //     result.fold(
  //       (error) {
  //         // Handle login error
  //         print('Login Error: $error');
  //         isloading = false;
  //         notifyListeners();
  //       },
  //       (data) {
  //         log("this is login data " + data.toString());
  //         clearFields();
  //         if (data["subCode"] == 200) {
  //           context.read<ProfileViewModel>().getProfile(context);
  //           Navigator.pushAndRemoveUntil(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => StartContest(),
  //               ),
  //               (route) => false);
  //         }

  //         isloading = false;
  //         notifyListeners();

  //         // return data;

  //         // Navigate to home page or perform other actions
  //       },
  //     );
  //     notifyListeners();
  //   } else {
  //     // print("validate");
  //   }
  //   isloading = false;
  //   notifyListeners();
  // }
  String email = authstoragebox.get('email');
//  final Int _pilotcode = authstoragebox.get('piloteCod');
  Future<void> getPilotCode(BuildContext context) async {
    // Retrieve the email from storage
    // final String? email = authstoragebox.get('email');

    // Check if the email is not null
    // if (email == null) {
    //   // Handle the case where the email is null
    //   print('Error: Email is not stored');
    //   // You can show a dialog, snackbar, or other UI elements to inform the user
    //   return;
    // }

    // If email is not null, proceed with the API call
    // final result = await _pilotecode.getPilotcodeApi(email);
    isloading = true;
    notifyListeners();
    final result = await _pilotecode.getPilotcodeApi1();

    // Handling result
    result.fold(
      (error) {
        // Handle login error
        print('Login Error: $error');
        isloading = false;
        notifyListeners();
      },
      (data) {
        // Log data

        if (data["subCode"] == 200) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const PilotCode()),
            (route) => false,
          );
        }
        print('result: $result');
        // DynamicToast.show(data["message"].toString());

        isloading = false;
        notifyListeners();
      },
    );
  }

  Future<void> verifyPilotCode(BuildContext context) async {
    int pilotCode = int.parse(pilotCodeController.text);
    print('Stored integer value: $pilotCode');
    isloading = true;
    notifyListeners();
    final result = await _pilotecode.verificationPilotCodeApi(
        email, pilotCode); // No need to cast to Int

    result.fold(
      (error) {
        // Handle login error
        print('Login Error: $error');
        isloading = false;
        notifyListeners();
      },
      (data) {
        log('pilotCodeController.text: ${pilotCodeController.text}');
        log('email: $email');
        // Log data
        if (data["subCode"] == 200) {
          print('result: $result');
          // DynamicToast.show(data["message"].toString());

          log('Verification Items: ${data["items"].toString()}');
          isloading = false;
          notifyListeners();
          authstoragebox.put('islogin', true);
          context.read<ProfileViewModel>().getProfile(context).then(
            (value) {
              log("value.toString()");
              context.read<HomeViewModel>().fetchroundsdata(context).then(
                (value) {
                  pilotCodeController.clear();
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => BottomNavBar(),
                  //   ),
                  //   (route) => false,
                  // );
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavBar(),
                    ),
                    (route) => false,
                  );
                },
              );
              // context.read<HomeViewModel>().matchchange(1);
              // matchdatabox.put('round_number', value!.round_number);
              // matchdatabox.put('match_number', value.match_number);
            },
          );
        } else if (data["subCode"] == 400) {
          log('400code');
          DynamicToast.show(data["message"].toString());
          isloading = false;
          notifyListeners();
        }
        isloading = false;
        notifyListeners();
      },
    );
  }
}
