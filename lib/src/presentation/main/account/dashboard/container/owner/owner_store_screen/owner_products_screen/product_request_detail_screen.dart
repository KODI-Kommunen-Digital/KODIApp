// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:heidi/src/data/model/model_product_request.dart';
import 'package:heidi/src/data/model/model_shelf.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:heidi/src/utils/validate.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:html/dom.dart' as dom;

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
  final TextEditingController _textMaxCountController = TextEditingController();
  String? _errorMaxCount;
  List<ShelfModel> selectedShelves = [];
  List<ShelfModel> shelves = [];
  bool validMaxCount = false;

  @override
  void initState() {
    super.initState();
    //shelves.addAll(widget.shelves.where((shelf) => shelf.productId == null));
    shelves.addAll(widget.shelves);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('product_request')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      dom.DocumentFragment.html(widget.request.title).text ??
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
                Html(data: widget.request.description),
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
                      Translate.of(context).translate('inventory'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.request.inventory?.toString() ??
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
                      Translate.of(context).translate('min_count'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.request.minCount?.toString() ??
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
                      getStatusString(widget.request.status),
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
                      Translate.of(context).translate('barcode'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.request.barcode ??
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      Translate.of(context).translate('choose_shelves_product'),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
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
                    hint: Translate.of(context)
                        .translate('choose_shelves_product'),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      Translate.of(context).translate('enter_max_count'),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                AppTextInput(
                  hintText: Translate.of(context).translate('max_count'),
                  maxLines: 1,
                  maxLength: 20,
                  keyboardType: TextInputType.number,
                  errorText: _errorMaxCount,
                  controller: _textMaxCountController,
                  textInputAction: TextInputAction.done,
                  onChanged: (text) {
                    checkValidMaxCount();
                  },
                ),
                if (selectedShelves.isNotEmpty && validMaxCount)
                  AppButton(Translate.of(context).translate('approve'),
                      onPressed: () async {
                    if (selectedShelves.isNotEmpty) {
                      List<int> shelfIds = [];
                      for (var shelf in selectedShelves) {
                        shelfIds.add(shelf.id);
                      }
                      int? maxCount;
                      try {
                        maxCount = int.parse(_textMaxCountController.text);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(Translate.of(context)
                                .translate('error_message'))));
                        return;
                      }
                      final bool success =
                          await ContainerRepository.acceptProductRequest(
                              widget.request, shelfIds, maxCount);
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
      ),
    );
  }

  void checkValidMaxCount() {
    _errorMaxCount = UtilValidator.validate(_textMaxCountController.text,
        type: ValidateType.number, allowEmpty: false);

    if (_errorMaxCount == null) {
      try {
        int min = widget.request.minCount ?? 0;
        int max = int.parse(_textMaxCountController.text);
        int inventory = widget.request.inventory ?? 0;

        if (min > max) {
          _errorMaxCount = 'max_smaller_min';
        } else if (inventory > max) {
          _errorMaxCount = 'inventory_bigger_max';
        } else {
          _errorMaxCount = null;
        }
      } catch (e) {
        _errorMaxCount = 'check_max_count';
      }
    }
    if (_errorMaxCount == null) {
      setState(() {
        validMaxCount = true;
      });
    } else {
      setState(() {
        validMaxCount = false;
      });
    }
  }

  String getStatusString(int status) {
    switch (status) {
      case 0:
        return Translate.of(context).translate('inactive');
      case 1:
        return Translate.of(context).translate('active');
      default:
        return status.toString();
    }
  }
}
