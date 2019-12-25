import 'package:blanks/ads/ads.dart';
import 'package:flutter/material.dart';
import 'package:blanks/change-notifiers/keys-notifier.dart';
import 'package:blanks/change-notifiers/coins-notifier.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CoinsConverter extends StatefulWidget with Ads {
  final Function pop;
  CoinsConverter({@required this.pop});

  @override
  _CoinsConverterState createState() => _CoinsConverterState();
}

class _CoinsConverterState extends State<CoinsConverter> {
  Ads ads = Ads();
  int currentValue = 0;
  bool enableRewardButton = true;
  Function addCoinsNotfier;
  Function updateCoinCount;
  Function updateKeysCount;
  @override
  void initState() {
    super.initState();
    ads.initAds();
  }

  @override
  void dispose() {
    // ads.disposeAds();
    super.dispose();
  }

  showBannerAd() {
    setState(() {
      enableRewardButton = false;
    });
    ads.showRewardAd(awardRewardPoints, enableRewardButtonFn);
  }

  awardRewardPoints() {
    int coins = 50;
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
    setState(() {
      enableRewardButton = true;
    });
  }

  double getMaxKeys(BuildContext context) {
    int coins = Provider.of<CoinsNotifier>(context, listen: false).coins;
    return (coins ~/ 50).toDouble();
  }

  createKeys(BuildContext context) {
    widget.pop();
    int coins = Provider.of<CoinsNotifier>(context, listen: false).coins;
    int remainingCoins = coins - currentValue * 50;
    updateCoinCount(remainingCoins);
    var keys = Provider.of<KeysNotifier>(context, listen: false).keys;
    updateKeysCount(keys + currentValue);
  }

  @override
  Widget build(BuildContext context) {
    addCoinsNotfier =
        Provider.of<CoinsNotifier>(context, listen: false).addCoins;
    updateCoinCount =
        Provider.of<CoinsNotifier>(context, listen: false).updateCoinCount;
    updateKeysCount =
        Provider.of<KeysNotifier>(context, listen: false).updateKeysCount;
    return Container(
      width: 350.0,
      height: 300.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Coins Exchange",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).primaryColorDark,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 10.0,
                    color: Color.fromARGB(55, 0, 0, 0),
                  ),
                ],
              ),
            ),
          ),
          if (getMaxKeys(context) == 0)
            Container(
              width: 270.0,
              height: 120.0,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Text(
                  "Not enough coins available to buy Hints, watch Ad to earn coins.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    // color: Colors.grey,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 10.0,
                        color: Color.fromARGB(95, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (getMaxKeys(context) > 0)
            Container(
              width: 270.0,
              height: 120.0,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Slider.adaptive(
                    min: 0.0,
                    max: getMaxKeys(context),
                    value: currentValue.toDouble(),
                    divisions: getMaxKeys(context).toInt(),
                    activeColor: Colors.green,
                    inactiveColor: Colors.grey,
                    label: "${currentValue * 50} Coins",
                    onChanged: (double newValue) {
                      print(newValue);
                      setState(() {
                        currentValue = newValue.round().toInt();
                      });
                    },
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "0",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text(
                                getMaxKeys(context).toInt().toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 3,
                                ),
                                child: Image.asset(
                                  'assets/images/key.png',
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 270.0,
            child: Column(
              children: <Widget>[
                OutlineButton(
                  onPressed: enableRewardButton ? showBannerAd : null,
                  child: Container(
                    width: 200.0,
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
                          "Earn 50 Coins",
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
                  ),
                  borderSide: BorderSide(color: Colors.deepOrange),
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  onPressed: getMaxKeys(context).toInt() == 0
                      ? null
                      : () {
                          createKeys(context);
                        },
                  child: Container(
                    width: 200.0,
                    child: Center(
                      child: Text(
                        "Convert",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  color: Colors.green,
                  elevation: 4,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
