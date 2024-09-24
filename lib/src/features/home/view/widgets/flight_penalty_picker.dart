import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../themes/app_theme.dart';
import '../../controller/home_view_model.dart';

class FlightPenaltyPicker extends StatelessWidget {
  const FlightPenaltyPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final mq = MediaQuery.of(context).size;

    final font = Theme.of(context).textTheme;
    List item = [0, 100, 300, 1000];

    return Container(
      height: mq.width * 0.13,
      width: mq.width * 0.25,
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
                      // onSelectedItemChanged: (int index) {
                      //   viewModel.setSelectedFlightPenalty(index + 1);
                      // },
                      // children: List<Widget>.generate(400, (int index) {
                      //   return Center(
                      //     child: Text((index + 1).toString()),
                      //   );
                      // }),
                      onSelectedItemChanged: (int index) {
                        viewModel.setSelectedFlightPenalty(item[index]);
                      },
                      children: item
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
            viewModel.selectedFlightPenalty.toString(),
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
