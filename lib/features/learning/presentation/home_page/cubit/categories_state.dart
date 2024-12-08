part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesStatePageLoading extends CategoriesState {}

final class CategoriesStateCategories extends CategoriesState {
  final List<CategoryEntity> categories;

  CategoriesStateCategories(this.categories);
}
