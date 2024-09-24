import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soaring_lab/src/themes/app_fonts.dart';
import 'package:soaring_lab/src/themes/app_theme.dart';
import '../../../../../main.dart';
// import '../../controller/current_standing_view_model.dart' as cont;
import '../../model/currentstandingmodel.dart';

class CurrentStandingMatchCardWidget extends StatelessWidget {
  const CurrentStandingMatchCardWidget({
    super.key,
    required this.pilotsdata,
  });
  final AverageData pilotsdata;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
          decoration: const BoxDecoration(
            color: AppTheme.primaryColor, // Color.fromARGB(255, 80, 136, 162),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                  pilotsdata.title == 'start_height'
                      ? 'start height'
                      : pilotsdata.title == 'landing'
                          ? 'landing'
                          : 'flight time',
                  style: AppFonts.headline1.copyWith(
                    fontSize: 18,
                    color: Colors.white,
                  )

                  // style: GoogleFonts.sairaStencilOne(
                  //   color: Colors.white,
                  //   fontSize: 18,
                  //   // fontWeight: FontWeight.bold,
                  // ),
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
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
          decoration: const BoxDecoration(
            color: AppTheme.titlecard,
            //  Colors.grey[800], // Color.fromARGB(255, 88, 203, 140),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: mq.width * 0.14,
                child: Text(
                  "Rank",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.martianMono(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(
                width: mq.width * 0.40,
                child: Text(
                  "Pilot",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.martianMono(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(
                width: mq.width * 0.26,
                child: Text(
                  "Average",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.martianMono(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.all(Radius.circular(10)),
            // border: Border.all(
            //   color: Colors.black,
            //   width: 2,
            // ),
          ),
          child: Column(
            children: List.generate(pilotsdata.pilots.length, (index) {
              var item = pilotsdata.pilots[index];
              return tableRow(item.rank, item.name, item.average, index);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget tableRow(int i1, String i2, String i3, int index) {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 1.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
      color: index % 2 == 0
          ? AppTheme.secondaryColor
          : AppTheme.secondaryColorgrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: mq.width * 0.14,
            child: Text(
              (i1).toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.martianMono(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            width: mq.width * 0.40,
            child: Text(
              i2,
              textAlign: TextAlign.start,
              style: GoogleFonts.martianMono(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ),
          // const SizedBox(width: 10),
          SizedBox(
            width: mq.width * 0.26,
            child: Text(
              // "  ${(double.parse(i3) / 60).toStringAsFixed(0)}",
              pilotsdata.title == 'flight_time'
                  ? "  ${(double.parse(i3) / 60).toStringAsFixed(2).split('.').first}m ${(double.parse(i3) % 60).toStringAsFixed(0).split('.').last}s"
                  : (double.parse(i3)).toStringAsFixed(0),
              textAlign: TextAlign.center,
              style: GoogleFonts.martianMono(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ),
          // const SizedBox(width: 10),
          // Text(
          //   i3,
          //   style: GoogleFonts.martianMono(
          //     color: Colors.black,
          //     fontSize: 12,
          //   ),
          // ),
          // const SizedBox(width: 10),
          // Text(
          //   i4,
          //   style: GoogleFonts.martianMono(
          //     color: Colors.black,
          //     fontSize: 12,
          //   ),
          // ),
        ],
      ),
    );
  }
}
