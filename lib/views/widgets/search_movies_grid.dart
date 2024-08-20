import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:netflix_clone/models/search_model.dart';
import 'package:netflix_clone/views/screens/movie_detail_screen.dart';

class SearchMoviesGrid extends StatelessWidget {
  final SearchModel searchResult;

  const SearchMoviesGrid({required this.searchResult, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: searchResult.results.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: .7,
        ),
        itemBuilder: (context, index) {
          final result = searchResult.results[index];
          final posterUrl = result.posterPath != null
              ? 'https://image.tmdb.org/t/p/w500${result.posterPath}'
              : null;

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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: posterUrl ?? 'assets/logo/netflix_logo.png',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CupertinoActivityIndicator(),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Image.asset(
                          'assets/logo/netflix_logo.png',
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
                          result.title,
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
      ),
    );
  }
}
