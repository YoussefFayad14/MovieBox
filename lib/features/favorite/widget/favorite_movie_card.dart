import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../data/model/movie.dart';

class FavoriteMovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const FavoriteMovieCard({
    super.key,
    required this.movie,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: movie.image,
            width: 50,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Text(
            movie.title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Row(
            children: [
              const Icon(Icons.star, size: 16, color: Colors.amber),
              const SizedBox(width: 4),
              Text(
                movie.rating.toStringAsFixed(1),
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
