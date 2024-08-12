import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_store.dart';

class OwnerProductsScreen extends StatefulWidget {
  final StoreModel store;
  const OwnerProductsScreen({super.key, required this.store});

  @override
  State<OwnerProductsScreen> createState() => _OwnerProductsScreenState();
}

class _OwnerProductsScreenState extends State<OwnerProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
