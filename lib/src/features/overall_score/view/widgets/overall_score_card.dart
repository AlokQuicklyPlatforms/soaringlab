import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soaring_lab/src/features/overall_score/controller/overall_score_controller.dart';
import 'package:soaring_lab/src/themes/app_theme.dart';

class OverallScoreCard extends StatelessWidget {
  OverallScoreCard({super.key, required this.pilotdatal, required this.index});
  Pilot pilotdatal;
  int index;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
        child: SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      // scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
            color: index % 2 != 0
                ? AppTheme.secondaryColor
                : AppTheme.secondaryColorgrey),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
                width: 20,
                child: Text(index.toString(),
                    textAlign: TextAlign.start,
                    style: GoogleFonts.martianMono(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 12,
                        fontWeight: FontWeight.w500))),
            SizedBox(
                width: 120,
                child: Text(pilotdatal.name.toString(),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.martianMono(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 12,
                        fontWeight: FontWeight.w500))),
            SizedBox(
                width: 100,
                child: Text(pilotdatal.finalScore.toStringAsFixed(0),
                    textAlign: TextAlign.start,
                    style: GoogleFonts.martianMono(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 12,
                        fontWeight: FontWeight.w500))),
            Row(
              children: List.generate(
                10,
                (index) {
                  if (index < pilotdatal.roundScores.length) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: SizedBox(
                        // margin: EdgeInsets.symmetric(horizontal: 2),
                        width: 80,
                        child: Row(
                          children: [
                            Text(
                                pilotdatal.roundScores[index].toStringAsFixed(0),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: GoogleFonts.martianMono(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: SizedBox(
                        // margin: EdgeInsets.symmetric(horizontal: 2),
                        width: 80,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
