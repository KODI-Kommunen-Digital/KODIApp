// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
// import 'package:heidi/src/utils/translate.dart';

class SearchListings extends StatefulWidget {
  final ValueSetter<String>? onSearchCallback;
  final String? hintText;

  const SearchListings({
    Key? key,
    required this.onSearchCallback,
    this.hintText,
  }) : super(key: key);

  @override
  _SearchListingsState createState() => _SearchListingsState();
}

class _SearchListingsState extends State<SearchListings> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 16, bottom: 8),
        child: Card(
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              widget.onSearchCallback?.call(value);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 15.0,
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              hintText: widget.hintText ?? "Suchlisten",
              hintStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color ??
                    Colors.white,
              ),
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }
}
