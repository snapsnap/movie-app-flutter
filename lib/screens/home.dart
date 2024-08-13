import 'package:flutter/material.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:movie_app/utils/config.dart';
import 'package:provider/provider.dart';

import '../widgets/card_movie.dart';
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              flexibleSpace: Container(
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
            SliverToBoxAdapter(
              child: LabelSeeAll(
                label: "Now Playing",
                onTap: () {},
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 250,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 10),
                  controller: ScrollController(),
                  scrollDirection: Axis.horizontal,
                  itemCount: movieProvider.nowPlayingList.length,
                  itemBuilder: (context, index) {
                    return CardMovie(
                      image:
                          "$assetURL${movieProvider.nowPlayingList[index].posterPath}",
                      title: "${movieProvider.nowPlayingList[index].title}",
                      rating: movieProvider.nowPlayingList[index].voteAverage!,
                      year: movieProvider.nowPlayingList[index].releaseDate!
                          .split("-")
                          .first,
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
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 10),
                  controller: ScrollController(),
                  scrollDirection: Axis.horizontal,
                  itemCount: movieProvider.nowPlayingList.length,
                  itemBuilder: (context, index) {
                    return CardMovie(
                      image:
                          "$assetURL${movieProvider.nowPlayingList[index].posterPath}",
                      title: "${movieProvider.nowPlayingList[index].title}",
                      rating: movieProvider.nowPlayingList[index].voteAverage!,
                      year: movieProvider.nowPlayingList[index].releaseDate!
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
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 10),
                  controller: ScrollController(),
                  scrollDirection: Axis.horizontal,
                  itemCount: movieProvider.nowPlayingList.length,
                  itemBuilder: (context, index) {
                    return CardMovie(
                      image:
                          "$assetURL${movieProvider.nowPlayingList[index].posterPath}",
                      title: "${movieProvider.nowPlayingList[index].title}",
                      rating: movieProvider.nowPlayingList[index].voteAverage!,
                      year: movieProvider.nowPlayingList[index].releaseDate!
                          .split("-")
                          .first,
                    );
                  },
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
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 10),
                  controller: ScrollController(),
                  scrollDirection: Axis.horizontal,
                  itemCount: movieProvider.nowPlayingList.length,
                  itemBuilder: (context, index) {
                    return CardMovie(
                      image:
                          "$assetURL${movieProvider.nowPlayingList[index].posterPath}",
                      title: "${movieProvider.nowPlayingList[index].title}",
                      rating: movieProvider.nowPlayingList[index].voteAverage!,
                      year: movieProvider.nowPlayingList[index].releaseDate!
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
