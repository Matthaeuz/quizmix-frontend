import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_viewed_quiz_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewer/view_quiz_screen.dart';

class QuizDetailCard extends ConsumerStatefulWidget {
  final Quiz quiz;

  const QuizDetailCard({super.key, required this.quiz});

  @override
  _QuizDetailCardState createState() => _QuizDetailCardState();
}

class _QuizDetailCardState extends ConsumerState<QuizDetailCard> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final String firstLetter = widget.quiz.title[0];

    return InkWell(
      onTap: () {
        ref
            .read(currentQuizViewedProvider.notifier)
            .updateCurrentQuiz(widget.quiz);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ViewQuizScreen()));
      },
      onHover: (value) {
        setState(() {
          isHovering = value;
        });
      },
      child: Container(
          width: 200,
          height: 200,
          color: Colors.white,
          child: Material(
            color:
              isHovering ? AppColors.grey.withOpacity(0.1) : Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: widget.quiz.image == null
                          ? Text(
                              firstLetter.toUpperCase(),
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          : Image.network(
                              widget.quiz.image!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.quiz.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
