import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:netflix_clone/models/popular_movie_model.dart';
import 'package:netflix_clone/views/screens/movie_detail_screen.dart';

class PopularMoviesList extends StatelessWidget {
  final PopularMovieModel popularMovies;

  const PopularMoviesList({required this.popularMovies, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: popularMovies.results.length,
      itemBuilder: (context, index) {
        final result = popularMovies.results[index];
        final String posterUrl =
            'https://image.tmdb.org/t/p/w500${result.posterPath}';

        return Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => MovieDetailScreen(id: result.id),
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: posterUrl,
                    fit: BoxFit.cover,
                    width: 100,
                    height: 150,
                    placeholder: (context, url) => const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/logo/netflix_logo.png',
                      width: 100,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Release Date: ${result.releaseDate}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 16,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            result.voteAverage.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        result.overview,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
