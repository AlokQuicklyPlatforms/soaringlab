import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:soaring_lab/src/core/constants.dart';
import 'package:soaring_lab/src/services/api_services.dart';
import 'package:soaring_lab/src/services/hive_storage.dart';


class CurrentstadingRepo {
  final ApiService _apiService = ApiService();
  Future<Either<String, dynamic>> getCalculatedScore() async {
    log("2");
    var matcho = matchdatabox.get('match_number') ?? 0;
    log("this is match id $matcho");
    //  Map<String, String> body = {"email": email};
    final response = await _apiService.get(
      Constants.getcurrentstading + matcho.toString(),
      needToken: true,
    );
    log("respone: $response");
    return response.fold(
      (error) {
        log("this is error: $error");
        return Left(error);
      },
      (data) {
        // DynamicToast.show(data["message"].toString());
        // Optionally store the token in GetStorage if the signup also returns a token
        print('pilotCode: ${data["pilotCode"]}');

        return Right(data);
      },
    );
  }
}
