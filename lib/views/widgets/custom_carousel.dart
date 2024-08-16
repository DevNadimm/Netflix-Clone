import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/models/tv_series_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomCarousel extends StatelessWidget {
  final Future<TvSeriesModel> future;
  final double height;

  const CustomCarousel({super.key, required this.future, required this.height});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TvSeriesModel>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Something went wrong. Please try again later.',
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        } else if (snapshot.hasData) {
          final tvSeries = snapshot.data!;
          return _buildCarousel(tvSeries);
        } else {
          return const Center(
            child: Text('No TV series available.'),
          );
        }
      },
    );
  }

  Widget _buildCarousel(TvSeriesModel tvSeries) {
    const String baseUrl = 'https://image.tmdb.org/t/p/w500';

    return CarouselSlider.builder(
      itemCount: tvSeries.results.length,
      itemBuilder: (context, index, realIndex) {
        final series = tvSeries.results[index];
        final String imageUrl = '$baseUrl${series.posterPath}';

        return _buildCarouselItem(series.name, imageUrl);
      },
      options: CarouselOptions(
        height: height * 0.33,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 9 / 16,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(seconds: 1),
        viewportFraction: 0.45,
      ),
    );
  }

  Widget _buildCarouselItem(String title, String imageUrl) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text('Image load error'),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
