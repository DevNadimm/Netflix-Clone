import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/models/popular_movie_model.dart';
import 'package:netflix_clone/models/search_model.dart';
import 'package:netflix_clone/services/api_services.dart';
import 'package:netflix_clone/views/widgets/popular_movies_list.dart';
import 'package:netflix_clone/views/widgets/search_movies_grid.dart';

class SearchScreen extends StatefulWidget {
  final bool isBackButtonShow;

  const SearchScreen({super.key, this.isBackButtonShow = false});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  final ApiServices apiServices = ApiServices();
  SearchModel? searchResult;
  PopularMovieModel? popularMovies;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPopularMovies();
    searchController.addListener(_onSearchChanged);
  }

  Future<void> _fetchPopularMovies() async {
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

  Future<void> _performSearch(String query) async {
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
            _buildSearchField(),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          if (widget.isBackButtonShow)
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          Expanded(
            child: CupertinoSearchTextField(
              padding: const EdgeInsets.all(10),
              controller: searchController,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return const Expanded(
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }

    if (searchResult != null) {
      if (searchResult!.results.isEmpty) {
        return const Expanded(
          child: Center(
            child: Text(
              'No results found',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      } else {
        return Expanded(
          child: SearchMoviesGrid(searchResult: searchResult!),
        );
      }
    }

    if (popularMovies != null) {
      return Expanded(
        child: PopularMoviesList(popularMovies: popularMovies!),
      );
    }

    return const Expanded(
      child: Center(
        child: Text(
          'Failed to load popular movies',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
