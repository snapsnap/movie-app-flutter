import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/core/di/get_it.dart';
import 'package:provider/provider.dart';

import '../../../core/config/env.dart';
import '../../../core/utils/custom_functions.dart';
import '../../home/widgets/loading.dart';
import '../provider/detail_movie_provider.dart';

class DetailMovie extends StatefulWidget {
  final String movieId;

  const DetailMovie({super.key, required this.movieId});

  @override
  State<DetailMovie> createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  late DetailMovieProvider detailMovieProvider;

  @override
  void initState() {
    super.initState();
    detailMovieProvider = getIt<DetailMovieProvider>();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        detailMovieProvider.getDetailMovie(movieId: widget.movieId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
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
                            const SizedBox(
                              width: 10,
                            ),
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
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 1,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          CustomFunctions().formatOneDecimal(
                                              data.voteAverage!),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
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
                                        const SizedBox(
                                          width: 5,
                                        ),
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
                                          padding: const EdgeInsets.all(1),
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
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.overview.toString()),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white10,
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
