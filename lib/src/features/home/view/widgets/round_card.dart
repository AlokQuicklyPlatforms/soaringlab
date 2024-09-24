import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soaring_lab/Showcaseview.dart';
import 'package:soaring_lab/main.dart';

class RoundCard extends StatelessWidget {
  RoundCard(
      {super.key,
      required this.title,
      this.bgColor = Colors.blue,
      this.fgColor = Colors.white,
      this.fontWeight = FontWeight.bold,
      required this.title1,
      required this.next,
      required this.prev,
      required this.keys,
    required  this.change});
  final String title1;
  final String title;
  final Color? fgColor;
  final Color? bgColor;
  final FontWeight? fontWeight;
  final VoidCallback next;
  final VoidCallback prev;
  final List<GlobalKey> keys;
  final Function() change;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
      decoration: BoxDecoration(
        color: bgColor, // Color.fromARGB(255, 88, 203, 140),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            width: 10,
          ),
          ShowCaseView(
            fun: (val) {
              if (val == 'skip') {
            change();
                //  setState(() {

                //  });
              }
            },
            height: 0.75,
            gkey: keys[2],
            title: "Prev Round",
            description: "Tap here to go to prev round",
            child: InkWell(
              onTap: prev,
              child: Image.asset(
                'assets/icons/arrow_left.png',
                width: mq.width * 0.06,
              ),
            ),
          ),
          const Spacer(),
          ShowCaseView(
            fun: (val) {
              if (val == 'skip') {
            change();

           
              }
            },
            height: 0.75,
            gkey: keys[0],
            title: "Contest Code",
            description: "This is your contest code",
            child: Text(
              title1, // 'Steve Stanton',
              style: GoogleFonts.poppins(
                color: fgColor,
                fontSize: 18,
                fontWeight: fontWeight,
              ),
            ),
          ),
          SizedBox(
            width: mq.width * 0.2,
          ),
          ShowCaseView(
            fun: (val) {
              if (val == 'skip') {
            change();
           
              }
            },
            height: 0.75,
            gkey: keys[1],
            title: "Round Number",
            description: "This is your round number",
            child: Text(
              title, // 'Steve Stanton',
              style: GoogleFonts.poppins(
                color: fgColor,
                fontSize: 18,
                fontWeight: fontWeight,
              ),
            ),
          ),
          const Spacer(),
          ShowCaseView(
            fun: (val) {
              if (val == 'skip') {
         
            change();


                
           
              }
            },
            height: 0.75,
            gkey: keys[3],
            title: "Next Round",
            description: "Tap here to go to next round",
            child: InkWell(
              onTap: next,
              child: Image.asset(
                'assets/icons/arrow_right.png',
                width: mq.width * 0.06,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
