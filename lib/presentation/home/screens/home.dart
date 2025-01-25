import 'package:flutter/material.dart';
import 'package:movie_app/presentation/home/provider/movie_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/di/get_it.dart';
import '../widgets/carousel_list.dart';
import '../widgets/label_see_all.dart';
import '../widgets/popular_list.dart';
import '../widgets/top_rated_list.dart';
import '../widgets/upcoming_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final MovieProvider movieProvider;

  @override
  void initState() {
    super.initState();
    movieProvider = getIt<MovieProvider>();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        movieProvider
          ..getNowPlayingList()
          ..getPopularList()
          ..getTopRatedList()
          ..getUpcomingList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: movieProvider,
      child: Scaffold(
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
              const SliverToBoxAdapter(
                child: CarouselListWidget(),
              ),
              SliverToBoxAdapter(
                child: LabelSeeAll(
                  label: "Upcoming",
                  onTap: () {},
                ),
              ),
              const SliverToBoxAdapter(
                child: UpcomingListWidget(),
              ),
              SliverToBoxAdapter(
                child: LabelSeeAll(
                  label: "Popular",
                  onTap: () {},
                ),
              ),
              const SliverToBoxAdapter(
                child: PopularListWidget(),
              ),
              SliverToBoxAdapter(
                child: LabelSeeAll(
                  label: "Top Rated",
                  onTap: () {},
                ),
              ),
              const SliverToBoxAdapter(
                child: TopRatedListWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
