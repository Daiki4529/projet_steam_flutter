import 'package:projet_steam/models/game.dart';
import 'package:projet_steam/services/dio_client.dart';

class SteamRepository {
  final DioClient dioClient;

  SteamRepository({DioClient? dioClient})
      : dioClient = dioClient ?? DioClient();

  Future<List<Game>> fetchMostPlayedGames() async {
    const url =
        'https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/';

    try {
      final response = await dioClient.dio.get(url);
      final List<Game> games = [];
      final ranks = response.data['response']['ranks'];
      for (var item in ranks) {
        games.add(Game.fromJson(item));
      }
      return games;
    } catch (e) {
      throw Exception(
          'Erreur lors de la récupération des jeux les plus joués: $e');
    }
  }
}
