import 'package:projet_steam/models/game_details.dart';
import 'package:projet_steam/repositories/steam_repository.dart';

class Game {
  final String appId;
  final String name;

  Game({required this.appId, required this.name});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      appId: json['appid'].toString(),
      name: json['name'],
    );
  }

  @override
  String toString() => 'Game(appId: $appId, name: $name)';

  Future<GameDetails> toGameDetails() {
    return SteamRepository().fetchGameDetails(appId);
  }
}
