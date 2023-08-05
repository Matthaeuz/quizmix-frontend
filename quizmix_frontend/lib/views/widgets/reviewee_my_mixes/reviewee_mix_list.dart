import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_my_mixes/reviewee_mix_card.dart';

// temporary Mix data, remove on integration
final mixes = [
  {"image": "lib/assets/images/default_pic.png", "title": "MyMix1"},
  {"image": "lib/assets/images/default_pic.png", "title": "MyMix2"},
  {"image": "lib/assets/images/default_pic.png", "title": "MyMix3"},
];

class MyMixList extends ConsumerWidget {
  const MyMixList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final questions = ref.watch(questionBankProvider);
    // return questions.when(
    //   data: (questions) {
    //     return ListView.builder(
    //       shrinkWrap: true,
    //       physics: const NeverScrollableScrollPhysics(),
    //       itemCount: questions.length,
    //       itemBuilder: (context, index) {
    //         return QuestionBankCard(
    //           questionDetails: questions[index],
    //         );
    //       },
    //     );
    //   },
    //   loading: () => const CircularProgressIndicator(),
    //   error: (err, stack) => Text('Error: $err'),
    // );
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: mixes.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
          child: RevieweeMixCard(mixDetails: mixes[index]),
        );
      },
    );
  }
}
