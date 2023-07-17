import 'package:quizmix_frontend/state/models/auth/auth_details.dart';
import 'package:quizmix_frontend/state/models/auth/auth_token.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8000/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("api/token/")
  Future<AuthToken> signIn(@Body() AuthDetails authDetails);
}
