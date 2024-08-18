import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/services/api_services.dart';
import 'package:netflix_clone/models/movie_detailed_model.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final ApiServices _apiServices = ApiServices();
  late Future<MovieDetailedModel> _movieDetail;

  @override
  void initState() {
    super.initState();
    _movieDetail = _apiServices.getMovieDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<MovieDetailedModel>(
        future: _movieDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CupertinoActivityIndicator());
          }
          if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          }
          if (snapshot.hasData) {
            final movie = snapshot.data!;
            return _buildMovieDetail(movie);
          }
          return Center(child: Text('No data available.'));
        },
      ),
    );
  }

  Widget _buildErrorWidget(Object? error) {
    return Center(
      child: Text(
        'Error: ${error ?? 'Unknown error'}',
        style: TextStyle(color: Colors.red, fontSize: 18),
      ),
    );
  }

  Widget _buildMovieDetail(MovieDetailedModel movie) {
    return Stack(
      children: [
        _buildMoviePoster(movie.backdropPath),
        _buildBackButton(),
        _buildMovieInfo(movie),
      ],
    );
  }

  Widget _buildMoviePoster(String backdropPath) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Image.network(
        'https://image.tmdb.org/t/p/w500$backdropPath',
        fit: BoxFit.cover,
        height: 300,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/logo/netflix.png',
            fit: BoxFit.cover,
            height: 300,
          );
        },
      ),
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      top: 40,
      left: 10,
      child: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildMovieInfo(MovieDetailedModel movie) {
    return Positioned(
      top: 300,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.black54,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.title,
              style: _titleTextStyle,
            ),
            SizedBox(height: 8),
            _buildRatingRow(movie.voteAverage),
            SizedBox(height: 8),
            Text(
              'Release Date: ${movie.releaseDate}',
              style: _infoTextStyle,
            ),
            SizedBox(height: 8),
            Text(
              'Genres: ${movie.genres.join(', ')}',
              style: _infoTextStyle,
            ),
            SizedBox(height: 16),
            Text(
              movie.overview,
              style: _overviewTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  TextStyle get _titleTextStyle => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  TextStyle get _infoTextStyle => TextStyle(
    fontSize: 16,
    color: Colors.white70,
  );

  TextStyle get _overviewTextStyle => TextStyle(
    fontSize: 16,
    color: Colors.white,
  );

  Widget _buildRatingRow(double voteAverage) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.yellow, size: 20),
        SizedBox(width: 5),
        Text(
          voteAverage.toStringAsFixed(1),
          style: _infoTextStyle,
        ),
      ],
    );
  }
}
