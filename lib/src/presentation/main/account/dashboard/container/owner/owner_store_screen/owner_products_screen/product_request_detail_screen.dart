// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_product_request.dart';
import 'package:heidi/src/data/model/model_shelf.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class ProductRequestDetailScreen extends StatefulWidget {
  final ProductRequestModel request;
  final List<ShelfModel> shelves;

  const ProductRequestDetailScreen(
      {super.key, required this.request, required this.shelves});

  @override
  State<ProductRequestDetailScreen> createState() =>
      _ProductRequestDetailScreenState();
}

class _ProductRequestDetailScreenState
    extends State<ProductRequestDetailScreen> {
  List<ShelfModel> selectedShelves = [];
  List<ShelfModel> shelves = [];

  @override
  void initState() {
    super.initState();
    shelves.addAll(widget.shelves.where((shelf) => shelf.productId == null));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('product_request')),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.request.title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.request.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Translate.of(context).translate('seller'),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.request.sellerId?.toString() ??
                        Translate.of(context).translate('undefined'),
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Translate.of(context).translate('price'),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.request.price.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Translate.of(context).translate('max_count'),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.request.maxCount?.toString() ??
                        Translate.of(context).translate('undefined'),
                    style: Theme.of(context).textTheme.bodyMedium!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ID',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.request.id.toString(),
                    style: Theme.of(context).textTheme.bodyMedium!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Translate.of(context).translate('status'),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.request.status.toString(),
                    style: Theme.of(context).textTheme.bodyMedium!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.request.formatDate(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(
                height: 64,
              ),
              Text(
                Translate.of(context).translate('choose_shelves_product'),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              MultiSelectDropDown(
                  //isExpanded: true,
                  fieldBackgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                  borderColor: Theme.of(context).textTheme.bodyLarge?.color ??
                      Colors.white,
                  optionsBackgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                  dropdownBackgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                  optionTextStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.white),
                  selectedOptionBackgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                  dropdownHeight: 200,
                  clearIcon: null,
                  hint:
                      Translate.of(context).translate('choose_shelves_product'),
                  options: shelves.map((shelf) {
                    return ValueItem(
                        value: shelf.id,
                        label: shelf.title ?? shelf.id.toString());
                  }).toList(),
                  onOptionRemoved: (index, ValueItem option) {
                    setState(() {
                      shelves.add(selectedShelves
                          .firstWhere((shelf) => option.value == shelf.id));
                      selectedShelves
                          .removeWhere((shelf) => shelf.id == option.value);
                    });
                  },
                  onOptionSelected: (List<ValueItem> selectedOptions) async {
                    for (var option in selectedOptions) {
                      setState(() {
                        selectedShelves.add(shelves
                            .firstWhere((shelf) => option.value == shelf.id));
                        shelves
                            .removeWhere((shelf) => shelf.id == option.value);
                      });
                    }
                  }),
              const SizedBox(
                height: 32,
              ),
              if (selectedShelves.isNotEmpty)
                AppButton(Translate.of(context).translate('approve'),
                    onPressed: () async {
                  if (selectedShelves.isNotEmpty) {
                    List<int> shelfIds = [];
                    for (var shelf in selectedShelves) {
                      shelfIds.add(shelf.id);
                    }
                    final bool success =
                        await ContainerRepository.acceptProductRequest(
                            widget.request, shelfIds);
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(Translate.of(context)
                              .translate('request_approved'))));
                      Navigator.pop(context, true);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(Translate.of(context)
                              .translate('error_message'))));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(Translate.of(context)
                            .translate('choose_shelves_product'))));
                  }
                })
            ],
          )),
    );
  }
}
