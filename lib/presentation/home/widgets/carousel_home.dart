import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/core/utils/custom_extensions.dart';

import '../../../core/utils/custom_functions.dart';

class CarouselHome extends StatelessWidget {
  final String title;
  final double rating;
  final String year;
  final String image;

  const CarouselHome({
    super.key,
    required this.title,
    required this.rating,
    required this.year,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 5.ea,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: 10.brc,
            ),
            child: ClipRRect(
              borderRadius: 10.brc,
              child: Image.network(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container();
                },
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: 10.ea,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.only(
                    bottomLeft: 10.rc,
                    bottomRight: 10.rc,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          CustomFunctions().formatOneDecimal(rating),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        5.spacing,
                        Expanded(
                          child: RatingBar.builder(
                            ignoreGestures: true,
                            initialRating: rating / 10 * 5,
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
                            unratedColor: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      year,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    10.spacing,
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
