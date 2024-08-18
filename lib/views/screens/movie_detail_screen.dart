import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/models/movie_detailed_model.dart';
import 'package:netflix_clone/services/api_services.dart';

class MovieDetailScreen extends StatefulWidget {
  final int id;

  const MovieDetailScreen({Key? key, required this.id}) : super(key: key);

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
            return _buildMovieDetail(snapshot.data!);
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
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMoviePoster(movie.posterPath),
              _buildMovieInfo(movie),
            ],
          ),
        ),
        _buildBackButton(),
      ],
    );
  }

  Widget _buildMoviePoster(String? posterPath) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          Image.network(
            'https://image.tmdb.org/t/p/w500$posterPath',
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              }
            },
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/logo/netflix_logo.png',
                fit: BoxFit.cover,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMovieInfo(MovieDetailedModel movie) {
    return Container(
      color: Colors.black54,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text(
            movie.title,
            style: _titleTextStyle,
          ),
          SizedBox(height: 8),
          _buildRatingRow(movie.voteAverage),
          SizedBox(height: 8),
          if (movie.releaseDate != null)
            Text(
              'Release Date: ${movie.releaseDate}',
              style: _infoTextStyle,
            ),
          SizedBox(height: 8),
          if (movie.genres.isNotEmpty) _buildGenresRow(movie.genres),
          SizedBox(height: 16),
          Text(
            movie.overview,
            style: _overviewTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return Positioned(
      top: 50,
      left: 0,
      child: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded,
            color: Colors.white, size: 30),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildGenresRow(List<Genre> genres) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: genres.map((genre) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            genre.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        );
      }).toList(),
    );
  }

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
}
