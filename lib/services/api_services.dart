import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/models/movie_detailed_model.dart';
import 'package:netflix_clone/models/movie_model.dart';
import 'package:netflix_clone/models/movie_recommendation_model.dart';
import 'package:netflix_clone/models/popular_movie_model.dart';
import 'package:netflix_clone/models/search_model.dart';
import 'package:netflix_clone/models/tv_series_model.dart';
import 'package:netflix_clone/secrets.dart';

const baseUrl = 'https://api.themoviedb.org/3/';
const key = '?api_key=$apiKey';
const authToken = authorization;

class ApiServices {
  Future<MovieModel> getUpcomingMovies() async {
    const endPoint = 'movie/upcoming';
    final url = '$baseUrl$endPoint$key';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Successfully fetched upcoming movies.');
        return MovieModel.fromJson(data);
      } else {
        throw Exception(
            'Failed to load upcoming movies. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching upcoming movies: $e');
    }
  }


  Future<PopularMovieModel> getPopularMovies() async {
    const endPoint = 'movie/popular';
    final url = '$baseUrl$endPoint$key';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Successfully fetched popular movies.');
        return PopularMovieModel.fromJson(data);
      } else {
        throw Exception(
            'Failed to load popular movies. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching popular movies: $e');
    }
  }


  Future<MovieModel> getNowPlayingMovies() async {
    const endPoint = 'movie/now_playing';
    final url = '$baseUrl$endPoint$key';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Successfully fetched now playing movies.');
        return MovieModel.fromJson(data);
      } else {
        throw Exception(
            'Failed to load now playing movies. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching now playing movies: $e');
    }
  }


  Future<TvSeriesModel> getTvSeries() async {
    const endPoint = 'tv/popular';
    final url = '$baseUrl$endPoint$key';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Successfully fetched TV series.');
        return TvSeriesModel.fromJson(data);
      } else {
        throw Exception(
            'Failed to load TV series. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching TV series: $e');
    }
  }


  Future<MovieDetailedModel> getMovieDetail(int id) async {
    const endPoint = 'movie/';
    final url = '$baseUrl$endPoint$id$key';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Successfully fetched movie detail.');
        return MovieDetailedModel.fromJson(data);
      } else {
        throw Exception(
            'Failed to load movie detail. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching movie detail: $e');
    }
  }


  Future<MovieRecommendationModel> getMovieRecommendation(int id) async {
    final String endPoint = 'movie/$id/recommendations';
    final String url = '$baseUrl$endPoint$key';

    try {
      final http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print('Successfully fetched movie recommendation.');
        return MovieRecommendationModel.fromJson(data);
      } else {
        throw Exception('Failed to load movie recommendation. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching movie recommendation: $e');
    }
  }


  Future<SearchModel> getSearchedMovies(String query) async {
    const String endPoint = 'search/movie';
    final String url = '$baseUrl$endPoint?query=$query';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': '$authToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Successfully fetched search results.');
        return SearchModel.fromJson(data);
      } else {
        throw Exception(
            'Failed to load search results. Status code: ${response.statusCode}, Response: ${response.body}');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching search results: $e');
    }
  }
}
