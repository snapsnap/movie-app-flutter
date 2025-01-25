import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/config/env.dart';
import '../provider/movie_provider.dart';
import 'carousel_home.dart';
import 'loading.dart';

class CarouselListWidget extends StatelessWidget {
  const CarouselListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, movieProvider, child) {
        if (movieProvider.nowPlayingStatus == NowPlayingStatus.loading) {
          return const Loading();
        } else if (movieProvider.nowPlayingList.isEmpty) {
          return const Center(child: Text("No now playing movies"));
        }

        return CarouselSlider.builder(
          carouselController: CarouselSliderController(),
          itemCount: movieProvider.nowPlayingList.length,
          itemBuilder: (context, index, realIndex) {
            final data = movieProvider.nowPlayingList[index];

            return CarouselHome(
              image: "${Env.assetURL}${data.backdropPath}",
              title: "${data.title}",
              rating: data.voteAverage!,
              year: data.releaseDate!.split("-").first,
            );
          },
          options: CarouselOptions(
            aspectRatio: 16 / 9,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            enableInfiniteScroll: true,
            scrollDirection: Axis.horizontal,
            viewportFraction: 0.9,
            disableCenter: true,
          ),
        );
      },
    );
  }
}
