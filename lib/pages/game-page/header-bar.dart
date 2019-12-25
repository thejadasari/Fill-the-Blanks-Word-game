import 'package:flutter/material.dart';

import 'package:blanks/components/icons/keys.dart';
import 'package:blanks/components/icons/coins.dart';

class HeaderBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: <Widget>[
          IconButton(
            color: Theme.of(context).primaryColorDark,
            icon: Icon(
              Icons.home,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            tooltip: "Home",
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                KeysView(),
                SizedBox(
                  width: 15,
                ),
                CoinsView(),
              ],
            ),
          )
        ],
      ),
      height: 60,
    );
  }
}
