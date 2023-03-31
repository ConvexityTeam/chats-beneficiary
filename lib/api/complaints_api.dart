import 'package:CHATS/domain/locator.dart';
import 'package:CHATS/services/base_service.dart';
import 'package:CHATS/services/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ComplaintAPI extends BaseService {
  createComplaint(String? report, int? id) async {
    String _createComplaintURL =
        BaseService.rootApi + '/beneficiaries/campaigns/$id/complaints';

    try {
      final response = await Dio().post(
        "$_createComplaintURL",
        data: {
          "report": report,
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${locator<UserService>().token}',
        }),
      );

      if (kDebugMode)
        print({
          "SENDING REQUEST TO API.... TO Create Complaint",
        });
      return response.data['message'];
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"message": e.response!.statusMessage, "status": "failed"};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message, "status": "failed"};
      }
    }
  }

  getComplaint(String? status, int? id) async {
    String _getComplaintURL = BaseService.rootApi +
        '/beneficiaries/campaigns/$id/complaints?status=$status';

    try {
      final response = await Dio().get(
        "$_getComplaintURL",
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${locator<UserService>().token}',
        }),
      );

      if (kDebugMode)
        print({
          "SENDING REQUEST TO API.... TO get Complaints",
        });
      return response.data['message'];
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        print(e.response!.statusMessage);
        return {"message": e.response!.statusMessage, "status": "failed"};
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return {"message": e.message, "status": "failed"};
      }
    }
  }
}
