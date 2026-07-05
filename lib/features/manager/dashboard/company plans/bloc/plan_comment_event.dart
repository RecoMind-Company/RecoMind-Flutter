import 'package:recomind/features/manager/dashboard/company%20plans/data/comments_model.dart';

abstract class PlanCommentEvent {}

class FetchCommentsEvent extends PlanCommentEvent {
  final String planId;
  FetchCommentsEvent(this.planId);
}

class SendCommentEvent extends PlanCommentEvent {
  final String planId;
  final AddCommentRequest request;
  SendCommentEvent({required this.planId, required this.request});
}