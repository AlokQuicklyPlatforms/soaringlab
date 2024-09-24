import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:soaring_lab/src/core/constants.dart';
import 'package:soaring_lab/src/features/home/model/CalculatedScore.dart';
import 'package:soaring_lab/src/services/api_services.dart';
import 'package:soaring_lab/src/services/hive_storage.dart';

class HistoryViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Match> matches = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Items> calculatedscore = [];

  void addMatch(Match match) {
    matches.add(match);
    notifyListeners();
  }

  void updateMatch(int index, Match match) {
    matches[index] = match;
    notifyListeners();
  }

  void removeMatch(int index) {
    matches.removeAt(index);
    notifyListeners();
  }

  // round
  List<Rounds> round_1 = [];
  List<Rounds> round_2 = [];
  List<Rounds> round_3 = [];
  List<Rounds> round_4 = [];
  List<Rounds> round_5 = [];
  List<Rounds> round_6 = [];
  List<Rounds> round_7 = [];
  List<Rounds> round_8 = [];
  List<Rounds> round_9 = [];
  List<Rounds> round_10 = [];

  Future<void> fetchHistory() async {
    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    final result = await getHistoryScore();
    result.fold(
      (error) {
        // Handle error
      },
      (data) {
        // Handle successful login
        print('calculeted data  Success: $data');
        CalculatedScore score = CalculatedScore.fromJson(data);
        if (score.subCode == 200) {
          print(score.message);
          calculatedscore = score.items;
          log(calculatedscore.toString());
          Dataprocessing(calculatedscore);
        }
      },
    );

    //process data

    _isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  // process data
  void Dataprocessing(List<Items> calculatedscore) {
    int currentmatch = matchdatabox.get('match_number');

    // Filter elements where testMatches match currentmatch
    List<Items> filteredElements = calculatedscore
        .where((element) =>
            element.testMatches.isNotEmpty &&
            element.testMatches[0].matchNumber == currentmatch)
        .toList();

    clearRounds();
    // Process each filtered element
    for (var element in filteredElements) {
      for (var round in element.testMatches[0].rounds) {
        addRound(round);
      }
    }

    // Notify listeners after processing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Notify listeners or update UI here
      // Example using notifyListeners if this is part of a ChangeNotifier
      notifyListeners();
    });
  }

  // add round
  void addRound(Rounds round) {
    if (round.roundNumber == 1) {
      round_1.add(round);
    } else if (round.roundNumber == 2) {
      round_2.add(round);
    } else if (round.roundNumber == 3) {
      round_3.add(round);
    } else if (round.roundNumber == 4) {
      round_4.add(round);
    } else if (round.roundNumber == 5) {
      round_5.add(round);
    } else if (round.roundNumber == 6) {
      round_6.add(round);
    } else if (round.roundNumber == 7) {
      round_7.add(round);
    } else if (round.roundNumber == 8) {
      round_8.add(round);
    } else if (round.roundNumber == 9) {
      round_9.add(round);
    } else if (round.roundNumber == 10) {
      round_10.add(round);
    } else {
      print('Invalid round number');
    }
  }

  // clear rounds
  void clearRounds() {
    round_1.clear();
    round_2.clear();
    round_3.clear();
    round_4.clear();
    round_5.clear();
    round_6.clear();
    round_7.clear();
    round_8.clear();
    round_9.clear();
    round_10.clear();
  }

  // fetch history
  Future<Either<String, dynamic>> getHistoryScore() async {
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

class Match {
  final String title;
  final List<Round> rounds;

  Match({required this.title, required this.rounds});
}

class Round {
  final String name;
  final String round;
  final String date;
  final String status;

  Round(
      {required this.name,
      required this.round,
      required this.date,
      required this.status});
}
