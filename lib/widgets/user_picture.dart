import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserPicture extends StatelessWidget {
  const UserPicture({
    super.key,
    required this.image,
    required this.height,
    this.isOutLined,
  });

  final String image;
  final double height;
  final bool? isOutLined;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: AspectRatio(
        aspectRatio: 1,
        child: CircleAvatar(
          backgroundColor: isOutLined ?? false
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(2.5),
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipOval(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: image,
                  placeholder: (context, url) => Image.asset(
                    'assets/person.jpg',
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, error, stackTrace) => Image.asset(
                    'assets/person.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
