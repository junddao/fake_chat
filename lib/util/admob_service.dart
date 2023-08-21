import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static final AdMobService _adMobService = AdMobService._internal();

  factory AdMobService() {
    return _adMobService;
  }

  AdMobService._internal();

  InterstitialAd? interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  String getAdMobID() {
    if (Platform.isIOS) {
      return 'ca-app-pub-9695790043722201~3375902957';
    } else {
      return "ca-app-pub-9695790043722201~2171273127";
    }
  }

  String getInterstitialAdId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-9695790043722201~3359475487'; // 내꺼
      // return 'ca-app-pub-3940256099942544/4411468910'; // test광고
    } else {
      // my admob
      return "ca-app-pub-9695790043722201/9761232301"; // 내꺼
      // return 'ca-app-pub-3940256099942544/1033173712'; //test 광고
    }
  }

  String getAppOpenAdId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-9695790043722201/4857162122';
    } else {
      return 'ca-app-pub-9695790043722201/1433740677';
    }
  }

  Future<void> getNewInterstitial() {
    return InterstitialAd.load(
      adUnitId: getInterstitialAdId(),
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
          _numInterstitialLoadAttempts += 1;
          interstitialAd = null;
          if (_numInterstitialLoadAttempts < 3) {
            getNewInterstitial();
          }
        },
      ),
    );
  }
}
