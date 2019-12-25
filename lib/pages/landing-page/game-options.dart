import 'package:flutter/material.dart';
import 'package:blanks/pages/game-page/game-page.dart';
import './difficulty-options.dart';

class GameOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          width: 300,
          child: RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            elevation: 5,
            color: Theme.of(context).primaryColorDark,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(8.0),
            ),
            child: Text(
              "Play",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, GamePage.route);
            },
          ),
        ),
        Container(
          width: 300,
          child: OutlineButton(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColorDark,
            ),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(8.0),
            ),
            child: Text(
              'Select Difficulty',
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.circular(5.0),
                  ),
                ),
                builder: (_) {
                  return GestureDetector(
                    child: Container(
                      child: DifficultyOptions(),
                    ),
                    onTap: () {},
                    behavior: HitTestBehavior.opaque,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
