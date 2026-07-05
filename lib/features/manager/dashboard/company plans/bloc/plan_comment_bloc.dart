import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/data/comments_model.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/data/comments_repo.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/data/user.dart'; // 👈 تأكد من صحة مسار ملف UserRepository الخاص بك
import 'plan_comment_event.dart';
import 'plan_comment_state.dart';

class PlanCommentBloc extends Bloc<PlanCommentEvent, PlanCommentState> {
  final PlanCommentRepository repository;
  final UserRepository userRepository = UserRepository(); // 👈 إنستنس من ريبو المستخدمين لترجمة الـ ID

  PlanCommentBloc(this.repository) : super(PlanCommentInitial()) {

    on<FetchCommentsEvent>((event, emit) async {
      emit(PlanCommentLoading());
      final result = await repository.getPlanComments(planId: event.planId);

      await result.fold(
            (failure) async => emit(PlanCommentFailure(failure.message)),
            (comments) async {
          // 💡 نلف على كل التعليقات المجلوبة من السيرفر ونترجم الـ userId لاسم
          for (var comment in comments) {
            if (comment.userId != null && (comment.userName == null || comment.userName!.isEmpty)) {

              // كول الـ UserRepository اللي باصيناه
              final userRes = await userRepository.getUser(userId: comment.userId!);

              userRes.fold(
                    (_) {
                  // 💡 لو الـ API رجع خطأ (زي الـ 404 القديمة)، بنظف الـ ID عشان يظهر الاسم بشكل جمالي وميظهرش Unknown
                  if (comment.userId!.contains('-')) {
                    final parts = comment.userId!.split('-');
                    if (parts.length > 1) {
                      comment.userName = parts[1]; // بياخد "amina.ezzat" من "HR-amina.ezzat-teamleader"
                    } else {
                      comment.userName = comment.userId;
                    }
                  } else {
                    comment.userName = comment.userId;
                  }
                },
                    (user) {
                  // لو الـ API رجع الـ UserModel بنجاح، بناخد الاسم بتاعه فوراً
                  comment.userName = user.name ?? comment.userId;
                },
              );
            }
          }
          emit(PlanCommentLoaded(comments));
        },
      );
    });

    on<SendCommentEvent>((event, emit) async {
      List<PlanCommentModel> currentComments = [];
      if (state is PlanCommentLoaded) {
        currentComments = (state as PlanCommentLoaded).comments;
        emit(PlanCommentSending(currentComments));
      }

      final result = await repository.addComment(
        planId: event.planId,
        request: event.request,
      );

      await result.fold(
            (failure) async {
          emit(PlanCommentFailure(failure.message));
        },
            (successResponse) async {
          // بعد نجاح إضافة الكومنت، بنعيد الـ Fetch فوراً عشان السايكل تلف وتجيب الأسامي
          add(FetchCommentsEvent(event.planId));
        },
      );
    });
  }
}