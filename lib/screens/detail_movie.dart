import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movie_provider.dart';

class DetailMovie extends StatefulWidget {
  final String movieId;

  const DetailMovie({super.key, required this.movieId});

  @override
  State<DetailMovie> createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  @override
  void initState() {
    super.initState();
    debugPrint("id: ${widget.movieId}");
    Provider.of<MovieProvider>(context, listen: false)
        .getDetailMovie(movieId: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    );
  }
}
