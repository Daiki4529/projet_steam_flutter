import 'package:projet_steam/models/game.dart';
import 'package:projet_steam/models/game_details.dart';
import 'package:projet_steam/models/review.dart';
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

  // Review this from the api
  Future<GameDetails> fetchGameDetails(String appId) async {
    final url = 'https://store.steampowered.com/api/appdetails?appids=$appId&lang=fr';
    try {
      final response = await dioClient.dio.get(url);
      final data = response.data[appId];
      if (data['success'] == true) {
        // Vérification du prix pour les jeux payants
        if (!data['data']['is_free'] && data['data']['price_overview'] == null) {
          throw Exception("Jeu payant sans information de prix");
        }
        return GameDetails.fromJson(data['data']);
      } else {
        throw Exception("Détails du jeu non trouvés");
      }
    } catch (e) {
      throw Exception('Erreur lors de la récupération des détails du jeu: $e');
    }
  }

  Future<List<Review>> fetchGameReviews(String apiId) async {
    final url = 'https://store.steampowered.com/appreviews/$apiId?json=1';
    try {
      final response = await dioClient.dio.get(url);
      final List<Review> reviews = [];
      for (var item in response.data['reviews']) {
        reviews.add(Review.fromJson(item));
      }
      return reviews;
    } catch (e) {
      throw Exception('Erreur lors de la récupération des avis: $e');
    }
  }

  Future<List<Game>> searchGames(String query) async {
    final url = 'https://steamcommunity.com/actions/SearchApps/$query';
    try {
      final response = await dioClient.dio.get(url);
      final List<Game> games = [];
      for (var item in response.data) {
        games.add(Game.fromJson(item));
      }
      return games;
    } catch (e) {
      throw Exception('Erreur lors de la recherche du jeu: $e');
    }
  }
}
