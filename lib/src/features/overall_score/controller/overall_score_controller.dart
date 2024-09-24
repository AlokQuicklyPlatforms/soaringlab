import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:soaring_lab/src/core/constants.dart';
import 'package:soaring_lab/src/services/api_services.dart';
import 'package:soaring_lab/src/services/hive_storage.dart';


class OverallScoreViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final ApiService _apiService = ApiService();
  List<Pilot> pilotsdata = [];
  // fetch overall score
  Future<void> fetchOverAllScore() async {
    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    final result = await getOverAllScore();
    result.fold(
      (error) {
        // Handle error
      },
      (data) {
        pilotsdata.clear();
        // Handle successful login
        log('calculeted data  Success: $data');
        var matcho = matchdatabox.get('match_number') ?? 0;

        data['items'].forEach((item) {
          item['test_matches'].forEach((match) {
            if (match['match_number'] == matcho) {
              match['rounds'].forEach((round) {
                String pilotName = round['pilotName'];
                double score = round['score'].toDouble();

                Pilot? existingPilot = pilotsdata.firstWhere(
                    (pilot) => pilot.name == pilotName,
                    orElse: () =>
                        Pilot(name: '', roundScores: [], finalScore: 0.0));

                if (existingPilot.name.isEmpty) {
                  pilotsdata.add(Pilot.fromRounds(pilotName, [score]));
                } else {
                  existingPilot.roundScores.add(score);
                  existingPilot.finalScore += score;
                }
              });
            }
          });
        });

        for (var pilot in pilotsdata) {
          log('Pilot: ${pilot.name}, Round Scores: ${pilot.roundScores}, Final Score: ${pilot.finalScore}');
        }

        // Update your state with the data
      },
    );

    _isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  // get calculated score
  Future<Either<String, dynamic>> getOverAllScore() async {
    var userid = authstoragebox.get('userId');
    print("this is user id " + userid);
    //  Map<String, String> body = {"email": email};
    final response = await _apiService.get(
    "${Constants.getcalculatedmatchhistory}?match_number=${matchdatabox.get('match_number')}",
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
}

class Pilot {
  String name;
  List<double> roundScores;
  double finalScore;

  Pilot({
    required this.name,
    required this.roundScores,
    required this.finalScore,
  });

  factory Pilot.fromRounds(String name, List<double> roundScores) {
    double finalScore = roundScores.reduce((a, b) => a + b);
    return Pilot(name: name, roundScores: roundScores, finalScore: finalScore);
  }
}
