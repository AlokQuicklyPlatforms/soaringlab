import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';
import '../themes/app_theme.dart';

class TitleCardWidget extends StatelessWidget {
  const TitleCardWidget({
    super.key,
    required this.t1,
    required this.t2,
  });
  final String t1;
  final String t2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
      decoration: const BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: mq.width * 0.2,
            ),
            Row(
              children: [
                Center(
                  child: Image.asset(
                    'assets/icons/soaring_lab_logo.png',
                    width: mq.width * 0.1,
                  ),
                ),
                SizedBox(
                  width: mq.width * 0.02,
                ),
                Text(
                  t1,
                  style: GoogleFonts.stardosStencil(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: mq.width * 0.05,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: mq.width * 0.015),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: mq.width * 0.2,
                ),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'by',
                        style: GoogleFonts.martianMono(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        t2,
                        style: GoogleFonts.stardosStencil(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
