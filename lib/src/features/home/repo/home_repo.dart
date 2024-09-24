import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:get_storage/get_storage.dart';
import 'package:soaring_lab/src/core/constants.dart';
import 'package:soaring_lab/src/services/api_services.dart';
import 'package:soaring_lab/src/services/app_initializer.dart';
import 'package:soaring_lab/src/services/hive_storage.dart';


class HomeRepository {
  final ApiService _apiService = ApiService();
  // final GetStorage _storage = GetStorage();

  // final Dio _dio = AppInitializer().dio;
  final GetStorage _storage = AppInitializer().storage;
  var email = authstoragebox.get('email');

  Future<Either<String, dynamic>> getCalculatedScore(int currmatch) async {
    var userid = authstoragebox.get('userId');
    print("this is user id " + userid);
    //  Map<String, String> body = {"email": email};
    final response = await _apiService.get(
      "${Constants.match_score_calculation + userid}&match_number=$currmatch",
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
        userprofilebox.put('piloteCod', data["pilotCode"]);
        return Right(data);
      },
    );
  }

  //Int userId = authstoragebox.get('user_id');
  Future<Either<String, dynamic>> addTestMatchApi(
      String date,
      int currentmatch,
      String userId,
      int roundNo,
      String flightWindow,
      String flightTime,
      //int flighttimeSec,
      int startHeight,
      int landing,
      int penalty,
      bool update) async {
    var body = {
      "user_id": userId,
      "test_matches": [
        {
          "match_number":
          //  update == false
          //     ? roundNo == 1
          //         ? 0
          //         : currentmatch
          //     : 
              currentmatch,
          "rounds": [
            {
              "round_number": roundNo,
              "flight_window": flightWindow,
              "flight_time": flightTime,
              "start_height": startHeight,
              "landing": landing,
              "penalty": penalty,
              "date": date,
            }
          ]
        }
      ]
    };
  
    final response = await _apiService.postBody(
      update == false ? Constants.add_test_match : Constants.updatetestMatch,
      body,
      needToken: true,
    );

    return response.fold(
      // (error) => Left(error),
      (error) {
        log('error message: $error');
        return Left(error);
      },
      (data) {
        // matchdatabox.put('match_number',
        //     data['data']['test_matches'][0]['match_number'].toString());
        log("success hai bhai${data['items']['data']['test_matches'][0]['match_number']}");
        //log('Items: ${data['items']}');

        // Optionally store the token in GetStorage if the signup also returns a token

        return Right(data);
      },
    );
  }

  // finish test  match
  Future<Either<String, dynamic>> finishtestMatchApi(
    int currentmatch,
    String userId,
    int roundNo,
    String date
  ) async {
    var body = {
      "user_id": userId,
      "match_number":currentmatch,
      "round_number": roundNo,
        "date": date,
    };
    log("add test match body $body");
    final response = await _apiService.postBody(
      Constants.finishmatch,
      body,
      needToken: true,
    );
    log('response1: $response');
    return response.fold(
      // (error) => Left(error),
      (error) {
        log('error message: $error');
        return Left(error);
      },
      (data) {
        // matchdatabox.put('match_number',
        //     data['data']['test_matches'][0]['match_number'].toString());
        log("success hai bhai" 
      
           );
        //log('Items: ${data['items']}');

        // Optionally store the token in GetStorage if the signup also returns a token

        return Right(data);
      },
    );
  }

  // create and update match id 
   Future<Either<String, dynamic>> createandjoinmatchid(
    
    String userId,
    int matchno,
  
  ) async {
    var body = {
      "user_id": userId,
      "match_number":matchno,
   
    };
    log("add test match body $body");
    final response = await _apiService.postBody(
      Constants.createandjoinmatch,
      body,
      needToken: true,
    );
    log('response1: $response');
    return response.fold(
      // (error) => Left(error),
      (error) {
        log('error message: $error');
        return Left(error);
      },
      (data) {


        log("success hai bhai" 
      
           );
        //log('Items: ${data['items']}');

        // Optionally store the token in GetStorage if the signup also returns a token

        return Right(data);
      },
    );
  }

}
