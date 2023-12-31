import 'package:apple_shop/bloc/commnets/commnet.event.dart';
import 'package:apple_shop/bloc/commnets/commnet_state.dart';
import 'package:apple_shop/data/repository/comment_respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ICommnetRespository _respository;
  CommentBloc(this._respository) : super(CommentInialize()) {
    on<CommnetInitializeEvent>(
      (event, emit) async {
        emit(CommnetLoading());
        final resposne = await _respository.getCommnetList(event.proudctId);
        emit(
          CommentGetData(resposne),
        );
      },
    );
    on<CommentPost>(
      (event, emit) async {
        emit(CommnetLoading());
        await _respository.getCommentPost(event.productId, event.comment);
        final resposne = await _respository.getCommnetList(event.productId);
        emit(CommentGetData(resposne));
      },
    );
  }
}
