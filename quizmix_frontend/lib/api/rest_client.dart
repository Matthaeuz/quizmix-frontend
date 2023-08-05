import 'package:quizmix_frontend/state/models/auth/auth_details.dart';
import 'package:quizmix_frontend/state/models/auth/auth_token.dart';
import 'package:quizmix_frontend/state/models/question_attempts/question_attempt.dart';
import 'package:quizmix_frontend/state/models/question_attempts/question_details.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/models/quiz_attempts/quiz_attempt.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';
import 'package:quizmix_frontend/state/models/quizzes/tos.dart';
import 'package:quizmix_frontend/state/models/reviewees/attempt_score.dart';
import 'package:quizmix_frontend/state/models/reviewees/reviewee.dart';
import 'package:quizmix_frontend/state/models/reviewees/top_scores.dart';
import 'package:quizmix_frontend/state/models/reviewers/reviewer.dart';
import 'package:quizmix_frontend/state/models/users/signup_details.dart';
import 'package:quizmix_frontend/state/models/users/user.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'rest_client.g.dart';

/// REST CLIENT API
/// Is only good for handling purely JSON-related data. Multipart-form data is not supported
/// in Flutter Web; custom API endpoints for form handling is found in api/utils/.
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
  Future<User> getUserById(
      @Header("Authorization") String token, @Path("id") int id);

  @GET("/users/?email={email}")
  Future<List<User>> getUserByEmail(
    @Header("Authorization") String token,
    @Path("email") String email,
  );

  /// REVIEWEE API

  @POST("/reviewees/")
  Future<Reviewee> createReviewee(@Body() Map<String, dynamic> user);

  @GET("/reviewees/")
  Future<List<Reviewee>> getReviewees(@Header("Authorization") String token);

  @GET("/reviewees/{id}/")
  Future<User> getRevieweeById(
      @Header("Authorization") String token, @Path("id") int id);

  @GET("/reviewees/?user={id}")
  Future<List<Reviewee>> getRevieweeByUserId(
      @Header("Authorization") String token, @Path("id") int id);

  @GET("/reviewees/?belongs_to={belongsTo}")
  Future<List<Reviewee>> getReviewerReviewees(
    @Header("Authorization") String token,
    @Path("belongsTo") int belongsTo,
  );

  @GET("/reviewees/?belongs_to_is_null=true")
  Future<List<Reviewee>> getUnassignedReviewees(
    @Header("Authorization") String token,
  );

  @POST("/reviewees/get_top_scores/")
  Future<TopScores> getRevieweeTopScores(
    @Header("Authorization") String token,
    @Body() Map<String, int> reviewee,
  );

  @POST("/reviewees/get_quiz_history_scores/")
  Future<List<AttemptScore>> getRevieweeHistoryScores(
    @Header("Authorization") String token,
    @Body() Map<String, int> reviewee,
  );

  @PATCH("/reviewees/{id}/")
  Future<Reviewee> updateReviewee(
    @Header("Authorization") String token,
    @Path("id") int id,
    @Body() Map<String, dynamic> newDetails
  );

  /// REVIEWER API

  @GET("/reviewers/?user={id}")
  Future<List<Reviewer>> getReviewerByUserId(
    @Header("Authorization") String token,
    @Path("id") int id,
  );

  /// QUESTION API

  @POST("/questions/")
  Future<Question> createQuestion(
    @Header("Authorization") String token,
    @Body() Question newQuestion,
  );

  // Save for future use; could be used in a mobile setting or when Retrofit updates
  // @POST("/questions/create_questions_from_pdf/")
  // @MultiPart()
  // Future<List<Question>> createQuestionsFromPdf(
  //   @Header("Authorization") String token,
  //   @Part(name: 'a_file') MultipartFile aFile,
  //   @Part(name: 'q_file') MultipartFile qFile,
  // );

  @GET("/questions/")
  Future<List<Question>> getQuestions(@Header("Authorization") String token);

  @GET("/questions/?category={}")
  Future<List<Question>> getQuestionsByCategory(
    @Header("Authorization") String token,
    @Query("category") String category,
  );

  @GET("/questions/{id}/")
  Future<Question> getQuestionById(
      @Header("Authorization") String token, @Path("id") int id);

  @POST("/questions/advanced_search/")
  Future<List<Question>> advancedSearch(
    @Header("Authorization") String token,
    @Body() Map<String, dynamic> filters,
  );

  /// QUIZ API

  @POST("/quizzes/create_quiz/")
  Future<Quiz> createQuizFromTOS(
      @Header("Authorization") String token, @Body() TOS tos);

  @GET("/quizzes/?made_by={madeBy}")
  Future<List<Quiz>> getMadeByQuizzes(
    @Header("Authorization") String token,
    @Path("madeBy") int madeBy,
  );

  @POST("/quizzes/process_response/")
  Future<double> updateScoresAndParams(
    @Header("Authorization") String token,
    @Body() Map<String, int> resp,
  );

  @POST("/quizzes/select_item/")
  Future<int> selectItem(
    @Header("Authorization") String token,
    @Body() Map<String, dynamic> pool,
  );

  @POST("/quizzes/get_specs/")
  Future<Map<String, int>> getQuizSpecs(
    @Header("Authorization") String token,
    @Body() Map<String, int> quiz,
  );

  /// QUIZ ATTEMPT API

  @GET("/quiz_attempts/?attempted_by={revieweeId}&quiz={quizId}")
  Future<List<QuizAttempt>> getRevieweeAttemptsByQuiz(
    @Header("Authorization") String token,
    @Path("revieweeId") int revieweeId,
    @Path("quizId") int quizId,
  );

  @POST("/quiz_attempts/")
  Future<QuizAttempt> createQuizAttempt(
      @Header("Authorization") String token, @Body() Map<String, int> details);

  @PATCH("/quiz_attempts/{id}/")
  Future<QuizAttempt> updateQuizAttempt(@Header("Authorization") String token,
      @Body() Map<String, dynamic> updatedDetails, @Path("id") int id);

  /// QUESTION ATTEMPT API

  @POST("/question_attempts/")
  Future<QuestionAttempt> createQuestionAttempt(
      @Header("Authorization") String token, @Body() QuestionDetails details);
}
