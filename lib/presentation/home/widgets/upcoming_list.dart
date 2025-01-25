import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/config/env.dart';
import '../provider/movie_provider.dart';
import 'card_movie.dart';
import 'loading.dart';

class UpcomingListWidget extends StatelessWidget {
  const UpcomingListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, movieProvider, child) {
        if (movieProvider.upcomingStatus == UpcomingStatus.loading) {
          return const Loading();
        } else if (movieProvider.upcomingList.isEmpty) {
          return const Center(child: Text("No upcoming movies"));
        }

        return SizedBox(
          height: 250,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 10),
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            itemCount: movieProvider.upcomingList.length,
            itemBuilder: (context, index) {
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
