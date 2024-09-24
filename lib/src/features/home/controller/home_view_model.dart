import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:soaring_lab/src/features/home/model/CalculatedScore.dart';
import 'package:soaring_lab/src/features/home/repo/home_repo.dart';
import 'package:soaring_lab/src/services/hive_storage.dart';
import 'package:soaring_lab/src/widgets/dynamic_toast.dart';
import '../../../services/api_services.dart';

class HomeViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  HomeRepository homeRepo = HomeRepository();
  int? getcontestcodetemp;
  TextEditingController contestCodeController = TextEditingController();

  List<MatchCardHome> rounds = [];

  int _selectedFlightWindow = 0;
  int get selectedFlightWindow => _selectedFlightWindow;
  void setSelectedFlightWindow(int value) {
    _selectedFlightWindow = value;
    notifyListeners();
  }

  int _selectedFlightTime = 0;
  int get selectedFlightTime => _selectedFlightTime;
  void setSelectedFlightTime(int value) {
    _selectedFlightTime = value;
    notifyListeners();
  }

  // int _selectedtimesecond = 1;
  // int get selectedtimesecond => _selectedtimesecond;
  // void _selectedtimeSecond(int value) {
  //   _selectedFlightTime = value;
  //   notifyListeners();
  // }

  int _selectedFlightSec = 0;
  int get selectedFlightSec => _selectedFlightSec;
  void setSelectedFlightSec(int value) {
    _selectedFlightSec = value;
    notifyListeners();
  }

  int _selectedFlightHeight = 0;
  int get selectedFlightHeight => _selectedFlightHeight;
  void setSelectedFlightHeight(int value) {
    _selectedFlightHeight = value;
    notifyListeners();
  }

  int _selectedFlightLanding = 0;
  int get selectedFlightLanding => _selectedFlightLanding;
  void setSelectedFlightLanding(int value) {
    _selectedFlightLanding = value;
    notifyListeners();
  }

  int _selectedFlightPenalty = 0;
  int get selectedFlightPenalty => _selectedFlightPenalty;
  void setSelectedFlightPenalty(int value) {
    _selectedFlightPenalty = value;
    notifyListeners();
  }

  void resetdialer() {
    _selectedFlightWindow = 0;
    _selectedFlightTime = 0;
    _selectedFlightSec = 0;
    _selectedFlightHeight = 0;
    _selectedFlightLanding = 0;
    _selectedFlightPenalty = 0;
    notifyListeners();
  }

  void updatedialer(int index) {
    log("indec$index");
    List<Rounds> selectedRound;
    switch (index) {
      case 0:
        selectedRound = round_1;
        break;
      case 1:
        selectedRound = round_2;
        break;
      case 2:
        selectedRound = round_3;
        break;
      case 3:
        selectedRound = round_4;
        break;
      case 4:
        selectedRound = round_5;
        break;
      case 5:
        selectedRound = round_6;
        break;
      case 6:
        selectedRound = round_7;
        break;
      case 7:
        selectedRound = round_8;
        break;
      case 8:
        selectedRound = round_9;
        break;
      case 9:
        selectedRound = round_10;
        break;
      default:
        selectedRound = [];
        break;
    }
    if ((index + 1) != currentround || currentround == 10) {
      _selectedFlightWindow =
          int.tryParse(selectedRound.first.flightWindow) ?? 0;
      _selectedFlightTime = int.tryParse(selectedRound.first.flightTime)! ~/ 60;
      _selectedFlightSec =
          int.tryParse(selectedRound.first.flightTime) != 0 ? 30 : 0;
      _selectedFlightHeight = selectedRound.first.startHeight ?? 0;
      _selectedFlightLanding = selectedRound.first.landing ?? 0;
      _selectedFlightPenalty = selectedRound.first.penalty ?? 0;
      notifyListeners();
    } else {
      resetdialer();
      notifyListeners();
    }
    notifyListeners();
  }

  // TextEditingController flightWindowController = TextEditingController();
  // TextEditingController flightTimeMinController = TextEditingController();
  // TextEditingController flightTimeSecController = TextEditingController();
  // TextEditingController startHeightController = TextEditingController();
  // TextEditingController landingSecController = TextEditingController();
  // TextEditingController penaltycController = TextEditingController();
  bool roundcomplete = false;
  int currentround = matchdatabox.get('round_number') ?? 1;
  int round = matchdatabox.get('round_number') ?? 1;
  int currentmatch = matchdatabox.get('match_number') ?? 0;
  void roundComplete(bool status) {
    roundcomplete = status;
    notifyListeners();
  }

  void prevroundupdate() {
    log("prev round");
    if (round > 1) {
      round--;
    log("prev calleed");

      notifyListeners();
      updatedialer(round - 1);
      notifyListeners();
    } else {
      DynamicToast.show("This is the first round");
    }

    notifyListeners();
  }

  void nextroundupdate() {
    log("next round");
    if (round < currentround) {
      round++;
      notifyListeners();
      updatedialer(round - 1);
      notifyListeners();
    } else {
      DynamicToast.show("This is the current round");
    }

    notifyListeners();
  }

  void setcurrentdata(int cmatch, int cround) {
    round = cround;
    currentround = cround;
    currentmatch = cmatch;
    log("currentmatch and round data set succeessful");
    notifyListeners();
  }

  void nextround(bool finished) {
    if (round == 10) {
      round = 1;
      updatedialer(round - 1);
    } else if (finished == true) {
      round = 1;
      currentround = 1;
    } else {
      currentround++;
      round++;
    }

    matchdatabox.put('round_number', round);
    notifyListeners();
  }

  bool saveflight = false;
  bool updated = true;
  changebutton() {
    saveflight = !saveflight;
    notifyListeners();
  }

  updatebutton() {
    updated = !updated;
    notifyListeners();
  }

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

  // calculated score data
  List<Items> calculatedscore = [];

  void matchchange(int currentmatchs) {
    currentmatch = currentmatchs;
    // matchdatabox.put('match_number', currentmatchs);
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Future<void> fetchData() async {
  //   _isLoading = true;
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     notifyListeners();
  //   });

  //   final result = await _apiService.get('/data',
  //       needToken: true); // Set needToken to true if token is needed
  //   result.fold(
  //     (error) {
  //       // Handle error
  //       print('Error: $error');
  //     },
  //     (data) {
  //       // Handle successful response
  //       print('Success: $data');
  //       // Update your state with the data
  //     },
  //   );
  //   // notifyListeners();

  //   _isLoading = false;
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     notifyListeners();
  //   });
  // }

  // finish the match

  Future<bool> finishtestMatch(BuildContext context) async {
    if (_isLoading) {
      return false;
    }
    try {
      _isLoading = true;
      notifyListeners();

      String userId = authstoragebox.get('userId').toString();

      DateTime now = DateTime.now();

      String formattedDate = DateFormat('dd/MM/yy').format(now);

      final result = await homeRepo.finishtestMatchApi(
          currentmatch, userId, currentround, formattedDate);

      return result.fold(
        (error) {
          print('API Error: $error');
          DynamicToast.show('Error: $error');
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
      print('Exception: $e');
      DynamicToast.show('An error occurred: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // get match id or join  match
  Future<bool> createandjoinmatch(int matchcode) async {
    log(matchcode.toString());
    if (_isLoading) {
      return false;
    }
    try {
      _isLoading = true;
      notifyListeners();

      String userId = authstoragebox.get('userId').toString();

      final result = await homeRepo.createandjoinmatchid(userId, matchcode
          // contestCodeController.text.isNotEmpty
          //     ? int.parse(contestCodeController.text)
          //     : 0
          );

      return result.fold(
        (error) {
          print('API Error: $error');
          DynamicToast.show('Error: $error');
          return false;
        },
        (data) {
          log("here is data for join and create contest :$data");
          if (data["subCode"] == 200) {
            contestCodeController.clear();
            getcontestcodetemp = data["items"]["data"]["match_number"];
            matchdatabox.put(
              'match_number',
              data["items"]["data"]["match_number"],
            );
            currentmatch = data["items"]["data"]["match_number"];

            notifyListeners();
            // DynamicToast.show(data["message"].toString());

            return true;
          } else {
            DynamicToast.show("Invalid match number");
            return false;
          }
        },
      );
    } catch (e) {
      print('Exception: $e');
      DynamicToast.show('An error occurred: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //fetch rounds
  Future<void> fetchroundsdata(BuildContext context) async {
    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    final result = await homeRepo.getCalculatedScore(currentmatch);
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
          processData(calculatedscore);

          //   List<Items> filteredElements = calculatedscore
          //       .where((element) =>
          //           element.testMatches.isNotEmpty &&
          //           element.testMatches[0].matchNumber == currentmatch)
          //       .toList();
          //   calculatedscore.forEach(
          //     (element) {
          //       element.testMatches.where(
          //         (element) {
          //           if (element.rounds.first.roundNumber == 1) {
          //             round_1 = element.rounds;
          //           } else if (element.rounds.first.roundNumber == 2) {
          //             round_2 = element.rounds;
          //           } else if (element.rounds.first.roundNumber == 2) {
          //             round_3 = element.rounds;
          //           }
          //           return true;
          //         },
          //       );
          //       WidgetsBinding.instance.addPostFrameCallback((_) {
          //         notifyListeners();
          //       });
          //     },
          //   );
        }

        // Update your state with the data
      },
    );
    // await Future.delayed(const Duration(seconds: 1));
    // if (round == 1) {
    //   rounds = rounds = [
    //     MatchCardHome(currentmatch: currentmatch, roundcard: [
    //       RoundCardHome(
    //           land: "50m",
    //           name: "John Doe",
    //           penalty: "2",
    //           score: "15",
    //           time: "9m 58s"),
    //       RoundCardHome(
    //           land: "30m",
    //           name: "Jane Smith",
    //           penalty: "3",
    //           score: "20",
    //           time: "2m 58s"),
    //       RoundCardHome(
    //           land: "20m",
    //           name: "Alice Brown",
    //           penalty: "1",
    //           score: "25",
    //           time: "5m 58s")
    //     ])
    //   ];

    //   //  addtestMatch(context);
    //   // int userId = int.parse(authstoragebox.get('userId'));
    //   // log('userid: $userId');
    // }
    // if (round == 2) {
    //   rounds.add(MatchCardHome(
    //     currentmatch: currentmatch,
    //     roundcard: [
    //       RoundCardHome(
    //           land: "100m",
    //           name: "Michael Johnson",
    //           penalty: "4",
    //           score: "18",
    //           time: "7m 45s"),
    //       RoundCardHome(
    //           land: "60m",
    //           name: "Emily Davis",
    //           penalty: "2",
    //           score: "22",
    //           time: "3m 30s"),
    //       RoundCardHome(
    //           land: "40m",
    //           name: "David Wilson",
    //           penalty: "5",
    //           score: "30",
    //           time: "6m 10s")
    //     ],
    //   ));

    //   // addtestMatch(context);
    //   log("user id: " + authstoragebox.get('userId').toString());
    //   // int userId = int.parse(authstoragebox.get('userId'));
    //   // log('userid: $userId');
    // }
    // if (round == 3) {
    //   rounds.add(MatchCardHome(
    //     currentmatch: currentmatch,
    //     roundcard: [
    //       RoundCardHome(
    //           land: "100m",
    //           name: "Michael",
    //           penalty: "4",
    //           score: "18",
    //           time: "7m 45s"),
    //       RoundCardHome(
    //           land: "60m",
    //           name: "Emily ",
    //           penalty: "2",
    //           score: "22",
    //           time: "3m 30s"),
    //       RoundCardHome(
    //           land: "40m",
    //           name: "David ",
    //           penalty: "5",
    //           score: "30",
    //           time: "6m 10s")
    //     ],
    //   ));

    // addtestMatch(context);
    //   log("user id: " + authstoragebox.get('userId').toString());
    //   // int userId = int.parse(authstoragebox.get('userId'));
    //   // log('userid: $userId');
    // }

    _isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

// calculate data

  void processData(List<Items> calculatedscore) {
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
        // if (round.roundNumber == 1) {
        //   round_1.add(round);
        // } else if (round.roundNumber == 2) {
        //   round_2.add(round);
        // } else if (round.roundNumber == 3) {
        //   round_3.add(round);
        // }
      }
    }
    log("round 2$round_2");

    // Notify listeners after processing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Notify listeners or update UI here
      // Example using notifyListeners if this is part of a ChangeNotifier
      notifyListeners();
    });
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
  // update test match

  Future<bool> addtestMatch(BuildContext context, {bool update = false}) async {
    if (_isLoading) {
      return false;
    }
    try {
      _isLoading = true;
      notifyListeners();

      String userId = authstoragebox.get('userId').toString();
      String flightWindow = _selectedFlightWindow.toString();
      DateTime now = DateTime.now();
      log("flight time$_selectedFlightTime");
      String flighttime =
          "${((_selectedFlightTime * 60)) + _selectedFlightSec}";
      String formattedDate = DateFormat('dd/MM/yy').format(now);
      log("fligth time  with sec$flighttime");

      final result = await homeRepo.addTestMatchApi(
        formattedDate,
        currentmatch,
        userId,
        round,
        flightWindow,
        flighttime,
        _selectedFlightHeight,
        _selectedFlightLanding,
        _selectedFlightPenalty,
        update,
      );

      return result.fold(
        (error) {
          print('API Error: $error');
          DynamicToast.show('Error: Somthing went wrong');
          return false;
        },
        (data) {
          log("Datas :$data");
          if (data["subCode"] == 200) {
            if (update == false) {
              setcurrentdata(
                data['items']['data']['test_matches'][0]['match_number'],
                data['items']['data']['test_matches'][0]['rounds'][0]
                    ['round_number'],
              );
            }

            matchdatabox.put(
              'match_number',
              data['items']['data']['test_matches'][0]['match_number'],
            );
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
      _isLoading = false;
      notifyListeners();
    }
  }
}

class MatchCardHome {
  int currentmatch;
  List<RoundCardHome> roundcard;
  MatchCardHome({required this.roundcard, required this.currentmatch});
}

class RoundCardHome {
  final String name;
  final String time;
  final String land;
  final String penalty;
  final String score;
  RoundCardHome({
    required this.name,
    required this.time,
    required this.land,
    required this.penalty,
    required this.score,
  });
}
