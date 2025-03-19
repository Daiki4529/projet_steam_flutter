import 'package:projet_steam/models/game_details.dart';
import 'package:projet_steam/repositories/steam_repository.dart';

class Game {
  final String appId;
  final int rank;

  Game({required this.appId, required this.rank});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      appId: json['appid'].toString(),
      rank: json['rank'],
    );
  }

  @override
  String toString() => 'Game(appId: $appId, name: $rank)';

  Future<GameDetails> toGameDetails() {
    return SteamRepository().fetchGameDetails(appId);
  }
}
