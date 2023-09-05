abstract class CommentEvent {}

class CommnetInitializeEvent extends CommentEvent {
  String proudctId;
  CommnetInitializeEvent(this.proudctId);
}

class CommentPost extends CommentEvent {
  String comment;
  String productId;
  CommentPost(this.comment, this.productId);
}
