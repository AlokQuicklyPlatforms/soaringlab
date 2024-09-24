
import 'package:either_dart/either.dart';
import 'package:get_storage/get_storage.dart';
import 'package:soaring_lab/src/core/constants.dart';
import 'package:soaring_lab/src/features/auth/model/login_model.dart';
import 'package:soaring_lab/src/services/hive_storage.dart';
import 'package:soaring_lab/src/widgets/dynamic_toast.dart';
import '../../../services/api_services.dart';
import '../../../services/app_initializer.dart';

class AuthenticationRepository {
  final ApiService _apiService = ApiService();
  // final GetStorage _storage = GetStorage();

  // final Dio _dio = AppInitializer().dio;
  final GetStorage _storage = AppInitializer().storage;

// hive storage

  Future<Either<String, dynamic>> login(String email, String password) async {
    var response = await _apiService
        .postBody(Constants.log_In, {'email': email, 'password': password});

    // var response = {
    //   "status": true,
    //   "subCode": 200,
    //   "message": "User Logged in successfully",
    //   "error": "",
    //   "items": {
    //     "userId": "66517066cb050103a1027419",
    //     "email": "user1@yopmail.com",
    //     "status": 1,
    //     "token": "-IVsyeehsF1ulwFagI9maLpjC6Do9agjYo63Tdxl"
    //   }
    // };
    // LoginModel loginModel = LoginModel.fromJson(response);

    // log(authstorage.get('email').toString());
    // log(authstorage.get('userId').toString());
    // log(authstorage.get('token').toString());

    // return Right(response);

    return response.fold(
      (error) => Left(error),
      (data) {
        // log("login response : $data");
        LoginModel loginModel = LoginModel.fromJson(data);
        if (loginModel.subCode == 200) {
          authstoragebox.put('email', loginModel.items!.email);
          authstoragebox.put('userId', loginModel.items!.userId);
          authstoragebox.put('token', loginModel.items!.token);
        }
        DynamicToast.show(loginModel.message!.toString());
        // Store the token in GetStorage

        return Right(data);
      },
    );
  }

  Future<Either<String, dynamic>> signup(
      String name, String email, String password) async {
    final response = await _apiService.postBody(Constants.Sign_Up,
        {"pilotName": name, "email": email, "password": password});
    print("respone: $response");
    return response.fold(
      (error) => Left(error),
      (data) {
        DynamicToast.show(data["message"].toString());
        // Optionally store the token in GetStorage if the signup also returns a token

        return Right(data);
      },
    );
  }


   Future<Either<String, dynamic>> appstatus() async {
    var response = await _apiService
        .get(Constants.app_status,);

  return response.fold(
      (error) => Left(error),
      (data) {
 

        return Right(data);
      },
    );
  }
}
