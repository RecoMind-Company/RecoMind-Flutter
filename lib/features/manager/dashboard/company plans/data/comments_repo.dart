import 'package:dartz/dartz.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/network/api_service.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/data/comments_model.dart';

class PlanCommentRepository {
  // استخدام الخدمة العامة المتوافقة مع الـ baseUrl الخاص بك
  final ApiServicepublic _apiService = ApiServicepublic();

  /// 1. إضافة تعليق جديد لخطة معينة
  /// POST: /api/PlanComment/:planId/add-plan
  Future<Either<ApiError, dynamic>> addComment({
    required String planId,
    required AddCommentRequest request,
  }) async {
    try {
      final response = await _apiService.post(
        '/api/PlanComment/$planId/add-plan',
        request.toJson(),
      );
      print("this is response /// ${response}");
      return Right<ApiError, dynamic>(response);
    } catch (e) {
      if (e is ApiError) {
        return Left<ApiError, dynamic>(e);
      }
      return Left<ApiError, dynamic>(ApiError(message: e.toString()));
    }
  }

  /// 2. جلب جميع التعليقات الخاصة بخطة معينة
  /// GET: /api/PlanComment/:planId/plan-all
  Future<Either<ApiError, List<PlanCommentModel>>> getPlanComments({
    required String planId,
  }) async {
    try {
      final response = await _apiService.get(
        '/api/PlanComment/$planId/plan-all',
      );

      if (response is List) {
        final comments = response
            .map((json) => PlanCommentModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right<ApiError, List<PlanCommentModel>>(comments);
      } else if (response is Map<String, dynamic> && response['data'] is List) {
        final comments = (response['data'] as List)
            .map((json) => PlanCommentModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return Right<ApiError, List<PlanCommentModel>>(comments);
      }

      return Right<ApiError, List<PlanCommentModel>>([]);
    } catch (e) {
      if (e is ApiError) {
        return Left<ApiError, List<PlanCommentModel>>(e);
      }
      return Left<ApiError, List<PlanCommentModel>>(ApiError(message: e.toString()));
    }
  }
}