import 'package:either_dart/either.dart';
import 'package:soaring_lab/src/core/constants.dart';
import 'package:soaring_lab/src/services/api_services.dart';
import 'package:soaring_lab/src/services/hive_storage.dart';

class ProfileRepo {
  final ApiService _apiService = ApiService();

  // get user profile
  Future<Either<String, dynamic>> getprofile() async {
    var userid = authstoragebox.get('userId');

    final response =
        await _apiService.get(Constants.get_User + userid, needToken: true);
    print("respone: $response");
    return response.fold(
      (error) {
        print("this is response$error");
        return Left(error);
      },
      (data) {
        print("user profile Data:" + data['message']);

        // Optionally store the token in GetStorage if the signup also returns a token

        return Right(data);
      },
    );
  }

  Future<Either<String, dynamic>> deleteAccount() async {
    var userid = authstoragebox.get('userId');

    final response =
        await _apiService.delete(Constants.deleteaccount + userid, needToken: true);
    print("respone: $response");
    return response.fold(
      (error) {
        print("this is response$error");
        return Left(error);
      },
      (data) {
        print("user profile Data:" + data['message']);

        // Optionally store the token in GetStorage if the signup also returns a token

        return Right(data);
      },
    );
  }
}
