class GameDetails {
  final String appId;
  final String gameName;
  final bool isFree;
  final Price? price;
  final String longDescription;
  final String shortDescription;
  final String coverImage;
  final List<String> editors;
  final String obfuscatedBackground;
  final String background;

  GameDetails(
      {required this.appId,
      required this.gameName,
      required this.isFree,
      this.price,
      required this.longDescription,
      required this.shortDescription,
      required this.coverImage,
      required this.editors,
      required this.obfuscatedBackground,
      required this.background});

  factory GameDetails.fromJson(Map<String, dynamic> json) {
    return GameDetails(
        appId: json['steam_appid'].toString(),
        gameName: json['name'] ?? '',
        isFree: json['is_free'] ?? false,
        price: json['price_overview'] != null
            ? Price.fromJson(json['price_overview'])
            : null,
        longDescription: json['detailed_description'] ?? '',
        shortDescription: json['short_description'] ?? '',
        coverImage: json['header_image'] ?? '',
        editors: json['publishers'] != null
            ? List<String>.from(json['publishers'])
            : [],
        obfuscatedBackground: json['background'] ?? '',
        background: json['background_raw'] ?? '');
  }
}

class Price {
  final double initialPrice;
  final double finalPrice;
  final int discountPercent;

  Price(
      {required this.initialPrice,
      required this.finalPrice,
      required this.discountPercent});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
        initialPrice:
            json['initial'] != null ? (json['initial'] / 100).toDouble() : 0.0,
        finalPrice:
            json['final'] != null ? (json['final'] / 100).toDouble() : 0.0,
        discountPercent: json['discount_percent'] ?? 0);
  }

  @override
  String toString() {
    return '${finalPrice.toStringAsFixed(2)} €';
  }
}
