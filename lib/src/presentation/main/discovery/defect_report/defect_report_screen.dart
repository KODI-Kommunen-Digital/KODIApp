import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/presentation/widget/app_upload_image.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';
import 'cubit/defect_report_cubit.dart';
import 'cubit/defect_report_state.dart';

class DefectReportScreen extends StatefulWidget {
  const DefectReportScreen({super.key});

  @override
  State<DefectReportScreen> createState() => _DefectReportScreenState();
}

class _DefectReportScreenState extends State<DefectReportScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  File? _selectedImage;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
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
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
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
                            text: Translate.of(context)
                                .translate('input_content'),
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
                          Translate.of(context).translate('input_content'),
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
                    AppTextInput(
                      hintText:
                          Translate.of(context).translate('input_address'),
                      controller: _addressController,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      Translate.of(context).translate('email'),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Text(
                        'gemeinde@stockheim.bayern.de',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
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

  void _onSubmit(BuildContext context) {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final address = _addressController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Translate.of(context)
              .translate('title_and_description_required')),
        ),
      );
    } else if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bitte laden Sie ein Bild hoch.'),
        ),
      );
    } else if (address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(Translate.of(context).translate('address_message')),
      ));
    } else {
      context.read<DefectReportCubit>().submitReport(
          title: title,
          description: description,
          image: _selectedImage!,
          address: address);
    }
  }
}
