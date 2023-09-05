import 'package:apple_shop/data/datasource/commnet_datasource.dart';
import 'package:apple_shop/data/model/commet.dart';
import 'package:dartz/dartz.dart';

import '../../utility/Errors/api_exception.dart';

abstract class ICommnetRespository {
  Future<Either<String, List<Comment>>> getCommnetList(String productId);
  Future<Either<String, String>> getCommentPost(
      String productId, String comment);
}

class CommentRespository extends ICommnetRespository {
  final ICommnetDataSource _dataSource;
  CommentRespository(this._dataSource);
  @override
  Future<Either<String, List<Comment>>> getCommnetList(String productId) async {
    try {
      var resposne = await _dataSource.getCommentList(productId);
      return right(resposne);
    } on ApiException {
      return left('خطایی رخ داد');
    } catch (ex) {
      return left('خطایی رخ داد');
    }
  }

  @override
  Future<Either<String, String>> getCommentPost(
      String productId, String comment) async {
    try {
      await _dataSource.commentPost(comment, productId);
      return right('نظر شما با موفقیت ثبت شد');
    } on ApiException {
      return left('مشکلی در ثبت نظر به وجود آمده');
    } catch (ex) {
      return left('مشکلی در ثبت نظر به وجود آمده');
    }
  }
}
