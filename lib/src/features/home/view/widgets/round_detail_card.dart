import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soaring_lab/src/themes/app_theme.dart';

import '../../model/CalculatedScore.dart';

class RoundDetailCard extends StatelessWidget {
  RoundDetailCard({super.key, required this.round, required this.index});
  List<Rounds> round;
  int index;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: round.isEmpty
          ? const SizedBox()
          : Column(
              children: [
                // Container(
                //     margin: const EdgeInsets.symmetric(vertical: 0.0),
                //     // width: mq.width * 0.20,
                //     padding: const EdgeInsets.symmetric(
                //         vertical: 0.0, horizontal: 12),
                //     decoration: BoxDecoration(
                //       color: Colors.grey[600],
                //       borderRadius: const BorderRadius.all(Radius.circular(10)),
                //       // border: Border.all(
                //       //   color: Colors.black,
                //       //   width: 2,
                //       // ),
                //     ),
                //     child: Center(
                //       child: Text(
                //         (index).toString(),
                //         style:
                //             AppFonts.popinsfont.copyWith(color: Colors.white),
                //       ),
                //     )),
                // const SizedBox(width: 5),
                // Expanded(
                //   child:
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 1.0),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      // borderRadius: BorderRadius.all(Radius.circular(10)),
                      // border: Border.all(
                      color: index % 2 != 0
                          ? AppTheme.secondaryColor
                          : AppTheme.secondaryColorgrey
                      //   width: 2,
                      // ),
                      ),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(round.length, (index) {
                      var item = round[index];
                      return tableRow(
                          item.roundNumber,
                          item.pilotName,
                          item.flightTime,
                          item.landing,
                          item.startHeight,
                          item.penalty,
                          item.score);
                    }).toList(),
                  ),
                ),
                // ),
              ],
            ),
    );
  }

  Widget tableRow(int i6, String i1, String i2, int i3,int startheight, int i4, double i5) {
    // i2 = 570;  i need in result  minut 9 and 30 second
    log("minut and second $i2");
    String? minut = (int.tryParse(i2)! ~/ 60).toStringAsFixed(0);
    String? second = (int.tryParse(i2)! % 60).toStringAsFixed(0);
    log("minut${minut}second$second");

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 50,
            child: Text(
              (i6).toString(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.martianMono(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ),
          // SizedBox(width: mq.width * 0.01),
          SizedBox(
            width: 120,
            child: Text(
              i1,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.martianMono(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),

          SizedBox(
            width: 100,
            child: Text(
              overflow: TextOverflow.ellipsis,
              "${minut}m ${second}s",
              textAlign: TextAlign.start,
              style: GoogleFonts.martianMono(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              i3.toString(),
              textAlign: TextAlign.start,
              style: GoogleFonts.martianMono(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ),
            SizedBox(
            width: 100,
            child: Text(
             startheight .toString(),
              textAlign: TextAlign.start,
              style: GoogleFonts.martianMono(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ),

          SizedBox(
            width: 100,
            child: Text(
              i4.toString(),
              textAlign: TextAlign.start,
              style: GoogleFonts.martianMono(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ),
          // SizedBox(width: mq.width * 0.01),
          SizedBox(
            width: 100,
            child: Text(
              i5.toStringAsFixed(0),
              textAlign: TextAlign.start,
              style: GoogleFonts.martianMono(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
