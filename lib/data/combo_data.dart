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
    ];
  }

  static List<ComboDetails> getPopularCombos() {
    return [
      // Add popular combos data here
      ComboDetails(
        imgPath: MyStrings.quinoaImg,
        fruitName: MyStrings.quinoFruit,
        fruitPrice: MyStrings.hottestComboPrize,
        description: MyStrings.detailsInfo,
        shortName: MyStrings.quinoFruitUpperCase,
      ),
    ];
  }

  static List<ComboDetails> getNewCombos() {
    return [
      // Add new combos data here
      ComboDetails(
        imgPath: MyStrings.tropicalFruitImg,
        fruitName: MyStrings.tropicalFruit,
        fruitPrice: MyStrings.hottestComboPrize,
        description: MyStrings.detailsInfo,
        shortName: MyStrings.tropicalFruit,
      ),
    ];
  }

  static List<ComboDetails> getTopCombos() {
    return [
      // Add top combos data here
      ComboDetails(
        imgPath: MyStrings.glowingBerryImg,
        fruitName: MyStrings.glowingBerry,
        fruitPrice: MyStrings.glowingBerryPrize,
        description: MyStrings.detailsInfo,
        shortName: MyStrings.glowingBerry,
      ),
    ];
  }
}