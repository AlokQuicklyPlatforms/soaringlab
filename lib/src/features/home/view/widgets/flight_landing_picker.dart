import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../themes/app_theme.dart';
import '../../controller/home_view_model.dart';

class FlightLandingPicker extends StatelessWidget {
  const FlightLandingPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final mq = MediaQuery.of(context).size;

    final font = Theme.of(context).textTheme;
    List item = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50];

    return Container(
      height: mq.width * 0.13,
      width: mq.width * 0.2,
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
                        viewModel.setSelectedFlightLanding(item[index]);
                      },
                      children: item
                          .map(
                            (e) => Center(
                              child: Text((e).toString()),
                            ),
                          )
                          .toList()
                      // item.map((int index) {
                      //   return Center(
                      //     child: Text((index + 1).toString()),
                      //   );
                      // }).toList(),
                      ),
                );
              },
            );
          },
          child: Text(
            viewModel.selectedFlightLanding.toString(),
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
