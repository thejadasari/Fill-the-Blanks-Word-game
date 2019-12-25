import 'package:flutter/material.dart';
import 'package:blanks/pages/game-page/text.dart';

class BlankSpot extends StatefulWidget {
  final String character;
  final Function onAcceptChar;
  final Color borderColor;
  final int index;
  final Function updateCharacters;
  BlankSpot({
    @required this.character,
    @required this.onAcceptChar,
    @required this.borderColor,
    @required this.index,
    @required this.updateCharacters,
  });

  @override
  _BlankSpotState createState() => _BlankSpotState();
}

class _BlankSpotState extends State<BlankSpot> {
  double scaleFactor = 1;

  Widget empty() {
    return SizedBox(
      height: 40 * scaleFactor,
      width: 40 * scaleFactor,
    );
  }

  Widget textWithCard(char) {
    return Container(
      width: 40,
      // height: 30,
      child: Card(
        child: TextWidget(text: char),
        elevation: 4,
      ),
    );
  }

  Widget highLightedTextWithCard(
    char, {
    scale = 1.0,
    x: 0.0,
    y: 0.0,
    grayColor: false,
  }) {
    return Transform.translate(
      offset: Offset(x, y),
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: 50,
          child: Card(
            color: grayColor ? Colors.grey : Theme.of(context).primaryColorDark,
            child: TextWidget(text: char, color: Colors.white),
            elevation: 4,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 40 * scaleFactor,
      height: 40 * scaleFactor,
      child: Container(
        // key: UniqueKey(),
        alignment: Alignment.center,
        margin: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            style: BorderStyle.solid,
            color: widget.borderColor, //Theme.of(context).accentColor,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
          child: DragTarget<List>(
            builder: (BuildContext _con, List<List> incoming, List rejected) {
              if (widget.character == "")
                return empty();
              else
                // return TextWidget(text: widget.character);
                return Draggable<List>(
                  data: ["-1", widget.character],
                  child: TextWidget(text: widget.character),
                  childWhenDragging: TextWidget(text: ""),
                  feedback: highLightedTextWithCard(
                    widget.character,
                    scale: 1.25,
                    x: 0.0,
                    y: 0.0,
                  ),
                  onDragCompleted: () {
                    widget.updateCharacters(
                      ["-1", ""],
                      widget.index,
                      context,
                      updateDragables: false,
                    );
                  },
                  onDraggableCanceled: (_, __) {
                    widget.updateCharacters(
                      ["-1", ""],
                      widget.index,
                      context,
                    );
                  },
                );
            },
            onWillAccept: (List data) {
              setState(() {
                scaleFactor = 1.5;
              });
              return true;
            },
            onAccept: (List data) {
              widget.onAcceptChar(data);
              setState(() {
                scaleFactor = 1;
              });
            },
            onLeave: (List data) {
              setState(() {
                scaleFactor = 1;
              });
            },
          ),
        ),
      ),
    );
  }
}
