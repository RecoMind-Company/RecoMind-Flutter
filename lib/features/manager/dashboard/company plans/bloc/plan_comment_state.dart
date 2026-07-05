import 'package:recomind/features/manager/dashboard/company%20plans/data/comments_model.dart';

abstract class PlanCommentState {}

class PlanCommentInitial extends PlanCommentState {}

// حالة تحميل التعليقات من السيرفر
class PlanCommentLoading extends PlanCommentState {}

// حالة نجاح جلب التعليقات وعرضها
class PlanCommentLoaded extends PlanCommentState {
  final List<PlanCommentModel> comments;
  PlanCommentLoaded(this.comments);
}

// حالة حدوث خطأ أثناء جلب التعليقات
class PlanCommentFailure extends PlanCommentState {
  final String errorMessage;
  PlanCommentFailure(this.errorMessage);
}

// حالة فرعية اختيارية عند إرسال تعليق جديد (عشان لو حابب تعرض مؤشر تحميل صغير جنب زر الإرسال)
class PlanCommentSending extends PlanCommentState {
  final List<PlanCommentModel> currentComments;
  PlanCommentSending(this.currentComments);
}