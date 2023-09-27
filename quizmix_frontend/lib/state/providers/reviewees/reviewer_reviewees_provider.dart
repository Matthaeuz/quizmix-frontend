import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/users/user.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';

class ReviewerRevieweesNotifier extends StateNotifier<AsyncValue<List<User>>> {
  final RestClient client;
  final String accessToken;
  final int reviewerId;
  late List<User> allReviewees;

  ReviewerRevieweesNotifier({
    required this.client,
    required this.accessToken,
    required this.reviewerId,
  }) : super(const AsyncValue.loading()) {
    fetchReviewerReviewees();
  }

  Future<void> fetchReviewerReviewees() async {
    try {
      // var reviewees = await client.getAssignedReviewees(
      //   accessToken,
      //   {"reviewerId": reviewerId},
      // );
      final revieweeUAVs =
          await client.getReviewerReviewees(accessToken, reviewerId.toString());
      final reviewees =
          revieweeUAVs.map((revieweeUAV) => revieweeUAV.user).toList();
      allReviewees = reviewees;
      state = AsyncValue.data(reviewees);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      debugPrint("Provider error");
    }
  }

  void searchReviewees(String value) {
    if (value.isEmpty) {
      state = AsyncValue.data(allReviewees);
    } else {
      final searchResult = allReviewees
          .where((reviewee) =>
              reviewee.fullName.toLowerCase().contains(value.toLowerCase()))
          .toList();
      state = AsyncValue.data(searchResult);
    }
  }
}

final reviewerRevieweesProvider =
    StateNotifierProvider<ReviewerRevieweesNotifier, AsyncValue<List<User>>>(
        (ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final reviewerId = ref.watch(userProvider).id;

  return ReviewerRevieweesNotifier(
      client: client, accessToken: token.accessToken, reviewerId: reviewerId);
});
