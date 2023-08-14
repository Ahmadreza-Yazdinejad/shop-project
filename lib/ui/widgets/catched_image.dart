import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CatchImage extends StatelessWidget {
  final String image;
  final double radius;
  const CatchImage({super.key, required this.image, this.radius = 0});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => Container(
          color: Colors.red,
        ),
        placeholder: (context, url) => Container(
          color: Colors.grey,
        ),
      ),
    );
  }
}
