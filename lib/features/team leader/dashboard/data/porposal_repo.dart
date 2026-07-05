import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/network/api_service.dart';
import 'package:recomind/features/team%20leader/dashboard/data/porposal_model.dart';

class ProposalRepository {
  final ApiServicepublic _apiServiceTeam = ApiServicepublic();

  /// جلب قائمة المقترحات بناءً على الـ Endpoint الموضحة في الاسكرين شوت بالظبط
  Future<dynamic> getProposals() async {
    try {
      // استخدام نفس المسار والـ Query Params الموضحة بصورة البوستمان
      final response = await _apiServiceTeam.get('/api/ValidationReport/sent?limit=6');

      if (response is ApiError) {
        return response;
      }

      // تحويل الاستجابة باستخدام الدالة المرنة الجديدة التي تدعم كلا الشكلين (List / Map)
      final List<ProposalModel> proposals = ProposalModel.fromResponse(response);

      return proposals;
    } catch (e) {
      return ApiError(
        message: 'Parsing Error: Failed to handle proposals response data.',
        data: e,
      );
    }
  }

  /// single one
  /// جلب تفاصيل تقرير تحقق محدد باستخدام المعرف الخاص به
  Future<dynamic> fetchReportDetails(String reportId) async {
    try {
      final response = await _apiServiceTeam.get('/api/ValidationReport/get/$reportId');

      if (response is ApiError) {
        return response;
      }

      if (response is Map<String, dynamic>) {
        return ValidationReportModel.fromJson(response);
      } else {
        return ApiError(
          message: 'Unexpected response format: Expected an Object.',
        );
      }
    } catch (e) {
      return ApiError(
        message: 'Parsing Error: Failed to handle validation report data.',
        data: e,
      );
    }
  }
  /// approve & reject
  Future<dynamic> updateReportStatus(UpdateReportStatusRequestModel requestModel) async {
    try {
      final response = await _apiServiceTeam.patch(
        '/api/ValidationReport/update',
        requestModel.toJson(),
      );

      if (response is ApiError) {
        return response;
      }

      return response;
    } catch (e) {
      return ApiError(
        message: 'Parsing Error: Failed to update report status.',
        data: e,
      );
    }
  }
}