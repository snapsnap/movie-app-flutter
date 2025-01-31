import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/utils/custom_extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/config/env.dart';
import '../provider/movie_provider.dart';
import 'carousel_home.dart';

class CarouselListWidget extends StatelessWidget {
  const CarouselListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, movieProvider, child) {
        final isShimmering =
            movieProvider.nowPlayingStatus == NowPlayingStatus.loading ||
                movieProvider.nowPlayingStatus == NowPlayingStatus.initial;

        return CarouselSlider.builder(
          carouselController: CarouselSliderController(),
          itemCount: isShimmering ? 3 : movieProvider.nowPlayingList.length,
          itemBuilder: (context, index, realIndex) {
            // Jika sedang shimmering, tampilkan skeleton loading
            if (isShimmering) {
              return const CarouselHome(
                image: "https://google.com/",
                title: "Loading...",
                rating: 0,
                year: "",
              ).shimmer(isEnabled: true);
            }

            // Pastikan list tidak kosong sebelum mengakses index
            if (movieProvider.nowPlayingList.isEmpty) {
              return const Center(child: Text("No now playing movies"));
            }
            final data = movieProvider.nowPlayingList[index];

            return CarouselHome(
              image: "${Env.assetURL}${data.backdropPath}",
              title: "${data.title}",
              rating: data.voteAverage!,
              year: data.releaseDate!.split("-").first,
            ).onTap(
              (context) => context.push("/detail/${data.id}"),
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
