import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:soaring_lab/src/features/current_standing/repo/currentstading_repo.dart';

import '../model/currentstandingmodel.dart';

class CurrentStandingViewModel extends ChangeNotifier {
  CurrentstadingRepo currentstadingrepo = CurrentstadingRepo();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<AverageData> matches = [];

  void addMatch(AverageData match) {
    matches.add(match);
    notifyListeners();
  }

  void updateMatch(int index, AverageData match) {
    matches[index] = match;
    notifyListeners();
  }

  void removeMatch(int index) {
    matches.removeAt(index);
    notifyListeners();
  }

  List<AverageData> parseData(Map<String, dynamic> data) {
    List<AverageData> averageDataList = [];

    data.forEach((title, records) {
      List<Pilots> pilots = [];
      for (var i = 0; i < records.length; i++) {
        final record = records[i];
        pilots.add(Pilots(
          rank: i + 1, // Assuming rank is the index + 1
          name: record["pilotName"],
          average: record["avg"].toString(),
        ));
      }
      pilots.sort(
          (a, b) => double.parse(a.average).compareTo(double.parse(b.average)));

      // Update the rank after sorting
      for (var i = 0; i < pilots.length; i++) {
        pilots[i] = Pilots(
          rank: i + 1,
          name: pilots[i].name,
          average: pilots[i].average,
        );
      }

      averageDataList.add(AverageData(title: title, pilots: pilots));
    });

    // averageDataList.add(AverageData(title: title, pilots: pilots));

    return averageDataList;
  }

  Future<void> fetchCurrentStanding() async {
    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
    log("1");

    final result = await currentstadingrepo.getCalculatedScore();
    result.fold(
      (error) {
        // Handle error
        log('current stading Error: $error');
      },
      (data) {
        // Handle successful login
        log('current stading get Success: $data');
        matches = parseData(data['items']);
        log("avg dtaa ?$matches");

        // Update your state with the data
      },
    );

    // await Future.delayed(const Duration(seconds: 1));
    // matches = matches = [
    //   // Match(
    //   //   title: "Current Standing",
    //   //   rounds: [
    //   //     Round(
    //   //       name: "Round 1",
    //   //       points: "1",
    //   //     ),
    //   //     Round(
    //   //       name: "Round 2",
    //   //       points: "2",
    //   //     ),
    //   //   ],
    //   // ),
    //   AverageData(
    //     title: "Start Height average",
    //     pilots: [
    //       Pilots(
    //         rank: 1,
    //         name: "Steve",
    //         average: "4.5",
    //       ),
    //       Pilots(
    //         rank: 2,
    //         name: "John",
    //         average: "6.6",
    //       ),
    //     ],
    //   ),
    //   AverageData(
    //     title: "Landing average",
    //     pilots: [
    //       Pilots(
    //         rank: 1,
    //         name: "Steve",
    //         average: "8.9",
    //       ),
    //       Pilots(
    //         rank: 2,
    //         name: "John",
    //         average: "6.9",
    //       ),
    //       Pilots(
    //         rank: 3,
    //         name: "Alice",
    //         average: "9.7",
    //       ),
    //     ],
    //   ),
    //   AverageData(
    //     title: "Time made average",
    //     pilots: [
    //       Pilots(
    //         rank: 1,
    //         name: "Steve",
    //         average: "8.0",
    //       ),
    //       Pilots(
    //         rank: 2,
    //         name: "John",
    //         average: "25.6",
    //       ),
    //       Pilots(
    //         rank: 3,
    //         name: "Alice",
    //         average: "8.6",
    //       ),
    //     ],
    //   ),
    // ];

    _isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
