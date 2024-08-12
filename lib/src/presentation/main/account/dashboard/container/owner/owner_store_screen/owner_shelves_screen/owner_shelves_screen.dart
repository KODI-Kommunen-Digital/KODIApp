import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_store.dart';

class OwnerShelvesScreen extends StatefulWidget {
  final StoreModel store;

  const OwnerShelvesScreen({super.key, required this.store});

  @override
  State<OwnerShelvesScreen> createState() => _OwnerShelvesScreenState();
}

class _OwnerShelvesScreenState extends State<OwnerShelvesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
