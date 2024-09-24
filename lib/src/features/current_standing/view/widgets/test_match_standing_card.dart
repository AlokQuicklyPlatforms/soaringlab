import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../main.dart';
// import '../../controller/current_standing_view_model.dart' ;
import '../../model/currentstandingmodel.dart';

class TestMatchStandingCardWidget extends StatelessWidget {
  const TestMatchStandingCardWidget({
    super.key,
    required this.pilotdata,
  });
  final AverageData pilotdata;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[600], // Color.fromARGB(255, 80, 136, 162),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                pilotdata.title,
                style: GoogleFonts.sairaStencilOne(
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
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[800], // Color.fromARGB(255, 88, 203, 140),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: mq.width * 0.08,
                child: Text(
                  "#",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.martianMono(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: mq.width * 0.25,
                child: Text(
                  "Pilot Round",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.martianMono(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: mq.width * 0.35,
                child: Row(
                  children: List.generate(
                    6,
                    (index) => Row(
                      children: [
                        Text(
                          "${index + 1}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.martianMono(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: mq.width * 0.15,
                child: Text(
                  "Total Points",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
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
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.all(Radius.circular(10)),
            // border: Border.all(
            //   color: Colors.black,
            //   width: 2,
            // ),
          ),
          child: Column(
            children: List.generate(pilotdata.pilots.length, (index) {
              var item = pilotdata.pilots[index];
              return tableRow("${index + 1}", item.name, item.average);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget tableRow(
    String i1,
    String i2,
    String i3,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: mq.width * 0.08,
            child: Text(
              i1,
              textAlign: TextAlign.center,
              style: GoogleFonts.martianMono(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: mq.width * 0.25,
            child: Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              i2,
              textAlign: TextAlign.center,
              style: GoogleFonts.martianMono(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: mq.width * 0.35,
            child: Row(
              children: List.generate(
                6,
                (index) => Row(
                  children: [
                    Text(
                      "${index + 1}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.martianMono(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: mq.width * 0.15,
            child: Text(
              i3,
              textAlign: TextAlign.center,
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
