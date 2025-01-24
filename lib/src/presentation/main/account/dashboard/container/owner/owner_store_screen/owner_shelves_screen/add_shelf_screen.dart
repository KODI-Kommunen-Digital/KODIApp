// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:heidi/src/data/model/model_container_product.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/translate.dart';

class AddShelfScreen extends StatefulWidget {
  final StoreModel store;

  const AddShelfScreen({super.key, required this.store});

  @override
  State<AddShelfScreen> createState() => _AddShelfScreenState();
}

class _AddShelfScreenState extends State<AddShelfScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  ContainerProductModel? selectedProduct;

  String? _errorTitle;
  String? _errorDescription;
  //String? _errorProduct;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('add_shelf')),
        centerTitle: true,
        actions: [
          AppButton(
            Translate.of(context).translate('add'),
            onPressed: () {
              onSubmit();
            },
            type: ButtonType.text,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppTextInput(
                hintText: Translate.of(context).translate('title'),
                controller: _titleController,
                errorText: _errorTitle,
                focusNode: _titleFocus,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                onSubmitted: (text) {
                  Utils.fieldFocusChange(
                      context, _titleFocus, _descriptionFocus);
                },
                onChanged: (text) => setState(() {}),
                showCharacters: true,
                characterLimit: 255,
              ),
              const SizedBox(height: 8),
              AppTextInput(
                hintText: Translate.of(context).translate('description'),
                controller: _descriptionController,
                errorText: _errorDescription,
                focusNode: _descriptionFocus,
                maxLines: 4,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                onChanged: (text) => setState(() {}),
                showCharacters: true,
                characterLimit: 255,
              ),
              const SizedBox(height: 8),
              TypeAheadField<ContainerProductModel>(
                builder: (context, controller, focusNode) {
                  return AppTextInput(
                    controller: controller,
                    focusNode: focusNode,
                    autofocus: true,
                    hintText: Translate.of(context).translate('products'),
                  );
                },
                itemBuilder: (context, product) {
                  return ListTile(
                    title: Text(product.title),
                    subtitle: Text(
                      product.description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(overflow: TextOverflow.ellipsis),
                    ),
                  );
                },
                onSelected: (product) {
                  setState(() {
                    selectedProduct = product;
                  });
                },
                suggestionsCallback: (String search) async {
                  final list = await getProducts(search);
                  return list;
                },
              ),
              const SizedBox(height: 8),
              if (selectedProduct != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedProduct!.title,
                        style: Theme.of(context).textTheme.titleSmall!,
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              selectedProduct = null;
                            });
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onSubmit() async {
    if (_titleController.text.length <= 3) {
      _errorTitle = 'title_short';
    } else {
      _errorTitle = null;
    }

    if (_titleController.text.length > 255) {
      _errorTitle = 'title_long';
    } else {
      _errorTitle = null;
    }

    if (_descriptionController.text.length > 255) {
      _errorDescription = 'value_user_desc_limit_exceeded';
    } else {
      _errorDescription = null;
    }

    /*if (selectedProduct == null) {
      _errorProduct = 'product_empty';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(Translate.of(context).translate(_errorProduct!))));
    } else {
      _errorProduct = null;
    }*/

    if (_errorTitle == null &&
        //_errorProduct == null &&
        _errorDescription == null) {
      final bool success = await ContainerRepository.saveShelf(
          cityId: widget.store.cityId,
          storeId: widget.store.id,
          title: _titleController.text,
          description: _descriptionController.text,
          productId: selectedProduct?.id);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text(Translate.of(context).translate('add_shelf_success'))));
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(Translate.of(context).translate('error_message'))));
      }
    }
    setState(() {});
  }

  Future<List<ContainerProductModel>> getProducts(String search) async {
    final list = await ContainerRepository.getStoreProducts(
        cityId: widget.store.cityId,
        storeId: widget.store.id,
        pageNo: 1,
        search: search);
    return list ?? [];
  }
}
