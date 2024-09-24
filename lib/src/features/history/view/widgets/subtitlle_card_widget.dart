import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soaring_lab/src/features/home/model/CalculatedScore.dart';
import 'package:soaring_lab/src/themes/app_theme.dart';

class HistoryCardWidget extends StatelessWidget {
  HistoryCardWidget({super.key, required this.round, required this.index});

  List<Rounds> round;
  int index;

  @override
  Widget build(BuildContext context) {
    return round.isEmpty
        ? const SizedBox()
        : Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                decoration: const BoxDecoration(
                  color: AppTheme
                      .primaryColor, // Color.fromARGB(255, 80, 136, 162),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Match $index",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    // const SizedBox(width: 10),
                    // Text(
                    //   "F5J test match",
                    //   style: GoogleFonts.martianMono(
                    //     color: Colors.white,
                    //     fontSize: 18,
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
                decoration: const BoxDecoration(
                  color: AppTheme.titlecard,
                  //  Colors.grey[800],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        " #",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.martianMono(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: Text(
                        "Pilot",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.martianMono(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    // SizedBox(width: mq.width * 0.01),
                    SizedBox(
                      width: 100,
                      child: Text(
                        "Time",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.martianMono(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        "Landing",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.martianMono(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        "height",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.martianMono(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        "Penalty",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.martianMono(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    // SizedBox(width: mq.width * 0.01),
                    SizedBox(
                      width: 100,
                      child: Text(
                        "Score",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.martianMono(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0.0),
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12),
                decoration: const BoxDecoration(

                    // borderRadius: BorderRadius.all(Radius.circular(10)),
                    // border: Border.all(
                    //   color: Colors.black,
                    //   width: 2,
                    // ),
                    ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(round.length, (index) {
                    var item = round[index];
                    return tableRow(
                        index + 1,
                        item.pilotName,
                        item.flightTime,
                        item.landing,
                        item.startHeight,
                        item.penalty,
                        item.score,
                        index);
                  }).toList(),
                ),
              ),
            ],
          );
  }

  Widget tableRow(int i6, String i1, String i2, int i3, int startheight, int i4,
      double i5, int index) {
    String? minut = (int.tryParse(i2)! ~/ 60).toStringAsFixed(0);
    String? second = (int.tryParse(i2)! % 60).toStringAsFixed(0);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.0),
      padding: const EdgeInsets.symmetric(vertical: 6),
      color: index % 2 == 0
          ? AppTheme.secondaryColor
          : AppTheme.secondaryColorgrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 50,
            child: Text(
              " ${(i6).toString()}",
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.martianMono(
                color: Colors.black,
                fontSize: 12,
              ),
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
                fontSize: 12,
              ),
            ),
          ),
          // SizedBox(width: mq.width * 0.014),
          SizedBox(
            width: 100,
            child: Text(
              overflow: TextOverflow.ellipsis,
              "${minut}m ${second}s",
              textAlign: TextAlign.start,
              style: GoogleFonts.martianMono(
                color: Colors.black,
                fontSize: 12,
              ),
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
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              startheight.toString(),
              textAlign: TextAlign.start,
              style: GoogleFonts.martianMono(
                color: Colors.black,
                fontSize: 12,
              ),
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
              ),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
