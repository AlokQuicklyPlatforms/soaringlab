class CalculatedScore {
  CalculatedScore({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });
  late final bool status;
  late final int subCode;
  late final String message;
  late final String error;
  late final List<Items> items;

  CalculatedScore.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? false;
    subCode = json['subCode'] ?? '';
    message = json['message'] ?? '';
    error = json['error'] ?? '';
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['subCode'] = subCode;
    data['message'] = message;
    data['error'] = error;
    data['items'] = items.map((e) => e.toJson()).toList();
    return data;
  }
}

class Items {
  Items({
    required this.id,
    required this.userId,
    required this.testMatches,
    required this.V,
  });
  late final String id;
  late final String userId;
  late final List<TestMatches> testMatches;
  late final int V;

  Items.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['user_id'];
    testMatches = List.from(json['test_matches'])
        .map((e) => TestMatches.fromJson(e))
        .toList();
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['user_id'] = userId;
    data['test_matches'] = testMatches.map((e) => e.toJson()).toList();
    data['__v'] = V;
    return data;
  }
}

class TestMatches {
  TestMatches({
    required this.matchNumber,
    required this.rounds,
    required this.id,
  });
  late final int matchNumber;
  late final List<Rounds> rounds;
  late final String id;

  TestMatches.fromJson(Map<String, dynamic> json) {
    matchNumber = json['match_number'];
    rounds = List.from(json['rounds']).map((e) => Rounds.fromJson(e)).toList();
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['match_number'] = matchNumber;
    data['rounds'] = rounds.map((e) => e.toJson()).toList();
    data['_id'] = id;
    return data;
  }
}

class Rounds {
  Rounds({
    required this.roundNumber,
    required this.flightWindow,
    required this.flightTime,
    required this.startHeight,
    required this.landing,
    required this.pilotName,
    required this.penalty,
    required this.score,
    required this.date,
    required this.id,
  });
  late final int roundNumber;
  late final String flightWindow;
  late final String flightTime;
  late final String pilotName;
  late final int startHeight;
  late final String date;
  late final int landing;
  late final int penalty;
  late final double score;
  late final String id;

  Rounds.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    pilotName = json['pilotName'];
    roundNumber = json['round_number'];
    flightWindow = json['flight_window'];
    flightTime = json['flight_time'];
    startHeight = json['start_height'];
    landing = json['landing'];
    penalty = json['penalty'];
    score = json['score'].toDouble();
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['round_number'] = roundNumber;
    data['date'] = date;
    data['flight_window'] = flightWindow;
    data['flight_time'] = flightTime;
    data['pilotName'] = pilotName;
    data['start_height'] = startHeight;
    data['landing'] = landing;
    data['penalty'] = penalty;
    data['score'] = score;
    data['_id'] = id;
    return data;
  }
}
