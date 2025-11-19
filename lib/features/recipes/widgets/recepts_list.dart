import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_test_task/app/router/app_router.dart';
import 'package:recipes_test_task/core/components/cards/recept_card.dart';
import 'package:recipes_test_task/data/models/recipe/recipe.dart';
import 'package:recipes_test_task/features/recipes/provider/recipes_notifier.dart';
import 'package:recipes_test_task/features/recipes/provider/recipes_state.dart';

class ReceptsList extends ConsumerStatefulWidget {
  const ReceptsList({super.key});

  @override
  ConsumerState<ReceptsList> createState() => _ReceptsListState();
}

class _ReceptsListState extends ConsumerState<ReceptsList> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _controller.forward();

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.position.pixels;

    if (currentScroll >= (maxScroll * 0.8)) {
      ref.read(recipesNotifierProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final RecipesNotifier read = ref.read(recipesNotifierProvider.notifier);
    final RecipesState recipesState = ref.watch(recipesNotifierProvider);
    final recipes = recipesState.visibleRecepts;
    final goRouter = ref.read(routerProvider);

    return RefreshIndicator(
      onRefresh: () async {
        await read.getRecipes(needLoadingState: true);
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.fromLTRB(
          12,
          MediaQuery.viewPaddingOf(context).top + 16,
          12,
          MediaQuery.viewPaddingOf(context).bottom,
        ),
        itemCount: recipes.length,
        itemBuilder: (BuildContext context, int index) {
          final Recipe recipe = recipes[index];
          final bool isLast = index == recipes.length - 1;

          final Animation<Offset> slideAnimation =
              Tween<Offset>(
                begin: const Offset(0, -0.3),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Interval(
                    (index * 0.1).clamp(0.0, 1.0),
                    1.0,
                    curve: Curves.easeOutBack,
                  ),
                ),
              );

          return SlideTransition(
            position: slideAnimation,
            child: ReceptCard(
              onTap: () => goRouter.pushNamed(
                'recipeDetail',
                pathParameters: {'id': recipe.id},
                extra: recipe,
              ),
              imageUrl: recipe.image,
              title: recipe.title,
              description: recipe.text,
              isLastItem: isLast,
              prepTime: recipe.prepTime,
            ),
          );
        },
      ),
    );
  }
}
