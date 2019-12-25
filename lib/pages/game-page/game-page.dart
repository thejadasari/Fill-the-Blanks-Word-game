import 'package:blanks/controllers/word-processor.dart';
import 'package:blanks/database/database.dart';
import 'package:blanks/models/word.dart';
import 'package:blanks/pages/game-page/blank_spot.dart';
import 'package:blanks/pages/game-page/header-bar.dart';
import 'package:blanks/pages/game-page/text.dart';
import 'package:blanks/pages/game-page/views/play_view.dart';
import 'package:blanks/pages/game-page/views/results_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:blanks/ads/ads.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:blanks/change-notifiers/game-mode-notifier.dart';
import 'package:blanks/change-notifiers/coins-notifier.dart';

class GamePage extends StatefulWidget with Ads {
  static final String route = '/game-page';

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String _word = '';
  String _gameMode = '';
  List displayedChars = [];
  List dragables = [];
  Color borderColor;
  bool isWordFound = false;
  bool showHint = false;
  Function addCoinsNotfier;
  WordModel wordModel;
  bool enableRewardButton = true;
  WordProcessor _wordProcessor = WordProcessor();
  AppDataBase _databaseService = AppDataBase();
  bool isLoadingDialogueOpen = false;

  Ads ads = Ads();

  @override
  void initState() {
    super.initState();
    ads.initAds();
    ads.showBannerAd();
  }

  @override
  void dispose() {
    // ads.disposeAds();
    super.dispose();
  }

  showBannerAd() {
    isLoadingDialogueOpen = true;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Container(
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          ),
        );
      },
    ).then((_){
      isLoadingDialogueOpen = false;
    }).catchError((_){
      isLoadingDialogueOpen = false;
    });

    setState(() {
      enableRewardButton = false;
    });
    ads.showRewardAd(awardTripplePoints, enableRewardButtonFn);
  }

  awardTripplePoints() {
    int coins = 3 * (dragables.length + getLevelBonus());
    Fluttertoast.showToast(
      msg: "Bonus $coins coins credited",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    addCoinsNotfier(coins);
  }

  enableRewardButtonFn() {
    if (enableRewardButton == false && isLoadingDialogueOpen) {
      Navigator.of(context).pop();
    }
    setState(() {
      enableRewardButton = true;
    });
  }

  fetchNewWord({displayPreviouslyStoredWord = false}) async {
    Map wordInfo = await _wordProcessor.processWord(
        _gameMode, displayPreviouslyStoredWord);
    setState(() {
      _word = wordInfo['word'];
      displayedChars = wordInfo['displayedChars'];
      dragables = wordInfo['dragables'];
      borderColor = Theme.of(context).accentColor;
      wordModel = wordInfo['wordModel'];
      isWordFound = false;
      showHint = false;
    });
  }

  Widget textWithCard(char, {scale = 1.0, x: 0.0, y: 0.0, grayColor: false}) {
    return Transform.translate(
      offset: Offset(x, y),
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: 50,
          child: Card(
            color: grayColor ? Colors.grey : Theme.of(context).primaryColorDark,
            child: TextWidget(text: char['char'], color: Colors.white),
            elevation: 4,
          ),
        ),
      ),
    );
  }

  List<Widget> getDraggables(List _dragables) {
    List<Widget> draggabledList = [];
    for (var index = 0; index < _dragables.length; index++) {
      Map char = _dragables[index];
      if (!char['hide']) {
        draggabledList.add(Draggable<List>(
          key: UniqueKey(),
          data: [
            index.toString(),
            char['char'],
          ],
          child: textWithCard(char),
          feedback: textWithCard(
            char,
            scale: 1.25,
            x: 0.0,
            y: 0.0,
          ),
          childWhenDragging: textWithCard(char, grayColor: true),
          onDragCompleted: () {
            _dragables[index]['hide'] = true;
            setState(() {
              dragables = _dragables;
            });
          },
        ));
      } else {
        draggabledList.add(
          textWithCard(char, grayColor: true),
        );
      }
    }
    return draggabledList;
  }

  updateCharacters(
    List data,
    int index,
    BuildContext context, {
    updateDragables: true,
  }) {
    var _displayedChars = displayedChars;
    var _newDragables = [...dragables];
    var _isWordFound = false;

    if (updateDragables) {
      var existingDraggedChar = _displayedChars[index]['char'];
      var length = dragables.length;
      var i = 0;
      while (i < length) {
        if (_newDragables[i]['char'] == existingDraggedChar &&
            _newDragables[i]['hide']) {
          _newDragables[i]['hide'] = false;
          break;
        }
        i++;
      }
      setState(() {
        dragables = _newDragables;
      });
    }
    _displayedChars[index]['char'] = data[1];
    List<String> currentChars = [];
    for (int i = 0; i < _displayedChars.length; i++) {
      currentChars.add(_displayedChars[i]['char']);
    }
    Color newBorderColor = Theme.of(context).accentColor;
    if (currentChars.join().length == _word.length) {
      if (currentChars.join() == _word) {
        newBorderColor = Colors.green;
        _isWordFound = true;
        updateWordInDB();
        addCoinsNotfier(dragables.length + getLevelBonus());
      } else {
        newBorderColor = Colors.red;
      }
    }
    setState(() {
      isWordFound = _isWordFound;
      borderColor = newBorderColor;
      displayedChars = _displayedChars;
    });
  }

  updateWordInDB() {
    setState(() {
      showHint = false;
    });
    _wordProcessor.clearActiveWord();
    _databaseService
        .updateWord(GameModeNotifier.updateWordModel(_gameMode, wordModel));
  }

  useHint() {
    setState(() {
      showHint = true;
    });
  }

  List<Widget> populateWord(List wordData, BuildContext context) {
    List<Widget> wordWidgets = [];

    for (var index = 0; index < wordData.length; index++) {
      var word = wordData[index];
      if (word["hidden"]) {
        wordWidgets.add(BlankSpot(
          character: word["char"],
          index: index,
          onAcceptChar: (data) {
            updateCharacters(data, index, context);
          },
          updateCharacters: updateCharacters,
          borderColor: borderColor,
        ));
      } else {
        wordWidgets.add(
          Container(
            width: 40,
            child: TextWidget(text: word["char"]),
          ),
        );
      }
    }
    return wordWidgets;
  }

  getLevelBonus() {
    return GameModeNotifier.getLevelBonus(_gameMode);
  }

  @override
  Widget build(BuildContext context) {
    _gameMode = Provider.of<GameModeNotifier>(context, listen: false).mode;
    addCoinsNotfier =
        Provider.of<CoinsNotifier>(context, listen: false).addCoins;
    if (_gameMode.isNotEmpty && (_word == null || _word.isEmpty)) {
      fetchNewWord(displayPreviouslyStoredWord: true);
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            HeaderBar(),
            if (!isWordFound)
              Expanded(
                child: PlayView(
                  displayedChars: displayedChars,
                  dragables: dragables,
                  fetchNewWord: fetchNewWord,
                  getDraggables: getDraggables,
                  populateWord: populateWord,
                  useHint: useHint,
                  showHint: showHint,
                  wordModel: wordModel,
                ),
                flex: 1,
              ),
            if (isWordFound)
              Expanded(
                child: ResultsView(
                  dragables: dragables,
                  fetchNewWord: fetchNewWord,
                  getLevelBonus: getLevelBonus,
                  word: _word,
                  wordModel: wordModel,
                  trippleScore: showBannerAd,
                  enableRewardButton: enableRewardButton,
                ),
                flex: 1,
              ),
          ],
        ),
      ),
    );
  }
}
