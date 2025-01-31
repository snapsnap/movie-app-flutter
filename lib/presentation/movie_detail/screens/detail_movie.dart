import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/core/utils/custom_extensions.dart';
import 'package:provider/provider.dart';

import '../../../core/config/env.dart';
import '../../../core/utils/custom_functions.dart';
import '../../home/widgets/loading.dart';
import '../provider/detail_movie_provider.dart';

class DetailMovie extends StatelessWidget {
  const DetailMovie({super.key});

  @override
  Widget build(BuildContext context) {
    final detailMovieProvider = Provider.of<DetailMovieProvider>(context);

    return ChangeNotifierProvider.value(
      value: detailMovieProvider,
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: SafeArea(
          child: Consumer<DetailMovieProvider>(
            builder: (context, detailMovieProvider, child) {
              if (detailMovieProvider.detailMovieStatus ==
                  DetailMovieStatus.loading) {
                return const Loading();
              } else if (detailMovieProvider.detailMovie.id == null) {
                return const Center(child: Text("Something went wrong..."));
              }
              if (detailMovieProvider.detailMovieStatus ==
                  DetailMovieStatus.success) {
                final data = detailMovieProvider.detailMovie;
                final genres = data.genres ?? [];

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.network(
                        "${Env.assetURL}${data.backdropPath}",
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                              child: Text("No Image Available"));
                        },
                      ),
                      10.spacing,
                      Padding(
                        padding: 10.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: 5.brc,
                              ),
                              child: ClipRRect(
                                borderRadius: 5.brc,
                                child: Image.network(
                                  "${Env.assetURL}${data.posterPath}",
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                        child: Text("No Image Available"));
                                  },
                                ),
                              ),
                            ),
                            10.spacing,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.title.toString(),
                                    style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.fontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: [1, 5].es,
                                    child: Row(
                                      children: [
                                        Text(
                                          CustomFunctions().formatOneDecimal(
                                              data.voteAverage!),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        5.spacing,
                                        RatingBar.builder(
                                          ignoreGestures: true,
                                          initialRating:
                                              data.voteAverage! / 10 * 5,
                                          minRating: 1,
                                          maxRating: 10,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemSize: 10,
                                          itemCount: 5,
                                          itemBuilder: (context, _) {
                                            return const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            );
                                          },
                                          onRatingUpdate: (rating) {},
                                        ),
                                        5.spacing,
                                        Text(
                                          "( ${CustomFunctions().formatOneDecimal(double.parse(data.voteCount!.toString()))} )",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Wrap(
                                    spacing: 3.0,
                                    runSpacing: -3,
                                    children: genres.map(
                                      (genre) {
                                        return Chip(
                                          padding: 1.ea,
                                          label: Text(genre.name ?? "-"),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.spacing,
                      Padding(
                        padding: 10.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.overview.toString()),
                            8.spacing,
                            Container(
                              padding: 10.ea,
                              decoration: BoxDecoration(
                                borderRadius: 10.brc,
                                // color: Colors.white10,
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.3)),
                              ),
                              child: Center(
                                child: Text(
                                  data.tagline.toString(),
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
