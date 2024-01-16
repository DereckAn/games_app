class Player {
  final String username;
  final String socketID;
  final double score;
  final String symbol;

  Player(
      {required this.username,
      required this.socketID,
      required this.score,
      required this.symbol});

  Map<String, dynamic> toMap() => {
        'username': username,
        'socketID': socketID,
        'score': score,
        'symbol': symbol,
      };

  factory Player.fromMap(Map<String, dynamic> map) => Player(
        username: map['username'] ?? '',
        socketID: map['socketID'] ?? '',
        score: map['score']?.toDouble() ?? 0.0,
        symbol: map['symbol'] ?? '',
      );

      
  Player copyWith({
    String? username,
    String? socketID,
    double? score,
    String? symbol,
  }) {
    return Player(
      username: username ?? this.username,
      socketID: socketID ?? this.socketID,
      score: score ?? this.score,
      symbol: symbol ?? this.symbol,
    );
  }
}
