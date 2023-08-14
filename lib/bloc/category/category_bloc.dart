import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/category_respository.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryRepository _categoryRepository;
  CategoryBloc(this._categoryRepository) : super(CategoryInitial()) {
    on<CategoryRequiestList>(
      (event, emit) async {
        emit(CategoryLoading());
        var resonse = await _categoryRepository.categoryList();
        emit(
          CategoryGetData(resonse),
        );
      },
    );
  }
}
