import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/edit_store/cubit/edit_store_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/owner/edit_store/cubit/edit_store_state.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/utils/common.dart';
import 'package:heidi/src/utils/translate.dart';

class EditStoreScreen extends StatefulWidget {
  final int storeId;
  final int cityId;

  const EditStoreScreen(
      {super.key, required this.storeId, required this.cityId});

  @override
  State<EditStoreScreen> createState() => _EditStoreScreenState();
}

class _EditStoreScreenState extends State<EditStoreScreen> {
  @override
  void initState() {
    context.read<EditStoreCubit>().storeId = widget.storeId;
    context.read<EditStoreCubit>().cityId = widget.cityId;
    context.read<EditStoreCubit>().onLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditStoreCubit, EditStoreState>(
        builder: (context, state) => state.maybeWhen(
            loading: () => const EditStoreLoading(),
            loaded: (store) => EditStoreLoaded(store: store),
            error: (e) => EditStoreError(error: e),
            success: () => const EditStoreSuccess(),
            orElse: () => ErrorWidget('Unknown Error')));
  }
}

class EditStoreLoaded extends StatefulWidget {
  final StoreModel store;

  const EditStoreLoaded({super.key, required this.store});

  @override
  State<EditStoreLoaded> createState() => _EditStoreLoadedState();
}

class _EditStoreLoadedState extends State<EditStoreLoaded> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _descFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();

  String? nameError;

  @override
  void initState() {
    _nameController.text = widget.store.name;
    _descController.text = widget.store.description;
    _addressController.text = widget.store.address ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _addressController.dispose();

    _nameFocus.dispose();
    _descFocus.dispose();
    _addressFocus.dispose();
    super.dispose();
  }

  void onSubmit() {
    if (_nameController.text.trim() == '') {
      setState(() {
        nameError = Translate.of(context).translate('name_required');
      });
      return;
    } else {
      nameError = null;
    }

    String? description;
    String? address;

    if (_descController.text != '') {
      description = _descController.text;
    }
    if (_addressController.text != '') {
      address = _addressController.text;
    }

    context.read<EditStoreCubit>().updateStore(
        name: _nameController.text,
        address: address,
        longitude: widget.store.longitude,
        latitude: widget.store.latitude,
        description: description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((widget.store.name == '')
            ? Translate.of(context).translate('store')
            : widget.store.name),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Column(
              children: [
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
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate('name'),
                  controller: _nameController,
                  errorText: nameError,
                  focusNode: _nameFocus,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onSubmitted: (text) {
                    Utils.fieldFocusChange(context, _nameFocus, _descFocus);
                  },
                ),
                const SizedBox(height: 16),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          text:
                              Translate.of(context).translate('input_content'),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate('input_content'),
                  controller: _descController,
                  focusNode: _descFocus,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onSubmitted: (text) {
                    Utils.fieldFocusChange(context, _descFocus, _addressFocus);
                  },
                ),
                const SizedBox(height: 16),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          text:
                              Translate.of(context).translate('input_address'),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
                const SizedBox(height: 8),
                AppTextInput(
                  hintText: Translate.of(context).translate('input_address'),
                  controller: _addressController,
                  focusNode: _addressFocus,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(Translate.of(context).translate('submit'),
                        onPressed: () {
                      onSubmit();
                    }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditStoreSuccess extends StatelessWidget {
  const EditStoreSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('success')),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    Translate.of(context).translate('save_data_success'),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditStoreError extends StatelessWidget {
  final String error;

  const EditStoreError({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('error')),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    Translate.of(context).translate(error),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditStoreLoading extends StatelessWidget {
  const EditStoreLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
