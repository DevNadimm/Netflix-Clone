import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  late SearchModel searchModel;

  void onSearch(String query) {
    apiServices.getSearchedMovies(query).then(
          (results) {
        setState(
              () {
            searchModel = results;
          },
        );
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
        child: Padding(
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
      ),
    );
  }
}