import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:netflix_clone/models/movie_recommendation_model.dart';
import 'package:netflix_clone/views/screens/movie_detail_screen.dart';

class MovieRecommendationWidgets extends StatelessWidget {
  final Future<MovieRecommendationModel> movieRecommendation;

  const MovieRecommendationWidgets(
      {Key? key, required this.movieRecommendation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieRecommendationModel>(
      future: movieRecommendation,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        }
        if (snapshot.hasData) {
          return _buildRecommendationGrid(snapshot.data!);
        }
        return const Center(child: Text('No recommendations available.'));
      },
    );
  }

  Widget _buildErrorWidget(Object? error) {
    return Center(
      child: Text(
        'Error: ${error ?? 'Unknown error'}',
        style: const TextStyle(color: Colors.red, fontSize: 18),
      ),
    );
  }

  Widget _buildRecommendationGrid(MovieRecommendationModel recommendations) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: .7,
      ),
      itemCount: recommendations.results.length,
      itemBuilder: (context, index) {
        final recommendation = recommendations.results[index];
        final posterUrl = recommendation.posterPath != null
            ? 'https://image.tmdb.org/t/p/w500${recommendation.posterPath}'
            : null;

        return Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) =>
                      MovieDetailScreen(id: recommendation.id),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: posterUrl ?? 'assets/logo/error.png',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Image.asset(
                        'assets/logo/error.png',
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        recommendation.title!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
