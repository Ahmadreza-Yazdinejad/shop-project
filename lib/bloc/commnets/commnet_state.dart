import 'package:apple_shop/data/model/commet.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class CommentState {}

class CommentInialize extends CommentState {}

class CommnetLoading extends CommentState {}

class CommentGetData extends CommentState {
  Either<String, List<Comment>> getCommnetList;
  CommentGetData(this.getCommnetList);
}

class CommentLoadingPost extends CommentState {
  Widget x() {
    return const CircularProgressIndicator();
  }
}

class CommentReponse extends CommentState {
  Either<String, String> commnetPost;
  CommentReponse(this.commnetPost);
}
