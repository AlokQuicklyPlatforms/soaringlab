// class CurrentStanding {
//   CurrentStanding({
//     required this.status,
//     required this.subCode,
//     required this.message,
//     required this.error,
//     required this.items,
//   });
//   late final bool status;
//   late final int subCode;
//   late final String message;
//   late final String error;
//   late final Items items;

//   CurrentStanding.fromJson(Map<String, dynamic> json){
//     status = json['status'];
//     subCode = json['subCode'];
//     message = json['message'];
//     error = json['error'];
//     items = Items.fromJson(json['items']);
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['status'] = status;
//     _data['subCode'] = subCode;
//     _data['message'] = message;
//     _data['error'] = error;
//     _data['items'] = items.toJson();
//     return _data;
//   }
// }

// class Items {
//   Items({
//     required this.startHeight,
//     required this.landing,
//     required this.flightTime,
//   });
//   late final List<StartHeight> startHeight;
//   late final List<Landing> landing;
//   late final List<FlightTime> flightTime;

//   Items.fromJson(Map<String, dynamic> json){
//     startHeight = List.from(json['start_height']).map((e)=>StartHeight.fromJson(e)).toList();
//     landing = List.from(json['landing']).map((e)=>Landing.fromJson(e)).toList();
//     flightTime = List.from(json['flight_time']).map((e)=>FlightTime.fromJson(e)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['start_height'] = startHeight.map((e)=>e.toJson()).toList();
//     _data['landing'] = landing.map((e)=>e.toJson()).toList();
//     _data['flight_time'] = flightTime.map((e)=>e.toJson()).toList();
//     return _data;
//   }
// }

// class StartHeight {
//   StartHeight({
//     required this.userId,
//     required this.pilotName,
//     required this.avg,
//   });
//   late final String userId;
//   late final String pilotName;
//   late final int avg;

//   StartHeight.fromJson(Map<String, dynamic> json){
//     userId = json['userId'];
//     pilotName = json['pilotName'];
//     avg = json['avg'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['userId'] = userId;
//     _data['pilotName'] = pilotName;
//     _data['avg'] = avg;
//     return _data;
//   }
// }

// class Landing {
//   Landing({
//     required this.userId,
//     required this.pilotName,
//     required this.avg,
//   });
//   late final String userId;
//   late final String pilotName;
//   late final int? avg;

//   Landing.fromJson(Map<String, dynamic> json){
//     userId = json['userId'];
//     pilotName = json['pilotName'];
//     avg = json['avg'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['userId'] = userId;
//     _data['pilotName'] = pilotName;
//     _data['avg'] = avg;
//     return _data;
//   }
// }

// class FlightTime {
//   FlightTime({
//     required this.userId,
//     required this.pilotName,
//     required this.avg,
//   });
//   late final String userId;
//   late final String pilotName;
//   late final int? avg;

//   FlightTime.fromJson(Map<String, dynamic> json){
//     userId = json['userId'];
//     pilotName = json['pilotName'];
//     avg = json['avg'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['userId'] = userId;
//     _data['pilotName'] = pilotName;
//     _data['avg'] = avg;
//     return _data;
//   }
// }
class AverageData {
  final String title;
  final List<Pilots> pilots;

  AverageData({required this.title, required this.pilots});
}

class Pilots {
  final int rank;
  final String name;
  final String average;

  Pilots({required this.rank, required this.name, required this.average});
}
