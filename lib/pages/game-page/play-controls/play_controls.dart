import 'package:blanks/change-notifiers/keys-notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:blanks/change-notifiers/skip-word-notifier.dart';

class PlayControls extends StatelessWidget {
  final Function useHint;
  final Function nextWord;
  final bool showHint;

  PlayControls({
    @required this.useHint,
    @required this.nextWord,
    @required this.showHint,
  });

  Widget badge(num) {
    return Container(
      width: 24,
      height: 24,
      padding: EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        num.toString(),
        style: TextStyle(
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          width: 200,
          height: 40,
          child: Consumer<KeysNotifier>(
            builder: (_, keysRef, child) {
              return RaisedButton(
                color: Theme.of(context).primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Use Hint',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'assets/images/key.png',
                      height: 24,
                      width: 24,
                    )
                  ],
                ),
                onPressed: (keysRef.keys > 0 && !showHint)
                    ? () {
                        keysRef.updateKeysCount(keysRef.keys - 1);
                        useHint();
                      }
                    : null,
              );
            },
          ),
        ),
        Container(
          width: 200,
          height: 40,
          margin: EdgeInsets.only(top: 16),
          child: Consumer<SkipWordNotifier>(
            builder: (_, skipWordsRef, child) {
              var skipsLeft = skipWordsRef.skipsLeft;
              return OutlineButton(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColorDark,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Skip to next',
                      style: TextStyle(
                        color: skipsLeft > 0
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ),
                    Icon(
                      Icons.skip_next,
                      color: skipsLeft > 0
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                    badge(skipWordsRef.skipsLeft)
                  ],
                ),
                onPressed: skipsLeft > 0
                    ? () {
                        skipWordsRef
                            .updateSkipsLeft(skipWordsRef.skipsLeft - 1);
                        nextWord();
                      }
                    : null,
              );
            },
          ),
        ),
      ],
    );
  }
}
