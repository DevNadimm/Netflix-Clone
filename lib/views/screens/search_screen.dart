import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:netflix_clone/models/search_model.dart';
import 'package:netflix_clone/services/api_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ApiServices apiServices = ApiServices();
  SearchModel? searchResult;

  void onSearch(String query) {
    apiServices.getSearchedMovies(query).then(
      (results) {
        setState(() {
          searchResult = results;
        });
      },
    );
  }

  @override
  void dispose() {
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
                padding: EdgeInsets.all(10),
                controller: searchController,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  onSearch(searchController.text.trim());
                },
              ),
            ),
            if (searchResult == null)
              Center(
                child: Text('Search for movies',
                    style: TextStyle(color: Colors.white)),
              )
            else if (searchResult!.results.isEmpty)
              Center(
                child: Text('No results found',
                    style: TextStyle(color: Colors.white)),
              )
            else
              Expanded(
                child: GridView.builder(
                  itemCount: searchResult!.results.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: .7,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    final result = searchResult!.results[index];
                    final posterUrl = result.posterPath != null
                        ? 'https://image.tmdb.org/t/p/w500${result.posterPath}'
                        : null; // Set to null if posterPath is not available

                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  posterUrl ?? 'assets/logo/netflix_logo.png',
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
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
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  result.title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
