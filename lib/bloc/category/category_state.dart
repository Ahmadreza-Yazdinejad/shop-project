import 'package:dartz/dartz.dart';
import '../../../data/model/category.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryGetData extends CategoryState {
  Either<String, List<Categoryy>> list;
  CategoryGetData(this.list);
}
