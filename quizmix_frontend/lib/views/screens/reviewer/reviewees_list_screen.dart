import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/widgets/dashboard.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_list_card.dart';

class RevieweesListScreen extends StatelessWidget {
  const RevieweesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Side - Dashboard
          const DashboardWidget(
            selectedOption: 'Reviewees',
          ),
          // Right Side - Background Color
          Expanded(
            flex: 8,
            child: Container(
              color: AppColors.fifthColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FractionallySizedBox(
                      widthFactor: 0.4,
                      child: TextField(
                        decoration: InputDecoration(
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
                      ),
                    ),
                    // List
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Align(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 25,
                              mainAxisSpacing: 25,
                              mainAxisExtent: 125,
                            ),
                            itemCount: 20,
                            itemBuilder: (context, index) {
                              return const RevieweeListCard(
                                text: 'Alcuitas, Aaron Benjmin',
                                imageAsset:
                                    "lib/assets/images/profile_pictures/aaron.jpg",
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
