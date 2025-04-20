import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.yellow),
          hintText: 'Search',
          hintStyle: TextStyle(
              fontSize: 20,
              color: Colors.white,
          ),
          border: InputBorder.none,
          suffixIcon: Icon(Icons.arrow_forward_ios, color: Colors.yellow),
        ),
      ),
    );
  }
}
