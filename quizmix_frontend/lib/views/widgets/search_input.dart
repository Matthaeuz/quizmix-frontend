import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchInput({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.4,
      child: TextField(
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
        onChanged: onChanged,
      ),
    );
  }
}
