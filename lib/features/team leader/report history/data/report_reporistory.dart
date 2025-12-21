import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/network/api_exceptions.dart';
import 'package:recomind/core/network/api_service.dart';
import 'package:recomind/features/team%20leader/report%20history/data/report_model.dart';

class reportRepo{
  ApiServiceReport apiServiceReport = ApiServiceReport();

  /// send request
  Future<CreateReportTaskModel> getSetup(String userRequest)async{
    try{
      final response = await apiServiceReport.post("/teams?userRequest=$userRequest", {});
      return CreateReportTaskModel.fromJson(response);
  }on DioError catch(e){
      throw ApiException.handleError(e);
    }catch (e){
      throw ApiError(message: e.toString());
    }
    }


  Future<TaskStatusResponse> getReportResult(String taskID) async {
    const delayBetweenRetries = Duration(seconds: 30);

    while (true) {
      try {
        final response = await apiServiceReport.get(
          "/teams/user",
        );
        if (response !is ApiError ||
        response is Map<String,dynamic>) {
        print(response['aiResponse']);
        return TaskStatusResponse.fromJson(response);
        } else if(response != Map<String,dynamic>)  {
          print("Data not ready yet, retrying...");
        }
      } on DioError catch (e) {
        print("DioError: ${e.message}, retrying...");
      } catch (e) {
        print("Error: $e, retrying...");
      }

      await Future.delayed(delayBetweenRetries);
    }
  }


}