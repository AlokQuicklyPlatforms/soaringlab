import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppInitializer {
  // hive box instances
  late Box authstorage;
  late Box userprofile;
  late Box matchdata;
  late Box showcase;
  // Singleton instance
  static final AppInitializer _instance = AppInitializer._internal();

  //  AppInitializer()
  //   : dio = Dio(BaseOptions(
  //         receiveTimeout: Duration(seconds: 5), // 10 seconds
  // connectTimeout: Duration(seconds: 5),// 10 seconds
  //     )),

  // Private constructor
  AppInitializer._internal();

  // Factory constructor
  factory AppInitializer() {
    Dio(BaseOptions(
      receiveTimeout: const Duration(seconds: 10), // 10 seconds
      connectTimeout: const Duration(seconds: 10), // 10 seconds
    ));
    return _instance;
  }

  // Variables to hold instances of controllers, storage, etc.
  late Dio dio;
  late GetStorage storage;

  // Initialization method
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
//initialize hive storage

    // Initialize GetStorage
    await GetStorage.init();
    storage = GetStorage();

    // Initialize Dio
    dio = Dio();
    dio.options.baseUrl =
        'https://api.example.com'; // Replace with your base URL
    dio.options.connectTimeout = const Duration(seconds: 5); // 5 seconds
    dio.options.receiveTimeout = const Duration(seconds: 5); // 3 seconds
  }

  // boxes for hive
  setup() async {
    authstorage = await Hive.openBox('authentication');
    userprofile = await Hive.openBox('userdata');
    matchdata = await Hive.openBox('matchdata');
    showcase = await Hive.openBox('Showcase');
  }
}
