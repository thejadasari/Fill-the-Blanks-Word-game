import 'package:blanks/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share/share.dart';

class ResultsView extends StatelessWidget {
  final word;
  final WordModel wordModel;
  final dragables;
  final Function fetchNewWord;
  final Function getLevelBonus;
  final FlutterTts flutterTts = new FlutterTts();
  final Function trippleScore;
  final bool enableRewardButton;

  ResultsView({
    @required this.word,
    @required this.wordModel,
    @required this.dragables,
    @required this.fetchNewWord,
    @required this.getLevelBonus,
    @required this.trippleScore,
    @required this.enableRewardButton,
  });

  speakWord() async {
    await flutterTts.stop();
    await flutterTts.speak(wordModel.word);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 30, bottom: 15),
          child: Text(
            '${word[0].toUpperCase()}${word.substring(1)}',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                wordModel.pronunciation,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 28,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              IconButton(
                icon: Icon(
                  Icons.volume_up,
                  size: 28,
                ),
                onPressed: speakWord,
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 30, top: 16, bottom: 16, right: 16),
          child: Column(
            children: <Widget>[
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
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            left: 30,
            bottom: 5,
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 30),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Winnings:",
                      style: TextStyle(fontSize: 24, color: Colors.deepOrange),
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    Text(
                      "+${getLevelBonus() + dragables.length}",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Transform.translate(
                      offset: const Offset(0.0, 7.0),
                      child: Image.asset(
                        'assets/images/coin-heap.png',
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          width: 300,
          height: 50,
          margin: EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              OutlineButton(
                onPressed: () {
                  Share.share(
                      "Checkout this new intersting app: Blanks, \n Install @ https://play.google.com/store/apps/details?id=");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.share,
                      size: 30,
                      color: Colors.purple,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Share",
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                borderSide: BorderSide(color: Colors.deepPurple),
              ),
              OutlineButton(
                onPressed: enableRewardButton ? trippleScore : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.video_library,
                      size: 30,
                      color: Colors.deepOrange,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "3x Coins",
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Transform.translate(
                      offset: const Offset(0.0, 0.0),
                      child: Image.asset(
                        'assets/images/coin-heap-3x.png',
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ],
                ),
                borderSide: BorderSide(color: Colors.deepOrange),
              ),
            ],
          ),
        ),
        Container(
          width: 300,
          height: 50,
          margin: EdgeInsets.only(bottom: 70),
          child: RaisedButton(
            onPressed: fetchNewWord,
            child: Text(
              "Continue",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            color: Colors.green,
            elevation: 4,
          ),
        ),
      ],
    );
  }
}
