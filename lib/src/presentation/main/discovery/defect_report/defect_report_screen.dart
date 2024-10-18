import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_upload_image.dart';
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
  File? _selectedImage;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DefectReportCubit(),
      child: BlocBuilder<DefectReportCubit, DefectReportState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(Translate.of(context).translate('report_defect')),
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
                        forumGroup: true,
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
                        text: Translate.of(context).translate('input_content'),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppTextInput(
                      hintText:
                          Translate.of(context).translate('input_content'),
                      controller: _titleController,
                      trailing: const Icon(Icons.clear),
                    ),
                    const SizedBox(height: 16),
                    Text.rich(
                      TextSpan(
                        text: Translate.of(context)
                            .translate('input_description'),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppTextInput(
                      hintText:
                          Translate.of(context).translate('input_description'),
                      controller: _descriptionController,
                      maxLines: 5,
                    ),
                    const SizedBox(height: 24),
                    AppButton(
                      Translate.of(context).translate('submit_report'),
                      onPressed: state.isSubmitting
                          ? () {}
                          : () {
                              if (_selectedImage != null) {
                                context.read<DefectReportCubit>().submitReport(
                                      title: _titleController.text,
                                      description: _descriptionController.text,
                                      image: _selectedImage!,
                                    );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(Translate.of(context)
                                          .translate('image_required'))),
                                );
                              }
                            },
                      mainAxisSize: MainAxisSize.max,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
