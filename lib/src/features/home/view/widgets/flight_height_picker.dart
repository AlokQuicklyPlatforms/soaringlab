import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../themes/app_theme.dart';
import '../../controller/home_view_model.dart';

class FlightHeightPicker extends StatelessWidget {
  const FlightHeightPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final mq = MediaQuery.of(context).size;

    final font = Theme.of(context).textTheme;

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
                    onSelectedItemChanged: (int index) {
                      viewModel.setSelectedFlightHeight(index);
                    },
                    children: List<Widget>.generate(300, (int index) {
                      return Center(
                        child: Text((index ).toString()),
                      );
                    }),
                  ),
                );
              },
            );
          },
          child: Text(
            viewModel.selectedFlightHeight.toString(),
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
