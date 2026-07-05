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
      final response = await apiServiceReport.get("/api/Report/teams/user");
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
      final response = await apiServiceReport.post("/api/Report/teams/create", {
        "company_id": CompanyID,///
        "user_request": userRequest,
        "team_name": Team_Name///
      });
       print("user request //////// $userRequest");
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
          "/api/Report/teams/add",{
          "teamId": teamID,
          "periodic": "Weekly",
          "taskId":  taskID
        }
        );
        print(taskID);
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

///get all
  Future<List<SalesReportResponse>> getSalesReports(String teamId) async {
    final String endPoint = '/api/Report/all/$teamId?limit=3633';

    final response = await apiServiceReport.get(endPoint);

    if (response is ApiError) {
      throw response;
    }

    if (response is List) {
      return SalesReportResponse.fromJsonList(response);
    }

    throw ApiError(
      message: "Failed to load sales reports. Unexpected data format.",
    );
  }
}