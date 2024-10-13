import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyAdBanner extends HookWidget {
  const MyAdBanner({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context) {

    BannerAd? bannerAd;
    var isAdLoaded = useState(false); // 広告の読み込み状態
    const bannerId = 'ca-app-pub-2751119101175618/6568260509'; // 広告ID

    // ad load
    void loadAd(){
      bannerAd = BannerAd(
        adUnitId: bannerId,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            print('ad loaded!');
            isAdLoaded.value = true;
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            print('ad failed to load: $error');
            ad.dispose();
          },
        ),
      );
      bannerAd!.load();
    }

    useEffect((){
      loadAd();
      return null;
    }, []);

    return isAdLoaded.value && bannerAd != null
        ? Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: SizedBox(
        width: bannerAd!.size.width.toDouble(),
        height: bannerAd!.size.height.toDouble(),
        child: AdWidget(ad: bannerAd!),
      ),
    )
        : const SizedBox.shrink();
  }
}
