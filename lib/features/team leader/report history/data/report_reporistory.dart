import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/core/network/api_exceptions.dart';
import 'package:recomind/core/network/api_service.dart';
import 'package:recomind/features/team%20leader/report%20history/data/report_model.dart';

class reportRepo{
  ApiServiceReport apiServiceReport = ApiServiceReport();



  /// user
  Future<CreateReportTaskModel> user () async {
    try{
      final response = await apiServiceReport.get("/teams/user");
      print(response);
      final user = CreateReportTaskModel.fromJson(response as Map<String,dynamic>);
      print("finish");
      return user;
    }on DioError catch(e){
      throw ApiException.handleError(e);
    }catch (e){
      throw ApiError(message: e.toString());
    }
  }
  /// send request
  Future<CreateReportrequistModel> getSetup(String userRequest,String CompanyID,String Team_Name)async{
    try{
      final response = await apiServiceReport.post("/teams/create", {
        "company_id": CompanyID,///
        "user_request": userRequest,
        "team_name": Team_Name///
      });

      return CreateReportrequistModel.fromJson(response as Map<String,dynamic>);
  }on DioError catch(e){
      throw ApiException.handleError(e);
    }catch (e){
      throw ApiError(message: e.toString());
    }
    }


  Future<TaskStatusResponse> getReportResult(String? taskID,String? teamID) async {
    const delayBetweenRetries = Duration(seconds: 30);

    while (true) {
      try {
        final response = await apiServiceReport.post(
          "/teams/add",{
          "teamId": teamID,
          "periodic": "Weekly",
          "taskId":  taskID
        }
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