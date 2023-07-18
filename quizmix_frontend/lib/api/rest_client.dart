import 'package:quizmix_frontend/state/models/auth/auth_details.dart';
import 'package:quizmix_frontend/state/models/auth/auth_token.dart';
import 'package:quizmix_frontend/state/models/reviewees/reviewee.dart';
import 'package:quizmix_frontend/state/models/users/signup_details.dart';
import 'package:quizmix_frontend/state/models/users/user.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8000")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  /// AUTHENTICATION API

  @POST("/api/token/")
  Future<AuthToken> signIn(@Body() AuthDetails authDetails);

  @POST("/api/token/refresh/")
  Future<AuthToken> refreshToken(@Body() Map<String, dynamic> refresh);

  /// USERS API

  @POST("/users/")
  Future<User> createUser(@Body() SignUpDetails details);

  // @GET("users")
  // Future<List<User>> getUsers(@Header("Authorization") String token);

  @GET("/users/{id}/")
  Future<User> getUserById(@Header("Authorization") String token, @Path("id") int id);

  @GET("/users/?email={email}")
  Future<List<User>> getUserByEmail(@Header("Authorization") String token, @Path("email") String email);

  /// REVIEWEE API
  
  @POST("/reviewees/")
  Future<Reviewee> createReviewee(@Header("Authorization") String token, @Body() Map<String, dynamic> user);

  @GET("/reviewees/")
  Future<List<Reviewee>> getReviewees(@Header("Authorization") String token);

  @GET("/reviewees/{id}/")
  Future<User> getRevieweeById(@Header("Authorization") String token, @Path("id") int id);

  @GET("/reviewees/?user={id}")
  Future<List<Reviewee>> getRevieweeByUserId(@Header("Authorization") String token, @Path("id") int id);
}
