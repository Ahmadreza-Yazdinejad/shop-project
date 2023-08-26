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
        final _resposne = await _respository.getCommnetList(event.proudctId);
        emit(
          CommentGetData(_resposne),
        );
      },
    );
  }
}
