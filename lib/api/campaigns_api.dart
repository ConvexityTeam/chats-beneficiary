import 'dart:io';

import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/services/base_service.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';

class CampaignAPI extends BaseService {
  getAllPublicCampaigns() async {
    String _getPublicCampignsURL = BaseService.rootApi + '/campaigns';

    try {
      final response = await Dio().get(
        "$_getPublicCampignsURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${locator<UserService>().token}',
        }),
      );

      if (kDebugMode)
        print({
          "SENDING REQUEST TO API.... TO GET public campaigns",
        });
      return response.data['data'];
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"status": "error", "message": e.response!.data["message"]};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message, "status": "error"};
      }
    }
  }

  getAllTasksInCash4WorkCampaign(int? campaignId) async {
    String _getAllTasksInCashForWorkURL =
        BaseService.rootApi + '/beneficiaries/cash-for-work/$campaignId';

    try {
      final response = await Dio().get(
        "$_getAllTasksInCashForWorkURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${locator<UserService>().token}',
        }),
      );

      if (kDebugMode)
        print({
          "SENDING REQUEST TO API.... TO GET ALL CASH FOR WORK CAMPAIGN TASKS",
        });
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"status": "error", "message": e.response!.data["message"]};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message, "status": "error"};
      }
    }
  }

  getCashForWorkDetails(String? cashWorkId) async {
    String _getcashForWorkDetailsURL =
        BaseService.rootApi + '/cash-for-work/$cashWorkId';

    try {
      final response = await Dio().get(
        "$_getcashForWorkDetailsURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${locator<UserService>().token}',
        }),
      );

      if (kDebugMode)
        print({
          "SENDING REQUEST TO API.... TO GET cash for work details",
        });
      return response.data['data'];
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"status": "error", "message": e.response!.data["message"]};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message, "status": "error"};
      }
    }
  }

  getCampaignsByOrganization(String? orgId) async {
    String _getCampignsByOrgURL =
        BaseService.rootApi + '/campaigns/organisation/$orgId?type=campaign';

    try {
      final response = await Dio().get(
        "$_getCampignsByOrgURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${locator<UserService>().token}',
        }),
      );

      if (kDebugMode)
        print({
          "SENDING REQUEST TO API.... TO GET campaignsation by organisation",
        });
      return response.data['data'];
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"status": "error", "message": e.response!.data["message"]};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message, "status": "error"};
      }
    }
  }

  joinCampaign(String? campaignId) async {
    String _addToCampaignURL =
        BaseService.rootApi + '/beneficiaries/campaigns/$campaignId/join';

    try {
      final response = await Dio().post(
        "$_addToCampaignURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${locator<UserService>().token}',
        }),
      );

      if (kDebugMode)
        print({
          "SENDING REQUEST TO API.... TO ADD User to public campaign",
        });
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"status": "error", "message": e.response!.data['message']};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message, "status": "error"};
      }
    }
  }

  leaveCampaign(String? campaignId) async {
    String _leaveCampaign =
        BaseService.rootApi + '/beneficiaries/campaigns/$campaignId/leave';

    try {
      final response = await Dio().put(
        "$_leaveCampaign",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${locator<UserService>().token}',
        }),
      );

      if (kDebugMode)
        print({
          "SENDING REQUEST TO API.... TO ADD User to public campaign",
        });
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"status": "error", "message": e.response!.data['message']};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"status": "error", "message": e.message};
      }
    }
  }

  fetchAssignedTasks() async {
    String _fetchTasksURL =
        BaseService.rootApi + '/beneficiaries/cash-for-work/tasks';

    try {
      final response = await Dio().get(
        "$_fetchTasksURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${locator<UserService>().token}',
        }),
      );

      if (kDebugMode)
        print({
          "SENDING REQUEST TO API.... TO GET USER PICKED TASK LIST",
        });
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"status": "error", "message": e.response!.data['message']};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"status": "error", "message": e.message};
      }
    }
  }

  submitEvidenceUpload(
      int? assignmentId, String? comment, List<File> evidenceImages) async {
    String _evidenceURL =
        BaseService.rootApi + '/cash-for-work/task/beneficiary-evidence';

    try {
      // Create the formData and pass to data field of the request
      var formData = FormData.fromMap({
        "TaskAssignmentId": assignmentId,
        "comment": comment,
        "type": "image",
        "uploads": [
          for (var file in evidenceImages)
            {
              await MultipartFile.fromFile(
                file.path,
                filename:
                    'task_evidence' + file.path + new DateTime.now().toString(),
                contentType: new MediaType("image", "jpeg"),
              )
            }.toList()
        ]
      });

      final response = await Dio().post(
        "$_evidenceURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${locator<UserService>().token}',
        }),
        data: formData,
      );

      if (kDebugMode)
        print({
          "SENDING REQUEST TO API.... TO UPLOAD EVIDENCE OF C4W TASK",
          response.data
        });
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"status": "error", "message": e.response!.data['message']};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"status": "error", "message": e.message};
      }
    }
  }

  pickC4WTask(int? taskId) async {
    String _pickTaskURL =
        BaseService.rootApi + '/beneficiaries/cash-for-work/tasks';

    try {
      final response = await Dio().post("$_pickTaskURL",
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${locator<UserService>().token}',
          }),
          data: {
            "UserId": locator<UserService>().id,
            "TaskId": taskId,
          });

      if (kDebugMode)
        print({"SENDING REQUEST TO API.... TO PICK C4W TASK", response.data});
      return response.data;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"status": "error", "message": e.response!.data['message']};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"status": "error", "message": e.message};
      }
    }
  }
}
