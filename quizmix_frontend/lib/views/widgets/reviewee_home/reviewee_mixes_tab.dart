import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_my_mixes/reviewee_mix_add.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_my_mixes/reviewee_mix_list.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_my_mixes/reviewee_mix_view.dart';

class RevieweeMixesTab extends ConsumerStatefulWidget {
  const RevieweeMixesTab({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<RevieweeMixesTab> createState() => _RevieweeMixesTabState();
}

class _RevieweeMixesTabState extends ConsumerState<RevieweeMixesTab> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Middle Section
        Expanded(
          flex: 3,
          child: Container(
            color: AppColors.fifthColor,
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Input
                TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  onChanged: (value) {
                    // Handle search input changes
                  },
                ),
                const SizedBox(height: 20),
                const Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                          child: RevieweeMixAdd(),
                        ),
                        MyMixList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Right Section
        const RevieweeMixView()
      ],
    );
  }
}
