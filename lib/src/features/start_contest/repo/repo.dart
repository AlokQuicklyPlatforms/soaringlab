import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:get_storage/get_storage.dart';
import 'package:soaring_lab/src/core/constants.dart';
import 'package:soaring_lab/src/services/api_services.dart';
import 'package:soaring_lab/src/services/app_initializer.dart';
import 'package:soaring_lab/src/services/hive_storage.dart';
import 'package:soaring_lab/src/widgets/dynamic_toast.dart';

class PilotCodeRepository {
  final ApiService _apiService = ApiService();
  // final GetStorage _storage = GetStorage();

  // final Dio _dio = AppInitializer().dio;
  final GetStorage _storage = AppInitializer().storage;
  var email = authstoragebox.get('email');

  // Future<Either<String, dynamic>> getPilotcodeApi(String email) async {
  //   //  Map<String, String> body = {"email": email};
  //   final response = await _apiService.getresponse(Constants.start_Contest,
  //       needToken: true, email: email);
  //   print("respone: $response");
  //   return response.fold(
  //     (error) => Left(error),
  //     (data) {
  //       DynamicToast.show(data["message"].toString());
  //       // Optionally store the token in GetStorage if the signup also returns a token

  //       return Right(data);
  //     },
  //   );
  // }

  Future<Either<String, dynamic>> getPilotcodeApi1() async {
    //  Map<String, String> body = {"email": email};
    final response = await _apiService.get(
      Constants.start_Contest + email,
      needToken: true,
    );
    print("respone: $response");
    return response.fold(
      (error) => Left(error),
      (data) {
        DynamicToast.show(data["message"].toString());
        // Optionally store the token in GetStorage if the signup also returns a token
        print('pilotCode: ${data["pilotCode"]}');
        userprofilebox.put('piloteCod', data["pilotCode"]);
        return Right(data);
      },
    );
  }

  Future<Either<String, dynamic>> verificationPilotCodeApi(
      String email, int pilotCode) async {
    Map<String, dynamic> body = {'email': email, 'pilotCode': pilotCode};
    final response = await _apiService.postBody(
      Constants.verify_pilot_code,
      body,
      needToken: true,
    );
    print('response1: $response');
    return response.fold(
      // (error) => Left(error),
      (error) {
        log('error message: $error');
        return Left(error);
      },
      (data) {
        log(data['subCode'].toString());
        log('Items: ${data['items']}');

        DynamicToast.show(data["message"].toString());
        // Optionally store the token in GetStorage if the signup also returns a token

        return Right(data);
      },
    );
  }
}
