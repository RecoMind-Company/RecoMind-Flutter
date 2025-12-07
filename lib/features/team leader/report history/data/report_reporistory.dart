import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/network/api_exceptions.dart';
import 'package:recomind/core/network/api_service.dart';
import 'package:recomind/features/team%20leader/report%20history/data/report_model.dart';

class reportRepo{
  ApiServiceReport apiServiceReport = ApiServiceReport();

  /// send request
  Future<CreateReportTaskModel> getSetup()async{
    try{
      final response = await apiServiceReport.post("/teams", {});
      return CreateReportTaskModel.fromJson(response);
  }on DioError catch(e){
      throw ApiException.handleError(e);
    }catch (e){
      throw ApiError(message: e.toString());
    }
    }


    ///get report
  Future<TaskStatusResponse> getReportResult(String taskID) async {
    try {
      final response = await apiServiceReport.get(
          "/teams/wewewe?taskId=${taskID}");
      print("Raw response: ${response}"); // Debug
      print("Response data: ${response.data}");
      print("Response statusCode: ${response.statusCode}");

      if (response is ApiError) {
        throw response;
      }
      final user = TaskStatusResponse.fromJson(response["data"]);
      return user;
    } on DioError catch (e) {
      throw ApiException.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}