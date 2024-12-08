import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:litlearn/core/entity/category_entity.dart';
import 'package:litlearn/features/learning/domain/usecases/get_categories.dart';
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final UseCaseGetCategories _useCaseGetCategories;

  CategoriesCubit({
    required UseCaseGetCategories useCaseGetCategories,
  })  : _useCaseGetCategories = useCaseGetCategories,
        super(CategoriesInitial());

  Future getCategories() async {
    emit(CategoriesStatePageLoading());

    final response = await _useCaseGetCategories(UseCaseGetCategoriesParams());

    response.fold(
      (l) {
        log(l.message);
      },
      (r) {
        List<CategoryEntity> categories = [
          CategoryEntity(text: 'Top Rated', icon: 'https://www.svgrepo.com/show/503113/trend.svg', value: ''),
          ...r
        ];

        emit(CategoriesStateCategories(categories));
      },
    );
  }
}
