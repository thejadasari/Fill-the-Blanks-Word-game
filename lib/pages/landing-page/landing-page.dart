import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';

import './game-options.dart';
import 'package:blanks/pages/landing-page/logo.dart';
import 'package:blanks/components/icons/keys.dart';
import 'package:blanks/components/icons/coins.dart';

class LandingPage extends StatelessWidget {
  static final String route = '/';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  KeysView(),
                  SizedBox(
                    width: 15,
                  ),
                  CoinsView(),
                ],
              ),
            ),
            Expanded(
              child: Logo(),
              flex: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                OutlineButton.icon(
                  icon: Icon(
                    Icons.share,
                    color: Colors.deepPurple,
                    size: 30,
                  ),
                  label: Text(
                    'Share',
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                  onPressed: () {
                    Share.share(
                        "Checkout this new intersting app: Blanks, \n Install @ https://play.google.com/store/apps/details?id=");
                  },
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                OutlineButton.icon(
                  icon: Icon(
                    Icons.rate_review,
                    color: Colors.deepOrange,
                    size: 30,
                  ),
                  label: Text(
                    'Review',
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                  onPressed: () {
                    LaunchReview.launch(androidAppId: "");
                  },
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ],
            ),
            Expanded(
              flex: 4,
              child: GameOptions(),
            )
          ],
        ),
      ),
    );
  }
}
