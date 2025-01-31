import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/utils/custom_extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/config/env.dart';
import '../provider/movie_provider.dart';
import 'card_movie.dart';

class UpcomingListWidget extends StatelessWidget {
  const UpcomingListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, movieProvider, child) {
        final isShimmering =
            movieProvider.upcomingStatus == UpcomingStatus.loading ||
                movieProvider.upcomingStatus == UpcomingStatus.initial;

        return SizedBox(
          height: 250,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 10),
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            itemCount: isShimmering ? 5 : movieProvider.upcomingList.length,
            itemBuilder: (context, index) {
              // Jika sedang shimmering, tampilkan skeleton loading
              if (isShimmering) {
                return const CardMovie(
                  image: "",
                  title: "Loading...",
                  rating: 0,
                  year: "----",
                ).shimmer(isEnabled: true);
              }

              // Pastikan list tidak kosong sebelum mengakses index
              if (movieProvider.upcomingList.isEmpty) {
                return const Center(child: Text("No upcoming movies"));
              }
              final data = movieProvider.upcomingList[index];

              return CardMovie(
                image: "${Env.assetURL}${data.posterPath}",
                title: data.title ?? "",
                rating: data.voteAverage ?? 0,
                year: data.releaseDate?.split("-").first ?? "",
                onTap: () {
                  context.push("/detail/${data.id}");
                },
              );
            },
          ),
        );
      },
    );
  }
}
