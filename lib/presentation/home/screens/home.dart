import 'package:flutter/material.dart';
import 'package:movie_app/core/config/theme/colors.dart';
import 'package:movie_app/presentation/home/provider/movie_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/carousel_list.dart';
import '../widgets/label_see_all.dart';
import '../widgets/popular_list.dart';
import '../widgets/top_rated_list.dart';
import '../widgets/upcoming_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return RefreshIndicator.adaptive(
      onRefresh: () => movieProvider.refreshPage(),
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
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
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: warningColor),
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
                  label: "Upcoming Movies",
                  onTap: () {},
                ),
              ),
              const SliverToBoxAdapter(
                child: UpcomingListWidget(),
              ),
              SliverToBoxAdapter(
                child: LabelSeeAll(
                  label: "Popular Movies",
                  onTap: () {},
                ),
              ),
              const SliverToBoxAdapter(
                child: PopularListWidget(),
              ),
              SliverToBoxAdapter(
                child: LabelSeeAll(
                  label: "Top Rated Movies",
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
