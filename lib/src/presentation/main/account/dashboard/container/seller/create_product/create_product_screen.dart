// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_container_product.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/create_product/cubit/create_product_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/create_product/cubit/create_product_state.dart';
import 'package:heidi/src/presentation/main/home/widget/city_dropdown.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/presentation/widget/app_upload_image.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:heidi/src/utils/validate.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class CreateProductScreen extends StatefulWidget {
  final ContainerProductModel? product;

  const CreateProductScreen({super.key, this.product});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CreateProductCubit>().clearImages();
    context.read<CreateProductCubit>().onLoad(product: widget.product);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate(
            (widget.product == null) ? 'add_product' : 'update_product')),
        centerTitle: true,
      ),
      body: BlocBuilder<CreateProductCubit, CreateProductState>(
          builder: (context, state) => state.maybeWhen(
              loading: () => const CreateProductLoading(),
              loaded: (cities,
                      stores,
                      selectedCity,
                      categories,
                      subCategories,
                      productDetails,
                      selectedStore,
                      selectedCategory,
                      selectedSubCategory) =>
                  CreateProductLoaded(
                    cities: [
                      CategoryModel(
                          id: 0,
                          title: Translate.of(context)
                              .translate('hselect_location'),
                          image: ''),
                      ...cities
                    ],
                    stores: stores,
                    selectedCity: selectedCity,
                    product: widget.product,
                    categories: categories,
                    subCategories: subCategories,
                    productDetails: productDetails,
                    selectedStore: selectedStore,
                    selectedCategory: selectedCategory,
                    selectedSubCategory: selectedSubCategory,
                  ),
              orElse: () => ErrorWidget("Failed to load listings."))),
    );
  }
}

class CreateProductLoaded extends StatefulWidget {
  final List<CategoryModel> cities;
  final List<StoreModel> stores;
  final int? selectedCity;
  final ContainerProductModel? product;
  final List<CategoryModel> categories;
  final List<CategoryModel>? subCategories;
  final Map<String, dynamic>? productDetails;
  final StoreModel? selectedStore;
  final CategoryModel? selectedCategory;
  final CategoryModel? selectedSubCategory;

  const CreateProductLoaded(
      {super.key,
      required this.cities,
      required this.stores,
      required this.categories,
      this.subCategories,
      this.selectedCity,
      this.product,
      this.productDetails,
      this.selectedStore,
      this.selectedCategory,
      this.selectedSubCategory});

  @override
  State<CreateProductLoaded> createState() => _CreateProductLoadedState();
}

class _CreateProductLoadedState extends State<CreateProductLoaded> {
  List<String> cityTitles = [];
  late int selectedCityId;
  String selectedCityTitle = '';
  StoreModel? selectedStore;
  CategoryModel? selectedCategory;
  CategoryModel? selectedSubCategory;
  bool isActive = true;

  String? _errorTitle;
  String? _errorDescription;
  String? _errorStore;
  String? _errorPrice;
  String? _errorTax;
  String? _errorInventory;
  String? _errorMinCount;
  String? _errorCategory;
  String? _errorSubCategory;
  String? _errorBarcode;

  final _textTitleController = TextEditingController();
  final _textDescriptionController = TextEditingController();
  final _textPriceController = TextEditingController();
  final _textTaxController = TextEditingController();
  final _textInventoryController = TextEditingController();
  final _textMinCountController = TextEditingController();
  final _textBarcodeController = TextEditingController();
  final _focusTitle = FocusNode();
  final _focusDescription = FocusNode();
  final _focusPrice = FocusNode();
  final _focusTax = FocusNode();
  final _focusInventory = FocusNode();
  final _focusMinCount = FocusNode();
  final _focusBarcode = FocusNode();

  @override
  void dispose() {
    _textDescriptionController.dispose();
    _textTitleController.dispose();
    _textPriceController.dispose();
    _textTaxController.dispose();
    _textInventoryController.dispose();
    _textMinCountController.dispose();
    _focusDescription.dispose();
    _focusTitle.dispose();
    _focusPrice.dispose();
    _focusTax.dispose();
    _focusInventory.dispose();
    _focusMinCount.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    selectedCityId = widget.selectedCity ?? 0;
    for (var city in widget.cities) {
      cityTitles.add(city.title);
      if (city.id == selectedCityId) {
        selectedCityTitle = city.title;
      }
    }

    if (widget.selectedStore != null) {
      selectedStore = widget.selectedStore;
    }
    if (widget.selectedCategory != null) {
      selectedCategory = widget.selectedCategory;
    }
    if (widget.selectedSubCategory != null) {
      selectedSubCategory = widget.selectedSubCategory;
    }

    if (widget.productDetails != null && widget.product != null) {
      selectedCategory = widget.productDetails!['category'];
      selectedSubCategory = widget.productDetails!['subcategory'];
      selectedCityTitle = widget.productDetails!['cityName'];
      selectedCityId = widget.product!.cityId;
      selectedStore = widget.productDetails!['store'];
      isActive = widget.product!.isActive;
      _textTitleController.text = widget.product!.title;
      _textDescriptionController.text = widget.product!.description;
      _textPriceController.text = widget.product!.price.toString();
      _textTaxController.text = widget.product!.tax.toString();
      //_textInventoryController.text = widget.product!.inventory.toString();
      _textMinCountController.text = widget.product!.minCount.toString();
      _textBarcodeController.text = widget.product!.barcode ?? '';
    }
  }

  void _onSubmit() async {
    final validData = _validData();
    if (validData) {
      late bool success;
      if (widget.product == null) {
        success = await ContainerRepository.addStoreProduct(
            cityId: selectedCityId,
            storeId: selectedStore!.id,
            title: _textTitleController.text,
            description: _textDescriptionController.text,
            price: double.parse(_textPriceController.text.replaceAll(',', '.')),
            tax: double.parse(_textTaxController.text),
            inventory: int.parse(_textInventoryController.text),
            minCount: int.parse(_textMinCountController.text),
            categoryId: selectedCategory!.id,
            subCategoryId: selectedSubCategory?.id,
            barcode: _textBarcodeController.text,
            image: context.read<CreateProductCubit>().selectedImage,
            isImageChanged: context.read<CreateProductCubit>().isImageChanged);
      } else {
        success = await ContainerRepository.editProduct(
            cityId: widget.product!.cityId,
            storeId: widget.product!.shopId,
            productId: widget.product!.id,
            title: _textTitleController.text,
            description: _textDescriptionController.text,
            price: double.parse(_textPriceController.text.replaceAll(',', '.')),
            tax: double.parse(_textTaxController.text),
            inventory: (_textInventoryController.text != '')
                ? int.parse(_textInventoryController.text)
                : 0,
            minCount: int.parse(_textMinCountController.text),
            isActive: isActive,
            localProduct: widget.product!,
            barcode: _textBarcodeController.text,
            image: context.read<CreateProductCubit>().selectedImage,
            isImageChanged: context.read<CreateProductCubit>().isImageChanged);
      }

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(Translate.of(context).translate(
                (widget.product == null)
                    ? 'add_product_success'
                    : 'edit_product_success'))));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(Translate.of(context).translate('error_message'))));
      }
    }
  }

  bool _validData() {
    _errorTitle =
        UtilValidator.validate(_textTitleController.text, allowEmpty: false);

    if (_textDescriptionController.text.length >= 65535) {
      _errorDescription = "value_desc_limit_exceeded";
    } else {
      _errorDescription = UtilValidator.validate(
          _textDescriptionController.text,
          allowEmpty: false);
    }

    if (selectedStore == null) {
      _errorStore = "store_missing";
    } else {
      _errorStore = null;
    }

    if (_textBarcodeController.text.length < 12) {
      _errorBarcode = 'barcode_required';
    } else if (!ContainerRepository.isValidBarcode(
        _textBarcodeController.text)) {
      _errorBarcode = 'value_not_barcode';
    } else {
      _errorBarcode = null;
    }

    if (selectedCategory == null) {
      _errorCategory = "category_require";
    } else {
      _errorCategory = null;
    }

    /*if (selectedSubCategory == null &&
        (widget.subCategories ?? []).isNotEmpty) {
      _errorSubCategory = "subCategory_require";
    } else {
      _errorSubCategory = null;
    }*/

    _errorPrice = UtilValidator.validate(_textPriceController.text,
        type: ValidateType.price, allowEmpty: false);

    _errorTax = UtilValidator.validate(_textTaxController.text,
        type: ValidateType.tax, allowEmpty: false);

    _errorInventory = UtilValidator.validate(_textInventoryController.text,
        type: ValidateType.number,
        allowEmpty: (widget.product != null) ? true : false);

    _errorMinCount = UtilValidator.validate(_textMinCountController.text,
        type: ValidateType.number, allowEmpty: false);

    List<String?> errors = [
      _errorTitle,
      _errorDescription,
      _errorStore,
      _errorPrice,
      _errorTax,
      _errorInventory,
      _errorMinCount,
      _errorCategory,
      _errorSubCategory,
      _errorBarcode
    ];

    if (_errorTitle != null ||
        _errorDescription != null ||
        _errorStore != null ||
        _errorPrice != null ||
        _errorTax != null ||
        _errorInventory != null ||
        _errorMinCount != null ||
        _errorCategory != null ||
        _errorSubCategory != null ||
        _errorBarcode != null) {
      String errorMessage = "";
      for (var element in errors) {
        if (element != null &&
            !errorMessage.contains(Translate.of(context).translate(element))) {
          errorMessage =
              "$errorMessage${Translate.of(context).translate(element)}, ";
        }
      }
      errorMessage = errorMessage.substring(0, errorMessage.length - 2);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));

      setState(() {});
      return false;
    }
    return true;
  }

  String formattedSearchString(String input) {
    return input.toLowerCase().replaceAll(' ', '');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                height: 180,
                child: AppUploadImage(
                  title:
                      Translate.of(context).translate('upload_feature_image'),
                  image: (context
                              .read<CreateProductCubit>()
                              .selectedImage
                              ?.path !=
                          null)
                      ? context.read<CreateProductCubit>().selectedImage?.path
                      : ((widget.product?.productImages ?? []).isNotEmpty)
                          ? '${Application.picturesURL}${widget.product?.productImages?.last}'
                          : null,
                  profile: false,
                  forumGroup: false,
                  allowPdf: false,
                  imageLimit: 1,
                  onDelete: () {
                    if (context.read<CreateProductCubit>().selectedImage !=
                        null) {
                      setState(() {
                        // downloadedImages.removeAt(0);
                        context.read<CreateProductCubit>().selectedImage = null;
                        context.read<CreateProductCubit>().isImageChanged =
                            true;
                      });
                    }
                  },
                  onChange: (result) {
                    if (result.isNotEmpty) {
                      setState(() {
                        context.read<CreateProductCubit>().selectedImage = null;
                        if (context
                                    .read<CreateProductCubit>()
                                    .downloadedImage !=
                                null &&
                            context
                                .read<CreateProductCubit>()
                                .downloadedImage!
                                .path
                                .contains('Defaultimage')) {
                          context.read<CreateProductCubit>().selectedImage =
                              context
                                  .read<CreateProductCubit>()
                                  .downloadedImage;
                        }
                        if (result.isNotEmpty) {
                          context.read<CreateProductCubit>().selectedImage =
                              result.first;
                        }
                      });
                    } else {
                      setState(() {
                        context.read<CreateProductCubit>().selectedImage = null;
                      });
                    }
                    context.read<CreateProductCubit>().isImageChanged = true;
                  },
                ),
              ),
            ),
            if (widget.product == null)
              const SizedBox(
                height: 16,
              ),
            if (widget.product == null)
              CitiesDropDown(
                setLocationCallback: (data) async {
                  for (final city in widget.cities) {
                    if (city.title == data) {
                      setState(() {
                        selectedCityTitle = data;
                        selectedCityId = city.id;
                      });
                      context.read<CreateProductCubit>().onLoad(
                            cityId: city.id,
                            storeId: selectedStore?.id,
                            categoryId: selectedCategory?.id,
                          );
                    }
                  }
                },
                showQR: false,
                cityTitlesList: cityTitles,
                hintText: Translate.of(context).translate('hselect_location'),
                selectedOption: (selectedCityId != 0)
                    ? selectedCityTitle
                    : Translate.of(context).translate('hselect_location'),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: <Widget>[
                  if (widget.product == null)
                    TypeAheadField<StoreModel>(
                      builder: (context, controller, focusNode) {
                        return AppTextInput(
                          controller: controller,
                          focusNode: focusNode,
                          autofocus: false,
                          hintText:
                              Translate.of(context).translate('city_stores'),
                        );
                      },
                      itemBuilder: (context, store) {
                        return ListTile(
                          title: Text(store.name),
                          subtitle: Text(
                            store.description ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(overflow: TextOverflow.ellipsis),
                          ),
                        );
                      },
                      onSelected: (store) {
                        setState(() {
                          selectedStore = store;
                        });
                        context.read<CreateProductCubit>().onLoad(
                            cityId: selectedCityId,
                            storeId: selectedStore?.id,
                            categoryId: selectedCategory?.id,
                            selectedStore: store);
                      },
                      suggestionsCallback: (String search) {
                        final result = widget.stores.where((element) {
                          return formattedSearchString(element.name)
                                  .contains(formattedSearchString(search)) ||
                              formattedSearchString(element.description ?? '')
                                  .contains(formattedSearchString(search));
                        }).toList();
                        return result;
                      },
                    ),
                  const SizedBox(height: 16),
                  if (selectedStore != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).appBarTheme.backgroundColor),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            selectedStore!.name,
                            style: (widget.product == null)
                                ? Theme.of(context).textTheme.titleSmall!
                                : Theme.of(context).textTheme.titleMedium!,
                          ),
                          if (widget.product == null)
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectedStore = null;
                                  });
                                },
                                icon: const Icon(Icons.close, size: 20,))
                        ],
                      ),
                    ),
                  if (selectedStore != null) const SizedBox(height: 32),
                  if (selectedStore != null)
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: Translate.of(context).translate('category'),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                              children: const <TextSpan>[
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  if (selectedStore != null)
                    widget.categories.isEmpty
                        ? const LinearProgressIndicator()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              DropdownButton(
                                  isExpanded: false,
                                  menuMaxHeight: 200,
                                  hint: Text(Translate.of(context)
                                      .translate('input_category')),
                                  value: selectedCategory,
                                  items: widget.categories.map((category) {
                                    return DropdownMenuItem(
                                        value: category,
                                        child: Text(category.title));
                                  }).toList(),
                                  onChanged: (widget.product == null)
                                      ? (CategoryModel? value) {
                                          setState(() {
                                            selectedCategory = value;
                                          });
                                          context
                                              .read<CreateProductCubit>()
                                              .onLoad(
                                                  cityId: selectedCityId,
                                                  storeId: selectedStore?.id,
                                                  selectedStore: selectedStore,
                                                  categoryId:
                                                      selectedCategory?.id,
                                                  selectedCategory:
                                                      selectedCategory);
                                        }
                                      : null),
                            ],
                          ),
                  const SizedBox(height: 16),
                  if ((widget.subCategories ?? []).isNotEmpty)
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: Translate.of(context)
                                  .translate('subCategory'),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                              children: const <TextSpan>[
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  if ((widget.subCategories ?? []).isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        DropdownButton(
                            isExpanded: false,
                            menuMaxHeight: 200,
                            hint: Text(
                                Translate.of(context).translate('subCategory')),
                            value: selectedSubCategory,
                            items: widget.subCategories!.map((subCategory) {
                              return DropdownMenuItem(
                                  value: subCategory,
                                  child: Text(subCategory.title));
                            }).toList(),
                            onChanged: (widget.product == null)
                                ? (CategoryModel? value) {
                                    setState(() {
                                      selectedSubCategory = value;
                                    });
                                  }
                                : null),
                      ],
                    ),
                  const SizedBox(height: 16),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: Translate.of(context).translate('title'),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                            children: const <TextSpan>[
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                  AppTextInput(
                    hintText: Translate.of(context).translate('title'),
                    controller: _textTitleController,
                    errorText: _errorTitle,
                    focusNode: _focusTitle,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (text) {
                      Utils.fieldFocusChange(
                          context, _focusTitle, _focusDescription);
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text:
                                Translate.of(context).translate('description'),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                            children: const <TextSpan>[
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                  AppTextInput(
                    hintText: Translate.of(context).translate('description'),
                    maxLines: 6,
                    maxLength: 1000,
                    errorText: _errorDescription,
                    controller: _textDescriptionController,
                    focusNode: _focusDescription,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (text) {
                      Utils.fieldFocusChange(
                          context, _focusDescription, _focusBarcode);
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: Translate.of(context).translate('barcode'),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                            children: const <TextSpan>[
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                  AppTextInput(
                    hintText: Translate.of(context).translate('enter_barcode'),
                    maxLines: 1,
                    maxLength: 13,
                    errorText: _errorBarcode,
                    controller: _textBarcodeController,
                    focusNode: _focusBarcode,
                    hasDelete: false,
                    trailing: IconButton(
                      icon: const Icon(Icons.document_scanner),
                      onPressed: () {
                        scanBarcode();
                      },
                    ),
                    textInputAction: TextInputAction.next,
                    //keyboardType: TextInputType.number,
                    onSubmitted: (text) {
                      Utils.fieldFocusChange(
                          context, _focusBarcode, _focusPrice);
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: Translate.of(context).translate('price'),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                            children: const <TextSpan>[
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                  AppTextInput(
                    hintText: Translate.of(context).translate('price'),
                    maxLines: 1,
                    maxLength: 100,
                    errorText: _errorPrice,
                    controller: _textPriceController,
                    focusNode: _focusPrice,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onSubmitted: (text) {
                      Utils.fieldFocusChange(context, _focusPrice, _focusTax);
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: Translate.of(context).translate('tax'),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                            children: const <TextSpan>[
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                  AppTextInput(
                    hintText: Translate.of(context).translate('tax'),
                    maxLines: 1,
                    maxLength: 10,
                    errorText: _errorTax,
                    controller: _textTaxController,
                    focusNode: _focusTax,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onSubmitted: (text) {
                      Utils.fieldFocusChange(
                          context, _focusTax, _focusInventory);
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: Translate.of(context).translate('inventory'),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),
                  AppTextInput(
                    hintText: Translate.of(context).translate(
                        (widget.product == null)
                            ? 'inventory'
                            : 'add_inventory'),
                    maxLines: 1,
                    maxLength: 10,
                    errorText: _errorInventory,
                    controller: _textInventoryController,
                    focusNode: _focusInventory,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onSubmitted: (text) {
                      Utils.fieldFocusChange(
                          context, _focusInventory, _focusMinCount);
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: Translate.of(context).translate('min_count'),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                            children: const <TextSpan>[
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                  AppTextInput(
                    hintText: Translate.of(context).translate('min_count'),
                    maxLines: 1,
                    maxLength: 10,
                    errorText: _errorMinCount,
                    controller: _textMinCountController,
                    focusNode: _focusMinCount,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  if (widget.product != null)
                    CheckboxListTile(
                        value: isActive,
                        title: Text(Translate.of(context).translate('active')),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            setState(() {
                              isActive = newValue;
                            });
                          }
                        }),
                  if (widget.product != null) const SizedBox(height: 16),
                  AppButton(Translate.of(context).translate('submit'),
                      onPressed: () {
                    _onSubmit();
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scanBarcode() async {
    var code = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const SimpleBarcodeScannerPage()));
    setState(() {
      if (code is String && code != "" && code != "-1") {
        _textBarcodeController.text = code;
      }
    });
  }
}

class CreateProductLoading extends StatelessWidget {
  const CreateProductLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
