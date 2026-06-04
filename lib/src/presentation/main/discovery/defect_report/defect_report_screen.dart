import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/presentation/widget/app_upload_image.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';
import 'cubit/defect_report_cubit.dart';
import 'cubit/defect_report_state.dart';
import 'widget/location_picker_bottom_sheet.dart';

class DefectReportScreen extends StatefulWidget {
  const DefectReportScreen({super.key});

  @override
  State<DefectReportScreen> createState() => _DefectReportScreenState();
}

class _DefectReportScreenState extends State<DefectReportScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  File? _selectedImage;
  String? currentMaengelTyp;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DefectReportCubit(),
      child: BlocConsumer<DefectReportCubit, DefectReportState>(
        listener: (context, state) {
          if (state.isSubmitSuccessful) {
            Navigator.pushReplacementNamed(context, Routes.defectSubmitSuccess);
          } else if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    Translate.of(context).translate('submit_failed_message')),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: Theme.of(context).iconTheme.copyWith(
                color: Colors.orange,
              ),
              centerTitle: true,
              title: Text(
                  Translate.of(context).translate('category_defect_report')),
              actions: [
                TextButton(
                  onPressed:
                      state.isSubmitting ? null : () => _onSubmit(context),
                  child: Text(
                    Translate.of(context).translate('add'),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 180,
                      child: AppUploadImage(
                        profile: false,
                        forumGroup: false,
                        defect: true,
                        title: Translate.of(context)
                            .translate('upload_feature_image'),
                        image: _selectedImage?.path,
                        onChange: (result) {
                          setState(() {
                            _selectedImage = result.isNotEmpty
                                ? File(result.first.path)
                                : null;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: Translate.of(context).translate('email'),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppTextInput(
                      hintText: Translate.of(context).translate('email'),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: Translate.of(context)
                                .translate('title'),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppTextInput(
                      hintText:
                          Translate.of(context).translate('title'),
                      controller: _titleController,
                    ),
                    const SizedBox(height: 16),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: Translate.of(context)
                                .translate('input_description'),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppTextInput(
                      hintText:
                          Translate.of(context).translate('input_description'),
                      controller: _descriptionController,
                      maxLines: 5,
                    ),
                    const SizedBox(height: 16),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: Translate.of(context).translate('input_type'),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButton(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      underline: const SizedBox(),
                      isExpanded: true,
                      menuMaxHeight: 200,
                      hint: Text(Translate.of(context).translate('input_type')),
                      value: currentMaengelTyp,
                      items: context
                          .read<DefectReportCubit>()
                          .getMaengelTypen()
                          .map((type) {
                        return DropdownMenuItem(value: type, child: Text(type));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            currentMaengelTyp = value;
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: Translate.of(context)
                                .translate('input_address'),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => _openLocationPicker(context),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .dividerColor
                              .withOpacity(.07),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: _addressController.text.isEmpty
                                  ? Colors.grey
                                  : Theme.of(context).colorScheme.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _addressController.text.isEmpty
                                    ? Translate.of(context)
                                        .translate('input_address')
                                    : _addressController.text,
                                style: _addressController.text.isEmpty
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.grey)
                                    : Theme.of(context).textTheme.bodyMedium,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey[400],
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: Translate.of(context)
                                .translate('input_phone'),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppTextInput(
                      hintText:
                          Translate.of(context).translate('input_phone'),
                      controller: _phoneController,
                      focusNode: _phoneFocusNode,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _openLocationPicker(BuildContext context) async {
    _phoneFocusNode.unfocus();
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.4 +
            MediaQuery.of(ctx).viewInsets.bottom,
        child: const LocationPickerBottomSheet(),
      ),
    );
    _phoneFocusNode.unfocus();
    if (result != null && result.isNotEmpty) {
      setState(() => _addressController.text = result);
    }
  }

  void _onSubmit(BuildContext context) {
    final title =
        "${_titleController.text.trim()} | ${currentMaengelTyp ?? ""}";
    final description = _descriptionController.text.trim();
    final address = _addressController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final type = currentMaengelTyp;

    final emailRegex = RegExp(r'^(([^<>()[\.,;:\s@"]+(\.[^<>()[\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              Translate.of(context).translate('image_required')),
        ),
      );
      return;
    }

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Translate.of(context)
              .translate('title_and_description_required')),
        ),
      );
    }  else if (address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(Translate.of(context).translate('address_message')),
      ));
    } else if (currentMaengelTyp == null || currentMaengelTyp == "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(Translate.of(context).translate('category_require'))));
    } else if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(Translate.of(context).translate('email_message')),
      ));
    } else if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(Translate.of(context).translate('value_not_valid_email')),
      ));
    } else if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(Translate.of(context).translate('phone_message')),
      ));
    } else {
      context.read<DefectReportCubit>().submitReport(
            title: title,
            description: description,
            image: _selectedImage,
            address: address,
            email: email,
            phoneNumber: phone,
            category: type,
          );
    }
  }
}
