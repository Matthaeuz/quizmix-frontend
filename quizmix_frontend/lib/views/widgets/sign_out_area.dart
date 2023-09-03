import 'package:flutter/material.dart';

class SignOutArea extends StatelessWidget {
  const SignOutArea({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        final parentWidth = constraints.maxWidth;

        return InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(
                    Icons.exit_to_app,
                    size: 44,
                  ),
                ),
                if (parentWidth > 112) ...[
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'Sign Out',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }
}
