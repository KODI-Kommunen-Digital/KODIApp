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
  final List<ShelfModel>? shelves;
  final bool isOwner;

  const ProductRequestDetailScreen(
      {super.key,
      required this.request,
      required this.shelves,
      required this.isOwner});

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
    if (widget.isOwner) {
      shelves.addAll(widget.shelves!);
    }
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
                Text(
                  dom.DocumentFragment.html(widget.request.title).text ??
                      widget.request.title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 8,
                ),
                Html(
                    data: ContainerRepository.removeDoubleEnumHtml(
                        widget.request.description)),
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
                if (widget.isOwner)
                  const SizedBox(
                    height: 64,
                  ),
                if (widget.isOwner)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        Translate.of(context)
                            .translate('choose_shelves_product'),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                if (widget.isOwner)
                  IgnorePointer(
                    ignoring: (widget.shelves == null ||
                        (widget.shelves ?? []).isEmpty),
                    child: MultiSelectDropDown(
                        //isExpanded: true,
                        fieldBackgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        borderColor:
                            Theme.of(context).textTheme.bodyLarge?.color ??
                                Colors.white,
                        optionsBackgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        dropdownBackgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        optionTextStyle: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyLarge?.color ??
                                    Colors.white),
                        selectedOptionBackgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        dropdownHeight: 200,
                        clearIcon: null,
                        hint: (widget.shelves != null &&
                                (widget.shelves ?? []).isNotEmpty)
                            ? Translate.of(context)
                                .translate('choose_shelves_product')
                            : Translate.of(context)
                                .translate('all_shelves_full'),
                        options: shelves.map((shelf) {
                          return ValueItem(
                              value: shelf.id,
                              label: shelf.title ?? shelf.id.toString());
                        }).toList(),
                        onOptionSelected:
                            (List<ValueItem> selectedOptions) async {
                          selectedShelves = [];
                          for (var option in selectedOptions) {
                            setState(() {
                              selectedShelves.add(shelves.firstWhere(
                                  (shelf) => option.value == shelf.id));
                            });
                          }
                        }),
                  ),
                if (widget.isOwner)
                  const SizedBox(
                    height: 32,
                  ),
                if (widget.isOwner)
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
                if (widget.isOwner)
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
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.isOwner)
                      AppButton(Translate.of(context).translate('approve'),
                          onPressed: () async {
                        checkRequest();
                      }),
                    if (widget.isOwner)
                      const SizedBox(
                        width: 8,
                      ),
                    AppButton(Translate.of(context).translate('delete'),
                        onPressed: () {
                      showDeleteConfirmation();
                    })
                  ],
                )
              ],
            )),
      ),
    );
  }

  void checkRequest() async {
    String? msg;
    if (selectedShelves.isNotEmpty && validMaxCount && widget.isOwner) {
      acceptRequest();
    } else {
      if (!validMaxCount) {
        msg = Translate.of(context).translate('invalid_max_count');
      } else if (selectedShelves.isEmpty) {
        msg = Translate.of(context).translate('choose_shelves_product');
      } else {
        msg = Translate.of(context).translate('error');
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  void acceptRequest() async {
    if (!mounted) return;
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
            content: Text(Translate.of(context).translate('error_message'))));
        return;
      }
      final bool success = await ContainerRepository.acceptProductRequest(
          widget.request, shelfIds, maxCount);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text(Translate.of(context).translate('request_approved'))));
        Navigator.pop(context, true);
        return;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(Translate.of(context).translate('error_message'))));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(Translate.of(context).translate('choose_shelves_product'))));
    }
  }

  Future<void> showDeleteConfirmation() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translate.of(context).translate('delete_Confirmation')),
          content: Text(Translate.of(context)
              .translate('are_you_sure_delete_product_request')),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
              },
              child: Text(Translate.of(context).translate('yes')),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(Translate.of(context).translate('no')),
            ),
          ],
        );
      },
    );
    if (result == true) {
      if (!mounted) return;
      final bool success =
          await ContainerRepository.declineProductRequest(widget.request);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              Translate.of(context).translate("delete_product_request_success"),
            ),
          ),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              Translate.of(context).translate("error_message"),
            ),
          ),
        );
      }
    }
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

    bool isValid = _errorMaxCount == null;
    if (isValid != validMaxCount) {
      setState(() {
        validMaxCount = isValid;
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
