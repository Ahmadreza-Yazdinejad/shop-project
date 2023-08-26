import 'package:apple_shop/data/model/commet.dart';
import 'package:dartz/dartz.dart';

abstract class CommentState {}

class CommentInialize extends CommentState {}

class CommnetLoading extends CommentState {}

class CommentGetData extends CommentState {
  Either<String, List<Comment>> getCommnetList;
  CommentGetData(this.getCommnetList);
}
