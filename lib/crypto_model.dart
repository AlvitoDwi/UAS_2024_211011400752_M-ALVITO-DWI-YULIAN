class Crypto {
  final String symbol;
  final String name;
  final String nameid;
  final int rank;
  final double priceUsd;
  final double percentChange24h;
  final double percentChange1h;
  final double percentChange7d;
  final double priceBtc;
  final double marketCapUsd;
  final double volume24;
  final double volume24a;
  final double csupply;
  final String tsupply;
  final String msupply;

  Crypto({
    required this.symbol,
    required this.name,
    required this.nameid,
    required this.rank,
    required this.priceUsd,
    required this.percentChange24h,
    required this.percentChange1h,
    required this.percentChange7d,
    required this.priceBtc,
    required this.marketCapUsd,
    required this.volume24,
    required this.volume24a,
    required this.csupply,
    required this.tsupply,
    required this.msupply,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      symbol: json['symbol'],
      name: json['name'],
      nameid: json['nameid'],
      rank: int.parse(json['rank'].toString()),
      priceUsd: double.parse(json['price_usd'].toString()),
      percentChange24h: double.parse(json['percent_change_24h'].toString()),
      percentChange1h: double.parse(json['percent_change_1h'].toString()),
      percentChange7d: double.parse(json['percent_change_7d'].toString()),
      priceBtc: double.parse(json['price_btc'].toString()),
      marketCapUsd: double.parse(json['market_cap_usd'].toString()),
      volume24: double.parse(json['volume24'].toString()),
      volume24a: double.parse(json['volume24a'].toString()),
      csupply: double.parse(json['csupply'].toString()),
      tsupply: json['tsupply'].toString(),
      msupply: json['msupply'].toString(),
    );
  }
}
