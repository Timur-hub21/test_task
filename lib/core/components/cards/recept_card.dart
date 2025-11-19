import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:recipes_test_task/core/themes/app_colors.dart';

class ReceptCard extends StatelessWidget {
  final VoidCallback onTap;
  final String imageUrl;
  final String title;
  final String description;
  final String? prepTime;
  final bool isLastItem;

  const ReceptCard({
    required this.onTap,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.isLastItem,
    this.prepTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            maxLines: 2,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall?.color,
              fontSize: 24,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 300,
            width: MediaQuery.sizeOf(context).width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: 300,
                    width: MediaQuery.sizeOf(context).width,
                    fit: BoxFit.cover,
                    placeholder: (BuildContext context, String url) => SizedBox(
                      height: 300,
                      width: MediaQuery.sizeOf(context).width,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => SizedBox(
                      height: 300,
                      width: MediaQuery.sizeOf(context).width,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 60),
                            Icon(
                              Icons.broken_image,
                              size: 50,
                              color: AppColors.error,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Не удалось загрузить изображение',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodySmall?.color,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary),
                      child: SizedBox(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                description,
                                maxLines: 2,
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.bodySmall?.color,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                  height: 1.1,
                                ),
                              ),
                              if (prepTime != null && (prepTime?.isNotEmpty ?? false)) ...<Widget>[
                                Spacer(),
                                Text(
                                  'Время на приготовление: $prepTime',
                                  style: TextStyle(
                                    color: Theme.of(context).textTheme.bodySmall?.color,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                    height: 1.1,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isLastItem) const SizedBox(height: 16),
        ],
      ),
    );
  }
}
