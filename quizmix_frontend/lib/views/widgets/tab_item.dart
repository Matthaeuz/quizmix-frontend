import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';

class TabItem extends StatelessWidget {
  const TabItem({
    super.key,
    required this.isSelected,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  final bool isSelected;
  final String text;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: isSelected ? AppColors.iconColor : null,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: LayoutBuilder(builder: (context, constraints) {
          final parentWidth = constraints.maxWidth;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  size: 44,
                  color: isSelected ? AppColors.white : null,
                ),
              ),
              if (parentWidth > 92) ...[
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? AppColors.white : null,
                    ),
                  ),
                ),
              ],
            ],
          );
        }),
      ),
    );
  }
}
