import 'package:flutter/material.dart';
import 'package:netflix_clone/models/movie_model.dart';
import 'package:netflix_clone/services/api_services.dart';
import 'package:netflix_clone/views/widgets/movie_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<MovieModel> upcomingMovies;
  late Future<MovieModel> nowPlayingMovies;
  ApiServices apiServices = ApiServices();

  @override
  void initState() {
    upcomingMovies = apiServices.getUpcomingMovies();
    nowPlayingMovies = apiServices.getNowPlayingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/logo/netflix_logo.png",
          height: 50,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search_rounded),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              color: Colors.blue,
              height: 27,
              width: 27,
              child: Center(
                child: Icon(Icons.person, color: Colors.white, size: 16),
              ),
            ),
          ),
          SizedBox(width: 20),
        ],
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MovieCardWidget(
              future: upcomingMovies,
              headLineText: 'Upcoming Movies',
            ),
            SizedBox(height: 25,),
            MovieCardWidget(
              future: nowPlayingMovies,
              headLineText: 'Now Playing',
            ),
          ],
        ),
      ),
    );
  }
}
