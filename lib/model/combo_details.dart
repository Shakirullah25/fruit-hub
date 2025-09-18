library;

/// This model contains the parameters of the combo details

class ComboDetails {
  final String imgPath;
  final String fruitName;
  final String fruitPrice;
  final String description;
  final String shortName;

  ComboDetails({
    required this.imgPath,
    required this.fruitName,
    required this.fruitPrice,
    required this.description,
    required this.shortName,
  });

  factory ComboDetails.fromJson(Map<String, dynamic> json) {
    return ComboDetails(
      imgPath: json["imgPath"],
      fruitName: json["fruitName"],
      fruitPrice: json["fruitPrice"],
      description: json["description"],
      shortName: json["shortName"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "imgPath": imgPath,
      "fruitName": fruitName,
      "fruitPrice": fruitPrice,
      "description": description,
      "shortName": shortName,
    };
  }

   @override
  String toString() {
    return 'ComboDetails(fruitName: $fruitName, fruitPrice: $fruitPrice)';
  }

  // factory ComboDetails.toJson(Map<String, dynamic> json) {
  //   ComboDetails(imgPath: im, fruitName: fruitName, fruitPrice: fruitPrice, description: description, shortName: shortName)
  // }
}
