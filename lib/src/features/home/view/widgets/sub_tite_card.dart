
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubTitleCard extends StatelessWidget {
  const SubTitleCard({
    super.key,
    required this.title,
    this.bgColor = Colors.blue,
    this.fgColor = Colors.white,
    this.fontWeight = FontWeight.bold,
  });
  final String title;
  final Color? fgColor;
  final Color? bgColor;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
      decoration: BoxDecoration(
        color: bgColor, // Color.fromARGB(255, 88, 203, 140),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          
          Text(
            title, // 'Steve Stanton',
            style: GoogleFonts.poppins(
              color: fgColor,
              fontSize: 18,
              fontWeight: fontWeight,
            ),
          ),
        ],
      ),
    );
  }
}
