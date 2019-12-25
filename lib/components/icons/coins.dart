import 'package:blanks/change-notifiers/coins-notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoinsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 6,
          ),
          Transform.translate(
            offset: const Offset(0.0, 7.0),
            child: Image.asset(
              'assets/images/coin-heap.png',
              height: 30,
              width: 30,
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Consumer<CoinsNotifier>(
            builder: (_, coinsProvider, child) {
              return Text(
                coinsProvider.coins.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          SizedBox(
            width: 8,
          )
        ],
      ),
    );
  }
}
