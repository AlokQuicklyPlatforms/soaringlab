// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:soaring_lab/src/features/history/view/history_page.dart';
// import 'package:soaring_lab/src/features/profile/view/profile_screen.dart';

// import '../../themes/app_theme.dart';
// import '../current_standing/controller/current_standing_view_model.dart';
// import '../current_standing/view/current_standing_page.dart';
// import '../history/controller/history_view_model.dart';
// import '../home/view/home_page.dart';

// class BottomNavBar extends StatefulWidget {
//   BottomNavBar({super.key});

//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar> {
//   final _pageController = PageController();

//   // @override
//   @override
//   Widget build(BuildContext context) {
//     final currenetStandingiewModel = context.read<CurrentStandingViewModel>();
//     final historyViewModel = context.read<HistoryViewModel>();
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//           body: PageView(
//             physics: const NeverScrollableScrollPhysics(),
//             controller: _pageController,
//             children: const <Widget>[
//               HomePage(),
//               // HistoryPage(),
//               // CurrentStandingPage(),
//               Profile(),
//               // Center(child: Text('COnntect')),
//             ],
//           ),
//           bottomNavigationBar: BottomNavigationBar(
//             backgroundColor: Colors.white,
//             selectedItemColor: AppTheme.primaryColor,
//             unselectedItemColor: Colors.blue,
//             selectedIconTheme: IconThemeData(color: Colors.lime),
//             currentIndex:idex,

//             // buttonBackgroundColor: Colors.white,
//             // color: Colors.grey.shade300,
//             items: [
//               BottomNavigationBarItem(
//                 label: "home",
//                 icon: Icon(
//                   Icons.home,
//                   size: 35,
//                   // color: Colors.black,
//                 ),
//               ),
//               BottomNavigationBarItem(
//                   label: 'Profile',
//                   icon: Icon(
//                     Icons.person,
//                     size: 35,
//                     // color: Colors.black,
//                   )),
//               // Icon(
//               //   Icons.history,
//               //   size: 35,
//               //   color: Colors.black,
//               // ),
//               // Icon(
//               //   Icons.airplanemode_active_rounded,
//               //   size: 35,
//               //   color: Colors.black,
//               // ),
//             ],
//             onTap: (index) {
//               _pageController.jumpToPage(
//                 index,

//                 // duration: const Duration(milliseconds: 300),
//                 // curve: Curves.easeOut
//               );
//               setState(() {});
//               // if (index == 2) {
//               //   currenetStandingiewModel.fetchCurrentStanding();
//               // }

//               // if (index == 1) {
//               //   historyViewModel.fetchHistory();
//               // }
//             },
//           )
//           //  CurvedNavigationBar(
//           // backgroundColor: Colors.white,
//           // buttonBackgroundColor: Colors.white,
//           // color: Colors.grey.shade300,
//           //   height: 65,
//           //   items: const <Widget>[
//           //     Icon(
//           //       Icons.home,
//           //       size: 35,
//           //       color: Colors.black,
//           //     ),
//           //     // Icon(
//           //     //   Icons.history,
//           //     //   size: 35,
//           //     //   color: Colors.black,
//           //     // ),
//           //     // Icon(
//           //     //   Icons.airplanemode_active_rounded,
//           //     //   size: 35,
//           //     //   color: Colors.black,
//           //     // ),
//           //     Icon(
//           //       Icons.person,
//           //       size: 35,
//           //       color: Colors.black,
//           //     )
//           //   ],
//           // onTap: (index) {
//           //   _pageController.jumpToPage(
//           //     index,
//           //     // duration: const Duration(milliseconds: 300),
//           //     // curve: Curves.easeOut
//           //   );
//           //   // if (index == 2) {
//           //   //   currenetStandingiewModel.fetchCurrentStanding();
//           //   // }

//           //   // if (index == 1) {
//           //   //   historyViewModel.fetchHistory();
//           //   // }
//           // },
//           // ),
//           ),
//     );
//   }
// }
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soaring_lab/connection_controller.dart';
import 'package:soaring_lab/connectivity.dart';
import 'package:soaring_lab/main.dart';
import 'package:soaring_lab/src/features/profile/view/profile_screen.dart';
import 'package:soaring_lab/src/features/start_contest/view/matchjoinandcreate.dart';

import '../../themes/app_theme.dart';
import '../current_standing/controller/current_standing_view_model.dart';
import '../history/controller/history_view_model.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final _pageController = PageController();
  int _selectedIndex = 0;
      final MyConnectivity _connectivity = MyConnectivity.instance;

  void initState() {
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      context.read<ConnectionController>().setconnection(source);
    });
    // TODO: implement onInit
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    
    final currenetStandingViewModel = context.read<CurrentStandingViewModel>();
    final historyViewModel = context.read<HistoryViewModel>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: const <Widget>[
            Matchjoinandcreate(),
            Profile(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: AppTheme.primaryColor,
          unselectedItemColor:
              Colors.grey, // Change this to your preferred color
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(
                Icons.home,
                size: 35,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(
                Icons.person,
                size: 35,
              ),
            ),
          ],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
