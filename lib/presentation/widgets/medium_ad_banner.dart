import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_workout_manager/core/logger.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MediumAdBanner extends HookWidget {
  const MediumAdBanner({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final bannerAd = useState<BannerAd?>(null);
    var isAdLoaded = useState(false); // 広告の読み込み状態
    const bannerId = 'ca-app-pub-2751119101175618/5283502914'; // 広告ID

    // ad load
    void loadAd() {
      final ad = BannerAd(
        adUnitId: bannerId,
        size: AdSize.mediumRectangle,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            logger.d('ad loaded!');
            isAdLoaded.value = true;
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            logger.e('ad failed to load', error: error);
            ad.dispose();
          },
        ),
      );
      ad.load();
      bannerAd.value = ad;
    }

    useEffect(() {
      loadAd();
      return () {
        bannerAd.value?.dispose();
      };
    }, []);

    return Flexible(
      // あらかじめ広告サイズを指定
      child: SizedBox(
        width: 300,
        height: 250,
        // 広告の表示
        child: isAdLoaded.value
            ? SizedBox(
                width: bannerAd.value!.size.width.toDouble(),
                height: bannerAd.value!.size.height.toDouble(),
                child: AdWidget(ad: bannerAd.value!),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
