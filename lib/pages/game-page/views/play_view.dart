import 'package:blanks/models/word.dart';
import 'package:blanks/pages/game-page/play-controls/play_controls.dart';
import 'package:flutter/material.dart';

class PlayView extends StatelessWidget {
  final populateWord;
  final displayedChars;
  final getDraggables;
  final dragables;
  final useHint;
  final fetchNewWord;
  final showHint;
  final WordModel wordModel;

  List<Widget> getHint() {
    if (wordModel.synonyms.length > 2) {
      List<Widget> list = new List<Widget>();
      for (var i = 0; i < wordModel.synonyms.length && i < 3; i++) {
        var synonym = wordModel.synonyms[i];
        list.add(
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 8),
            child: Row(
              children: <Widget>[
                Icon(Icons.arrow_forward_ios),
                SizedBox(
                  width: 16,
                  height: 30,
                ),
                Text(
                  '${synonym[0].toUpperCase()}${synonym.substring(1)}',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
        );
      }
      return [
        Container(
          width: double.infinity,
          child: Text(
            "Synonyms:",
            style: TextStyle(
              fontSize: 22,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        ...list
      ];
    }
    return [
      Container(
        width: double.infinity,
        child: Text(
          "Definition:",
          style: TextStyle(
            fontSize: 22,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      Container(
        width: double.infinity,
        child: Text(
          wordModel.description,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    ];
  }

  PlayView({
    @required this.populateWord,
    @required this.displayedChars,
    @required this.getDraggables,
    @required this.dragables,
    @required this.useHint,
    @required this.fetchNewWord,
    @required this.showHint,
    @required this.wordModel,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 30, bottom: 50),
          child: FractionallySizedBox(
              widthFactor: 0.90,
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                runSpacing: 0.0,
                children: populateWord(displayedChars, context),
              )),
        ),
        Container(
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            children: getDraggables(dragables),
          ),
        ),
        Expanded(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: showHint
                ? Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        ...getHint(),
                      ],
                    ),
                  )
                : Container(),
          ),
          flex: 1,
        ),
        PlayControls(
          showHint: showHint,
          useHint: useHint,
          nextWord: fetchNewWord,
        ),
        SizedBox(
          height: 25,
        )
      ],
    );
  }
}
