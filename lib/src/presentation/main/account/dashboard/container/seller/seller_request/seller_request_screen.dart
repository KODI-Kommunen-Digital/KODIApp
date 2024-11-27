// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/seller_request/cubit/seller_request_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/seller/seller_request/cubit/seller_request_state.dart';
import 'package:heidi/src/presentation/main/home/widget/home_sliver_app_bar.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/configs/image.dart';
import 'package:heidi/src/utils/translate.dart';

class SellerRequestScreen extends StatefulWidget {
  const SellerRequestScreen({super.key});

  @override
  State<SellerRequestScreen> createState() => _SellerRequestScreenState();
}

class _SellerRequestScreenState extends State<SellerRequestScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SellerRequestCubit>().onLoad(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('request_seller')),
      ),
      body: BlocBuilder<SellerRequestCubit, SellerRequestState>(
          builder: (context, state) => state.maybeWhen(
              loading: () => const SellerRequestLoading(),
              loaded: (cities, stores, selectedCity) => SellerRequestLoaded(
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
                  ),
              orElse: () => ErrorWidget("Failed to load listings."))),
    );
  }
}

class SellerRequestLoaded extends StatefulWidget {
  final List<CategoryModel> cities;
  final List<StoreModel> stores;
  final int? selectedCity;

  const SellerRequestLoaded(
      {super.key,
      required this.cities,
      required this.stores,
      this.selectedCity});

  @override
  State<SellerRequestLoaded> createState() => _SellerRequestLoadedState();
}

class _SellerRequestLoadedState extends State<SellerRequestLoaded> {
  List<String> cityTitles = [];
  late int selectedCityId;
  String selectedCityTitle = '';
  StoreModel? selectedStore;

  String? _errorTitle;
  String? _errorDescription;
  String? _errorStore;

  final _textTitleController = TextEditingController();
  final _textDescriptionController = TextEditingController();
  final _focusTitle = FocusNode();
  final _focusDescription = FocusNode();

  @override
  void dispose() {
    _textDescriptionController.dispose();
    _textTitleController.dispose();
    _focusDescription.dispose();
    _focusTitle.dispose();
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
  }

  void _onSubmit() async {
    if (_textTitleController.text.isEmpty) {
      _errorTitle = Translate.of(context).translate('title_empty');
    } else {
      _errorTitle = null;
    }

    if (_textDescriptionController.text.isEmpty) {
      _errorDescription = Translate.of(context).translate('description_empty');
    } else {
      _errorDescription = null;
    }

    if (selectedStore == null) {
      _errorStore = Translate.of(context).translate('store_missing');
    } else {
      _errorStore = null;
    }

    if (_errorTitle == null &&
        _errorDescription == null &&
        _errorStore == null) {
      final success = await ContainerRepository.requestBecomeSeller(
          selectedStore!.id,
          _textTitleController.text,
          _textDescriptionController.text);

      String message = (success)
          ? Translate.of(context).translate('request_success')
          : Translate.of(context).translate('error_message');

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));

      if (success) {
        Navigator.pop(context);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("$_errorTitle $_errorDescription $_errorStore")));
    }
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
                    context.read<SellerRequestCubit>().onLoad(city.id);
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    if (widget.stores.isNotEmpty)
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedStore!.name,
                              style: Theme.of(context).textTheme.titleSmall!,
                            ),
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
                    const SizedBox(height: 64),
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
                    AppTextInput(
                      hintText: Translate.of(context).translate('description'),
                      maxLines: 6,
                      maxLength: 1000,
                      errorText: _errorDescription,
                      controller: _textDescriptionController,
                      focusNode: _focusDescription,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),
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

class SellerRequestLoading extends StatelessWidget {
  const SellerRequestLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
