import 'package:fruit_salad_combo/constant/my_strings.dart';
import 'package:fruit_salad_combo/model/combo_details.dart';

class ComboData {
  static List<ComboDetails> getRecommendedCombos() {
    return [
      ComboDetails(
        imgPath: MyStrings.honeyLimeComboImg,
        fruitName: MyStrings.honeyLimeComboTxt,
        fruitPrice: MyStrings.honeycomboPrize,
        description: MyStrings.detailsInfo,
        shortName: MyStrings.honeyLimeComboTxt,
      ),
      ComboDetails(
        imgPath: MyStrings.glowingBerryImg,
        fruitName: MyStrings.glowingBerry,
        fruitPrice: MyStrings.glowingBerryPrize,
        description: MyStrings.detailsInfo,
        shortName: MyStrings.glowingBerry,
      ),
      ComboDetails(
        imgPath: MyStrings.berryBlastImg,
        fruitName: MyStrings.berryBlastcombo,
        fruitPrice: MyStrings.berryBlastcomboPrice,
        description: MyStrings.detailsInfo,
        shortName: MyStrings.berryBlastcombo,
      ),
      ComboDetails(
        imgPath: MyStrings.citrusSplashImg,
        fruitName: MyStrings.citrusSplash,
        fruitPrice: MyStrings.citrusSplashPrice,
        description: MyStrings.detailsInfo,
        shortName: MyStrings.citrusSplash,
      ),
    ];
  }

  static List<ComboDetails> getHottestCombos() {
    return [
      ComboDetails(
        imgPath: MyStrings.quinoaImg,
        fruitName: MyStrings.quinoFruit,
        fruitPrice: MyStrings.hottestComboPrize,
        description: MyStrings.detailsInfo,
        shortName: MyStrings.quinoFruitUpperCase,
      ),
      ComboDetails(
        imgPath: MyStrings.tropicalFruitImg,
        fruitName: MyStrings.tropicalFruit,
        fruitPrice: MyStrings.hottestComboPrize,
        description: MyStrings.detailsInfo,
        shortName: MyStrings.tropicalFruit,
      ),
      ComboDetails(
        imgPath: MyStrings.summerBreezeImg,
        fruitName: MyStrings.summerBreeze,
        fruitPrice: MyStrings.summerBreezePrice,
        description: MyStrings.detailsInfo,
        shortName: MyStrings.summerBreeze,
      ),
    ];
  }

  static List<ComboDetails> getPopularCombos() {
    return [
      ComboDetails(
        imgPath: MyStrings.carribeanMixImg,
        fruitName: MyStrings.carribeanMix,
        fruitPrice: MyStrings.carribeanMixPrice,
        description: MyStrings.detailsInfo,
        shortName: MyStrings.carribeanMix,
      ),
      ComboDetails(
        imgPath: MyStrings.sweetSymphonyImg,
        fruitName: MyStrings.sweetSymphony,
        fruitPrice: MyStrings.sweetSymphonyPrice,
        description: MyStrings.detailsInfo,
        shortName: MyStrings.sweetSymphony,
      ),
    ];
  }

  static List<ComboDetails> getNewCombos() {
    return [
      ComboDetails(
        imgPath: MyStrings.tropicalQuinoaDelightImg,
        fruitName: MyStrings.tropicalQuinoaDelight,
        fruitPrice: MyStrings.tropicalQuinoaDelightPrice,
        description: MyStrings.detailsInfo,
        shortName: MyStrings.tropicalQuinoaDelight,
      ),
      ComboDetails(
        imgPath: MyStrings.berryBlastImg,
        fruitName: MyStrings.berryBlastcombo,
        fruitPrice: MyStrings.berryBlastcomboPrice,
        description: MyStrings.detailsInfo,
        shortName: MyStrings.berryBlastcombo,
      ),
    ];
  }

  static List<ComboDetails> getTopCombos() {
    return [
      ComboDetails(
        imgPath: MyStrings.citrusSplashImg,
        fruitName: MyStrings.citrusSplash,
        fruitPrice: MyStrings.citrusSplashPrice,
        description: MyStrings.detailsInfo,
        shortName: MyStrings.citrusSplash,
      ),
      ComboDetails(
        imgPath: MyStrings.summerBreezeImg,
        fruitName: MyStrings.summerBreeze,
        fruitPrice: MyStrings.summerBreezePrice,
        description: MyStrings.detailsInfo,
        shortName: MyStrings.summerBreeze,
      ),
    ];
  }
}