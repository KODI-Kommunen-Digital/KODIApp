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
import 'package:heidi/src/presentation/main/home/widget/home_sliver_app_bar.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/configs/image.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:heidi/src/utils/validate.dart';

class CreateProductScreen extends StatefulWidget {
  final ContainerProductModel? product;
  final int sellerId;

  const CreateProductScreen({super.key, this.product, required this.sellerId});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CreateProductCubit>().onLoad(product: widget.product);
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
                    sellerId: widget.sellerId,
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
  final int sellerId;
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
      required this.sellerId,
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

  final _textTitleController = TextEditingController();
  final _textDescriptionController = TextEditingController();
  final _textPriceController = TextEditingController();
  final _textTaxController = TextEditingController();
  final _textInventoryController = TextEditingController();
  final _textMinCountController = TextEditingController();
  final _focusTitle = FocusNode();
  final _focusDescription = FocusNode();
  final _focusPrice = FocusNode();
  final _focusTax = FocusNode();
  final _focusInventory = FocusNode();
  final _focusMinCount = FocusNode();

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
            price: double.parse(_textPriceController.text),
            tax: double.parse(_textTaxController.text),
            inventory: int.parse(_textInventoryController.text),
            minCount: int.parse(_textMinCountController.text),
            categoryId: selectedCategory!.id,
            subCategoryId: selectedSubCategory!.id);
      } else {
        success = await ContainerRepository.editProduct(
            cityId: widget.product!.cityId,
            storeId: widget.product!.shopId,
            productId: widget.product!.id,
            title: _textTitleController.text,
            description: _textDescriptionController.text,
            price: double.parse(_textPriceController.text),
            tax: double.parse(_textTaxController.text),
            inventory: (_textInventoryController.text != '')
                ? int.parse(_textInventoryController.text)
                : 0,
            minCount: int.parse(_textMinCountController.text),
            isActive: isActive,
            localProduct: widget.product!);
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

    if (selectedCategory == null) {
      _errorCategory = "category_require";
    } else {
      _errorCategory = null;
    }

    if (selectedSubCategory == null &&
        (widget.subCategories ?? []).isNotEmpty) {
      _errorSubCategory = "subCategory_require";
    } else {
      _errorSubCategory = null;
    }

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
      _errorSubCategory
    ];

    if (_errorTitle != null ||
        _errorDescription != null ||
        _errorStore != null ||
        _errorPrice != null ||
        _errorTax != null ||
        _errorInventory != null ||
        _errorMinCount != null ||
        _errorCategory != null ||
        _errorSubCategory != null) {
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
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: <Widget>[
        if(widget.product == null)
        SliverPersistentHeader(
          delegate: AppBarHomeSliver(
              cityTitlesList: cityTitles,
              hintText: Translate.of(context).translate('hselect_location'),
              selectedOption: (selectedCityId != 0)
                  ? selectedCityTitle
                  : Translate.of(context).translate('hselect_location'),
              expandedHeight: MediaQuery.of(context).size.height * 0.3,
              banners: Images.slider,
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
                        categoryId: selectedCategory?.id);
                  }
                }
              }),
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            SafeArea(
              top: false,
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: <Widget>[
                    if (widget.product == null)
                      TypeAheadField<StoreModel>(
                        builder: (context, controller, focusNode) {
                          return AppTextInput(
                            controller: controller,
                            focusNode: focusNode,
                            autofocus: true,
                            hintText:
                                Translate.of(context).translate('city_stores'),
                          );
                        },
                        itemBuilder: (context, store) {
                          return ListTile(
                            title: Text(store.name),
                            subtitle: Text(
                              store.description,
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
                                formattedSearchString(element.description)
                                    .contains(formattedSearchString(search));
                          }).toList();
                          return result;
                        },
                      ),
                    const SizedBox(height: 16),
                    if (selectedStore != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context)
                                  .appBarTheme
                                  .backgroundColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    icon: const Icon(Icons.close))
                            ],
                          ),
                        ),
                      ),
                    if (selectedStore != null) const SizedBox(height: 32),
                    if (selectedStore != null)
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(
                              TextSpan(
                                text:
                                    Translate.of(context).translate('category'),
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
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCategory = value;
                                    });
                                    context.read<CreateProductCubit>().onLoad(
                                        cityId: selectedCityId,
                                        storeId: selectedStore?.id,
                                        selectedStore: selectedStore,
                                        categoryId: selectedCategory?.id,
                                        selectedCategory: selectedCategory);
                                  },
                                ),
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
                            onChanged: (value) {
                              setState(() {
                                selectedSubCategory = value;
                              });
                              context.read<CreateProductCubit>().onLoad(
                                  cityId: selectedCityId,
                                  storeId: selectedStore?.id,
                                  selectedStore: selectedStore,
                                  categoryId: selectedCategory?.id,
                                  selectedCategory: selectedCategory,
                                  selectedSubCategory: selectedSubCategory);
                            },
                          ),
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
                              text: Translate.of(context)
                                  .translate('description'),
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
                            context, _focusDescription, _focusPrice);
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
                              text:
                                  Translate.of(context).translate('inventory'),
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
                              text:
                                  Translate.of(context).translate('min_count'),
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
                          title:
                              Text(Translate.of(context).translate('active')),
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
            )
          ]),
        )
      ],
    );
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
