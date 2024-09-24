import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:soaring_lab/src/themes/app_fonts.dart';
import 'package:soaring_lab/src/themes/app_theme.dart';
import 'package:soaring_lab/src/widgets/common_button.dart';

class ShowCaseView extends StatelessWidget {
  ShowCaseView(
      {Key? key,
      required this.title,
      required this.child,
      required this.description,
      required this.gkey,
      this.sborder = const CircleBorder(),
      required this.height,
      this.tooltipPosition = TooltipPosition.bottom,
      this.fun})
      : super(key: key);

  final String title;
  final Widget child;
  final String description;
  final GlobalKey gkey;
  final ShapeBorder sborder;
  final double height;
  final TooltipPosition tooltipPosition;
  Function(String)? fun;
  

  @override
  Widget build(BuildContext context) {
    // Getting MediaQuery size
    final mq = MediaQuery.of(context).size;

    return Showcase.withWidget(
      tooltipPosition: tooltipPosition,
      width: mq.width,
      height: mq.height,
      container: Container(
        // color: Color.fromARGB(255, 162, 27, 27),
        padding: const EdgeInsets.all(10),
        height: mq.height * height,
        width: mq.width,
        child: Stack(
          children: [
            Align(
              alignment: tooltipPosition == TooltipPosition.top
                  ? Alignment.bottomCenter
                  : Alignment.topCenter,
              child: Container(
                height: 150,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppFonts.headline3,
                    ),
                    Text(description),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonButton(
                          fontSize: 17,
                          backgroundColor: AppTheme.primaryColor,
                          textColor: Colors.white,
                          width: 100,
                          onPressed: () {
                            ShowCaseWidget.of(context).previous();
                          },
                          text: "Previous",
                        ),
                        CommonButton(
                          fontSize: 17,
                          backgroundColor: AppTheme.primaryColor,
                          textColor: Colors.white,
                          width: 70,
                          onPressed: () {
                            fun?.call('next');
                            ShowCaseWidget.of(context).next();
                          },
                          text: "Next",
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            // Positioned(
            //   right: 30,
            //   bottom: tooltipPosition == TooltipPosition.top ? 1 : null,
            //   child: CommonButton(
            //     fontSize: 17,
            //     backgroundColor: AppTheme.primaryColor,
            //     textColor: Colors.white,
            //     width: 70,
            //     onPressed: () {
            //       fun?.call();
            //       ShowCaseWidget.of(context).next();
            //     },
            //     text: "Next",
            //   ),
            // ),
            // Positioned(
            //   bottom: tooltipPosition == TooltipPosition.top ? 1 : null,
            //   // top: tooltipPosition == TooltipPosition.top ? 0 : 1,
            //   left: 5,
            //   child: CommonButton(
            //     fontSize: 17,
            //     backgroundColor: AppTheme.primaryColor,
            //     textColor: Colors.white,
            //     width: 100,
            //     onPressed: () {
            //       ShowCaseWidget.of(context).previous();
            //     },
            //     text: "Previous",
            //   ),
            // ),

            Positioned(
              bottom: tooltipPosition == TooltipPosition.bottom ? 5 : null,
              right: 30,
              child: CommonButton(
                fontSize: 17,
                backgroundColor: AppTheme.primaryColor,
                textColor: Colors.white,
                width: 70,
                onPressed: () {
                  fun?.call('skip');
                  ShowCaseWidget.of(context).dismiss();
                },
                text: "Skip",
              ),
            ),
          ],
        ),
      ),
      key: gkey,
      disableMovingAnimation: true,

      // title: title,
      // description: description,

      targetShapeBorder: sborder,
      disableBarrierInteraction: true,
      child: child,

      // scrollLoadingWidget: Text("Loading..."),
    );
  }
}

class ShowCaseParentView extends StatelessWidget {
  final List<Widget> showcaseViews;

  const ShowCaseParentView({super.key, required this.showcaseViews});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ...showcaseViews,
        Positioned(
          top: 20,
          right: 20,
          child: CommonButton(
            fontSize: 17,
            backgroundColor: AppTheme.primaryColor,
            textColor: Colors.white,
            width: 70,
            onPressed: () {
              ShowCaseWidget.of(context).dismiss();
            },
            text: "Skip",
          ),
        ),
      ],
    );
  }
}
