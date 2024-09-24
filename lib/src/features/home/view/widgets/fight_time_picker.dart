import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../themes/app_theme.dart';
import '../../controller/home_view_model.dart';

class FlightTimePicker extends StatelessWidget {
  const FlightTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> numbers = List.generate(
      10,
      (index) => index,
    );
    final viewModel = context.watch<HomeViewModel>();
    final mq = MediaQuery.of(context).size;

    final font = Theme.of(context).textTheme;

    return Container(
      height: mq.width * 0.18,
      width: mq.width * 0.18,
      decoration: const BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
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
                        viewModel.setSelectedFlightTime(index);
                      },
                      children:
                          // 0,
                          // 1,
                          // 2,
                          // 3,
                          // 4,
                          // 5,
                          // 6,
                          // 7,
                          // 8,
                          // 9,
                          // 10,
                          // 11,
                          // 12,
                          // 13,
                          // 14,
                          // 15,
                          // 16,
                          // 17,
                          // 18,
                          // 19,
                          // 20,
                          // 21,
                          // 22,
                          // 23,
                          // 24,
                          // 25,
                          // 26,
                          // 27,
                          // 28,
                          // 29,
                          // 30,
                          // 31,
                          // 32,
                          // 33,
                          // 34,
                          // 35,
                          // 36,
                          // 37,
                          // 38,
                          // 39,
                          // 40,
                          // 41,
                          // 42,
                          // 43,
                          // 44,
                          // 45,
                          // 46,
                          // 47,
                          // 48,
                          // 49,
                          // 50,
                          // 51,
                          // 52,
                          // 53,
                          // 54,
                          // 55,
                          // 56,
                          // 57,
                          // 58,
                          numbers.map((int index) {
                        return Center(
                          child: Text((index).toString()),
                        );
                      }).toList(),
                    ),
                  );
                },
              );
            },
            child: Text(
              viewModel.selectedFlightTime.toString(),
              style: font.displaySmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Min",
              style: font.bodySmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 2,
          )
        ],
      ),
    );
  }
}
