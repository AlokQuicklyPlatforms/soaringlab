import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:soaring_lab/connection_controller.dart';

import 'package:soaring_lab/src/features/profile/controller/profile_view_model.dart';
import 'package:soaring_lab/src/features/settings/view/setting_screen.dart';
import 'package:soaring_lab/src/features/start_contest/controller/startr_contest_controller.dart';
import 'package:soaring_lab/src/features/start_contest/view/matchjoinandcreate.dart';
import 'package:soaring_lab/src/features/start_contest/view/pilot_code.dart';
import 'package:soaring_lab/src/features/start_contest/view/start_contest.dart';
import 'src/features/auth/controller/auth_view_model.dart';
import 'src/features/auth/view/login_page.dart';
import 'src/features/auth/view/signup_page.dart';
import 'src/features/bottom_nav_bar/bottom_nav_bar.dart';
import 'src/features/current_standing/controller/current_standing_view_model.dart';
import 'src/features/history/controller/history_view_model.dart';
import 'src/features/home/view/home_page.dart';
import 'src/features/overall_score/controller/overall_score_controller.dart';
import 'src/features/splash/splash_screen.dart';
import 'src/services/app_initializer.dart';
import 'src/features/home/controller/home_view_model.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Size mq = const Size(100, 100);
void main() async {
  final appInitializer = AppInitializer();
  await appInitializer.init();
  await Hive.initFlutter().then(
    (value) async {
      await appInitializer.setup();
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]).then((_) {
        // const fatalError = true;
        // // Non-async exceptions
        // FlutterError.onError = (errorDetails) {
        //   if (fatalError) {
        //     // If you want to record a "fatal" exception
        //     FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
        //     // ignore: dead_code
        //   } else {
        //     // If you want to record a "non-fatal" exception
        //     FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
        //   }
        // };
        // // Async exceptions
        // PlatformDispatcher.instance.onError = (error, stack) {
        //   if (fatalError) {
        //     // If you want to record a "fatal" exception
        //     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        //     // ignore: dead_code
        //   } else {
        //     // If you want to record a "non-fatal" exception
        //     FirebaseCrashlytics.instance.recordError(error, stack);
        //   }
        //   return true;
        // };
        runApp(ShowCaseWidget(
          builder: (context) => const SoaringLabApp(),
        ));
      });
    },
  );
}

class SoaringLabApp extends StatelessWidget {
  const SoaringLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => HistoryViewModel()),
        ChangeNotifierProvider(create: (_) => CurrentStandingViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => StartrContestController()),
        ChangeNotifierProvider(create: (_) => OverallScoreViewModel()),
        ChangeNotifierProvider(
          create: (_) => ConnectionController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter App',
        theme: ThemeData(
          // brightness: Brightness.dark,
          // primarySwatch: Colors.blueGrey,
          // primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            bodyLarge: TextStyle(fontSize: 16.0),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) =>
               SplashScreen(), // Change initial route to SplashScreen
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignupPage(),
          '/home': (context) => const HomePage(),
          '/bottom-bar': (context) => const BottomNavBar(), // HistoryPage
          '/startContest': (context) => StartContest(),
          '/pilotCode': (context) => const PilotCode(),
          '/Matchjoinandcreate': (context) => const Matchjoinandcreate(),
          '/SettingScreen': (context) => SettingScreen(),
        },
      ),
    );
  }
}
