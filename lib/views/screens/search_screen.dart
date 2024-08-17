import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/models/popular_movie_model.dart';
import 'package:netflix_clone/models/search_model.dart';
import 'package:netflix_clone/services/api_services.dart';
import 'package:netflix_clone/views/widgets/popular_movies_list.dart';
import 'package:netflix_clone/views/widgets/search_movies_grid.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ApiServices apiServices = ApiServices();
  SearchModel? searchResult;
  PopularMovieModel? popularMovies;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPopularMovies();
    searchController.addListener(_onSearchChanged);
  }

  void _fetchPopularMovies() async {
    try {
      final movies = await apiServices.getPopularMovies();
      setState(() {
        popularMovies = movies;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching popular movies: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onSearchChanged() {
    final query = searchController.text.trim();
    if (query.isEmpty) {
      setState(() {
        searchResult = null;
      });
    } else {
      _performSearch(query);
    }
  }

  void _performSearch(String query) async {
    try {
      final results = await apiServices.getSearchedMovies(query);
      setState(() {
        searchResult = results;
      });
    } catch (e) {
      print('Error searching for movies: $e');
    }
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: CupertinoSearchTextField(
                padding: const EdgeInsets.all(10),
                controller: searchController,
                style: const TextStyle(color: Colors.white),
                placeholder: 'Search for movies...',
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : searchResult != null
                      ? searchResult!.results.isEmpty
                          ? const Center(
                              child: Text(
                                'No results found',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : SearchMoviesGrid(searchResult: searchResult!)
                      : popularMovies != null
                          ? PopularMoviesList(movieModel: popularMovies!)
                          : const Center(
                              child: Text(
                                'Failed to load popular movies',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
            ),
          ],
        ),
      ),
    );
  }
}
