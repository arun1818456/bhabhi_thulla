enum Suit { spades, hearts, diamonds, clubs }

Suit parseSuit(dynamic suitData) {
  if (suitData is Suit) return suitData;
  final String str = suitData?.toString().toLowerCase().trim() ?? "";
  if (str.contains("spades")) return Suit.spades;
  if (str.contains("hearts")) return Suit.hearts;
  if (str.contains("diamonds")) return Suit.diamonds;
  if (str.contains("clubs")) return Suit.clubs;
  return Suit.spades;
}

int parseRank(dynamic rankData) {
  if (rankData is int) return rankData;
  if (rankData is String) return int.tryParse(rankData) ?? 1;
  return 1;
}
