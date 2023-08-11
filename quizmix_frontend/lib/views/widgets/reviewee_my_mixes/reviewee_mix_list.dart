import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/providers/mixes/reviewee_mixes_provider.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_my_mixes/reviewee_mix_card.dart';

class MyMixList extends ConsumerWidget {
  const MyMixList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mixes = ref.watch(revieweeMixesProvider);
    return mixes.when(
      data: (mixes) {
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
      },
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
