import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/models/movie_model.dart';
import 'package:netflix_clone/models/tv_series_model.dart';
import 'package:netflix_clone/secrets.dart';

const baseUrl = 'https://api.themoviedb.org/3/';
const key = '?api_key=$apiKey';

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
        throw http.ClientException(
            'Failed to load upcoming movies, Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching upcoming movies: $e');
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
        throw http.ClientException(
            'Failed to load now playing movies, Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(
          'An error occurred while fetching now playing movies: $e');
    }
  }


  Future<TvSeriesModel> getTvSeries() async {
    const endPoint = 'tv/popular';
    final url = '$baseUrl$endPoint$key';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Successfully fetched now tv series.');
        return TvSeriesModel.fromJson(data);
      } else {
        throw http.ClientException(
            'Failed to load now tv series, Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(
          'An error occurred while fetching now tv series: $e');
    }
  }
}
