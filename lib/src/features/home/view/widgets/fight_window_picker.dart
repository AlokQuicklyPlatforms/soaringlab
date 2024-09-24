import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../themes/app_theme.dart';
import '../../controller/home_view_model.dart';

class FlightWindowPicker extends StatelessWidget {
  const FlightWindowPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final mq = MediaQuery.of(context).size;

    final font = Theme.of(context).textTheme;
    List windowItem = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0];

    return Container(
      height: mq.width * 0.13,
      width: mq.width * 0.14,
      decoration: const BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (_) {
                return SizedBox(
                  height: 200,
                  child: CupertinoPicker(
                      backgroundColor: Colors.white,
                      itemExtent: 32.0,
                      onSelectedItemChanged: (int index) {
                        viewModel.setSelectedFlightWindow(windowItem[index]);

                        viewModel.setSelectedFlightTime(windowItem[index] == 0
                            ? 0
                            //  9
                            : -(windowItem[index] - 10));
                        viewModel.setSelectedFlightSec(windowItem[index] == 0
                            ? 0
                            // 55
                            : 30);
                      },
                      children: windowItem
                          .map(
                            (e) => Center(
                              child: Text((e).toString()),
                            ),
                          )
                          .toList()),
                );
              },
            );
          },
          child: Text(
            viewModel.selectedFlightWindow.toString(),
            style: font.displaySmall!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
