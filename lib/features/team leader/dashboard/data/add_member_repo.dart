import 'package:dartz/dartz.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/network/api_service.dart';
import 'package:recomind/features/team%20leader/dashboard/data/add_member_model.dart';

class TeamRepository {
  final ApiServicepublic _apiService = ApiServicepublic();

  /// جلب قائمة الموظفين كاملة ببياناتهم بعد عمل Loop على الـ IDs
  Future<Either<ApiError, List<TeamMemberModel>>> getTeamMembersFullData() async {
    try {
      // 1️⃣ خطوة أولى: جلب قائمة الـ IDs من الـ Endpoint الأولى
      final responseIds = await _apiService.get('/api/Team/team-employees');

      if (responseIds is ApiError) {
        return Left<ApiError, List<TeamMemberModel>>(responseIds);
      }

      if (responseIds is List) {
        // تحويل النتيجة لـ List<String> تحتوي على الـ IDs
        List<String> employeeIds = responseIds.map((id) => id.toString()).toList();

        // 2️⃣ خطوة ثانية: عمل Loop ذكي ومتوازي (Parallel) لجلب تفاصيل كل موظف
        // استخدمنا Future.wait عشان ينفذ كل الـ Requests مع بعض في نفس الوقت بدل ما ينتظر واحد واحد
        final futures = employeeIds.map((id) => _fetchSingleMemberDetails(id));
        final results = await Future.wait(futures);

        // تصفية العناصر الناجحة فقط واستبعاد الـ null (التي قد تفشل بسبب 404 أو غيره)
        List<TeamMemberModel> fullTeamList = results
            .where((member) => member != null)
            .cast<TeamMemberModel>()
            .toList();

        return Right<ApiError, List<TeamMemberModel>>(fullTeamList);
      }

      return Left<ApiError, List<TeamMemberModel>>(
        ApiError(message: "Unexpected response format from team employees API"),
      );
    } catch (e) {
      if (e is ApiError) {
        return Left<ApiError, List<TeamMemberModel>>(e);
      }
      return Left<ApiError, List<TeamMemberModel>>(ApiError(message: e.toString()));
    }
  }

  /// دالة مساعدة داخلية لجلب بيانات موظف واحد وعمل Catch للخطأ محلياً حتى لا يوقف الـ Loop بالكامل
  Future<TeamMemberModel?> _fetchSingleMemberDetails(String userId) async {
    try {
      final response = await _apiService.get('/api/users/getJobTitle/$userId');

      if (response is Map<String, dynamic>) {
        return TeamMemberModel.fromJson(response);
      }
      return null;
    } catch (_) {
      // لو ضرب 404 أو أي خطأ لموظف معين، بنرجع كائن وهمي نظيف بالـ ID عشان الـ UI ميعلقش
      return TeamMemberModel(
        userId: userId,
        userName: userId.contains('-') ? userId.split('-')[1] : userId,
        jobTitle: "Team Member",
      );
    }
  }
}