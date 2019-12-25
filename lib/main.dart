import 'package:blanks/change-notifiers/coins-notifier.dart';
import 'package:blanks/change-notifiers/game-mode-notifier.dart';
import 'package:blanks/change-notifiers/keys-notifier.dart';
import 'package:blanks/change-notifiers/skip-word-notifier.dart';
import 'package:blanks/database/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import './pages/landing-page/landing-page.dart';
import './pages/game-page/game-page.dart';

//DONE: Word drag to remove and replace
//Done: Add 50-50 options
//DONE: Update Skips per day
//MVP2: Switch for Description and Synonyms
//TODO: Update word objects in DB .... what is this..?
// DONE: Get words based on length and mode
//MVP 2: Add Daily Bonus
//TODO: Add Buy Keys Button
// DONE: Generate Data for Other words
//MVP 2: IF available Words are Zero then show congratulations message
void main() async {
  // Setting App to be in Portrait Mode
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  // Init DB
  await AppDataBase().initDatabase();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(builder: (context) => GameModeNotifier()),
      ChangeNotifierProvider(builder: (context) => CoinsNotifier()),
      ChangeNotifierProvider(builder: (context) => KeysNotifier()),
      ChangeNotifierProvider(builder: (context) => SkipWordNotifier())
    ],
    child: BlanksInWords(),
  ));
}

class BlanksInWords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = !true;
    return MaterialApp(
      title: "Blanks",
      initialRoute: LandingPage.route,
      routes: {
        LandingPage.route: (context) => LandingPage(),
        GamePage.route: (context) => GamePage(),
      },
    );
  }
}
