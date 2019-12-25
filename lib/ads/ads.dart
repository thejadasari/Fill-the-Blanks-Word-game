import 'dart:async';

import 'package:firebase_admob/firebase_admob.dart';

class Ads {
  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>[
      'Words',
      'Language',
      'Learning',
      'Smart',
      'Puzzle',
      'Games',
      'Education'
    ],
    // testDevices: <String>[
    // ], // Android emulators are considered test devices
  );

  final BannerAd myBanner = BannerAd(
    adUnitId: '',
    size: AdSize.smartBanner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("BannerAd event is $event");
    },
  );

  Future<bool> initAds() {
    return FirebaseAdMob.instance.initialize(
      appId: '',
      analyticsEnabled: true,
    );
  }

  showBannerAd() {
    myBanner
      // typically this happens well before the ad is shown
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        anchorOffset: 1.0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );
  }

  // loadRewardAd() {
  //   RewardedVideoAd.instance.load(
  //       adUnitId: RewardedVideoAd.testAdUnitId,
  //       targetingInfo: MobileAdTargetingInfo(
  //         keywords: <String>[
  //           'Words',
  //           'Language',
  //           'Learning',
  //           'Smart',
  //           'Puzzle',
  //           'Games',
  //           'Education',
  //         ],
  //         testDevices: <String>[
  //         ], // Android emulators are considered test devices
  //       ));
  // }

  showRewardAd(Function successCallback, Function finalCallback) async {
    try {
      RewardedVideoAd.instance.listener =
          (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
        print(event);
        if (event == RewardedVideoAdEvent.loaded) {
          RewardedVideoAd.instance.show();
        } else {
          if (event == RewardedVideoAdEvent.rewarded) {
            successCallback();
          }
          finalCallback();
        }
      };

      await RewardedVideoAd.instance.load(
          adUnitId: '',
          targetingInfo: MobileAdTargetingInfo(
            keywords: <String>[
              'Words',
              'Language',
              'Learning',
              'Smart',
              'Puzzle',
              'Games',
              'Education',
            ],
            // testDevices: <String>[
            // ], // Android emulators are considered test devices
          ));
    } catch (e) {
      print(e.message);
      finalCallback();
    }
  }

  disposeAds() {
    myBanner?.dispose();
  }
}
