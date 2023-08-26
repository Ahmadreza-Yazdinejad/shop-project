abstract class CommentEvent {}

class CommnetInitializeEvent extends CommentEvent {
  String proudctId;
  CommnetInitializeEvent(this.proudctId);
}
