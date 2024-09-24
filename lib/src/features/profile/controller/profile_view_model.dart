import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaring_lab/src/features/home/controller/home_view_model.dart';
import 'package:soaring_lab/src/features/profile/model/user_model.dart';
import 'package:soaring_lab/src/features/profile/repo/profile_repo.dart';
import 'package:soaring_lab/src/widgets/dynamic_toast.dart';

import '../../../services/hive_storage.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileRepo _profileRepo = ProfileRepo();
  bool isLoading = false;

// current user
  UserData currentuser = UserData(
      match_number: 0,
      round_number: 1,
      id: '',
      pilotName: '',
      email: '',
      password: '',
      pilotCode: 0,
      V: 0);
  // UserData get currentuser => _currentuser!;

  // get user profile
  Future<void> getProfile(BuildContext context) async {
    final result = await _profileRepo.getprofile();

    result.fold((error) {
      // Handle error
      print('profile Error: $error');
    }, (data) {
      UserModel userModel = UserModel.fromJson(data);
      if (userModel.subCode == 200) {
        log("match number from get profile ${userModel.items.match_number}");
        matchdatabox.put(
            'round_number',
            userModel.items.round_number == 0
                ? 1
                : userModel.items.round_number + 1);
        matchdatabox.put(
            'match_number',
            userModel.items.match_number == 0
                ? matchdatabox.get('match_number')
                : userModel.items.match_number);
        context.read<HomeViewModel>().setcurrentdata(
            userModel.items.round_number == 10
                ? 0
                : userModel.items.match_number,
            userModel.items.round_number == 0
                ? 1
                : userModel.items.round_number == 10
                    ? 1
                    : userModel.items.round_number + 1);

        // log("round????" + currentuser.round_number.toString());
        // DynamicToast.show("get profile successfully");

        currentuser = userModel.items;

        notifyListeners();
      }
    });
  }

  Future<bool> deleteaccount(BuildContext context) async {
    if (isLoading) {
      return false;
    }
    try {
      isLoading = true;
      notifyListeners();
      final result = await _profileRepo.deleteAccount();

      return result.fold(
        (error) {
          print('API Error: $error');
          DynamicToast.show('Error: Somthing went wrong');
          return false;
        },
        (data) {
          log("Datas :$data");
          if (data["subCode"] == 200) {
            DynamicToast.show(data["message"].toString());
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
      isLoading = false;
      notifyListeners();
    }
  }
}
