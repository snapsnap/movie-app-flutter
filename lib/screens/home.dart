import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:movie_app/utils/config.dart';
import 'package:provider/provider.dart';

import '../widgets/card_movie.dart';
import '../widgets/carousel_home.dart';
import '../widgets/label_see_all.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<MovieProvider>(context, listen: false).getNowPlayingList();
        Provider.of<MovieProvider>(context, listen: false).getPopularList();
        Provider.of<MovieProvider>(context, listen: false).getTopRatedList();
        Provider.of<MovieProvider>(context, listen: false).getUpcomingList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              flexibleSpace: Container(
                color: Colors.black,
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 30,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: const SearchBar(
                        elevation: WidgetStatePropertyAll(0),
                        hintText: "search movie here",
                        hintStyle: WidgetStatePropertyAll(TextStyle(
                          letterSpacing: 0,
                          fontSize: 13,
                        )),
                        leading: Icon(
                          Icons.search_rounded,
                          applyTextScaling: true,
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.person,
                        applyTextScaling: true,
                      ),
                    )
                  ],
                ),
              ),
            ),
            // SliverToBoxAdapter(
            //   child: LabelSeeAll(
            //     label: "Now Playing",
            //     onTap: () {},
            //   ),
            // ),
            SliverToBoxAdapter(
              child: movieProvider.isLoading
                  ? const SizedBox(
                      height: 150,
                      child: Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  : CarouselSlider.builder(
                      carouselController: CarouselSliderController(),
                      itemCount: movieProvider.nowPlayingList.length,
                      itemBuilder: (context, index, realIndex) {
                        return CarouselHome(
                          image:
                              "$assetURL${movieProvider.nowPlayingList[index].backdropPath}",
                          title: "${movieProvider.nowPlayingList[index].title}",
                          rating:
                              movieProvider.nowPlayingList[index].voteAverage!,
                          year: movieProvider.nowPlayingList[index].releaseDate!
                              .split("-")
                              .first,
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
                    ),
            ),
            SliverToBoxAdapter(
              child: LabelSeeAll(
                label: "Upcoming",
                onTap: () {},
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 250,
                child: movieProvider.isLoading
                    ? const Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(left: 10),
                        controller: ScrollController(),
                        scrollDirection: Axis.horizontal,
                        itemCount: movieProvider.upcomingList.length,
                        itemBuilder: (context, index) {
                          return CardMovie(
                            image:
                                "$assetURL${movieProvider.upcomingList[index].posterPath}",
                            title: "${movieProvider.upcomingList[index].title}",
                            rating:
                                movieProvider.upcomingList[index].voteAverage!,
                            year: movieProvider.upcomingList[index].releaseDate!
                                .split("-")
                                .first,
                            onTap: () {
                              context.push(
                                "/detail/${movieProvider.upcomingList[index].id}",
                              );
                            },
                          );
                        },
                      ),
              ),
            ),
            SliverToBoxAdapter(
              child: LabelSeeAll(
                label: "Popular",
                onTap: () {},
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 250,
                child: movieProvider.isLoading
                    ? const Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(left: 10),
                        controller: ScrollController(),
                        scrollDirection: Axis.horizontal,
                        itemCount: movieProvider.popularList.length,
                        itemBuilder: (context, index) {
                          return CardMovie(
                            image:
                                "$assetURL${movieProvider.popularList[index].posterPath}",
                            title: "${movieProvider.popularList[index].title}",
                            rating:
                                movieProvider.popularList[index].voteAverage!,
                            year: movieProvider.popularList[index].releaseDate!
                                .split("-")
                                .first,
                          );
                        },
                      ),
              ),
            ),
            SliverToBoxAdapter(
              child: LabelSeeAll(
                label: "Top Rated",
                onTap: () {},
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 250,
                child: movieProvider.isLoading
                    ? const Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(left: 10),
                        controller: ScrollController(),
                        scrollDirection: Axis.horizontal,
                        itemCount: movieProvider.topRatedList.length,
                        itemBuilder: (context, index) {
                          return CardMovie(
                            image:
                                "$assetURL${movieProvider.topRatedList[index].posterPath}",
                            title: "${movieProvider.topRatedList[index].title}",
                            rating:
                                movieProvider.topRatedList[index].voteAverage!,
                            year: movieProvider.topRatedList[index].releaseDate!
                                .split("-")
                                .first,
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
