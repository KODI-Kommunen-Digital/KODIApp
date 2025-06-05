import 'dart:io';
import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_multifilter.dart';
import 'package:heidi/src/presentation/main/home/widget/app_filter_button.dart';
import 'package:heidi/src/presentation/widget/app_text_input.dart';
import 'package:heidi/src/utils/translate.dart';

class EventsSearchWidget extends StatefulWidget {
  final Function(String) onSearch;
  final Function(MultiFilter?) onFilter;
  final String? hintText;
  final MultiFilter filter;
  final VoidCallback onDelete;
  final String? searchTerm;

  const EventsSearchWidget(
      {super.key,
      required this.onSearch,
      required this.onFilter,
      this.hintText,
      required this.filter,
      required this.onDelete,
      this.searchTerm});

  @override
  State<EventsSearchWidget> createState() => _EventsSearchWidgetState();
}

class _EventsSearchWidgetState extends State<EventsSearchWidget> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.searchTerm != null) {
      _textEditingController.text = widget.searchTerm!;
    }
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets contentPadding = Platform.isIOS
        ? const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0)
        : const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0);

    return SafeArea(
      child: Container(
        padding: Platform.isIOS
            ? const EdgeInsets.only(left: 10, right: 5, bottom: 0)
            : const EdgeInsets.only(left: 10, right: 5, bottom: 0, top: 26),
        child: Card(
          margin: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.white, width: 2)),
          color: Theme.of(context).primaryColor,
          child: AppTextInput(
            autofocus: false,
            clearColor: Colors.white,
            hasDelete: true,
            onDelete: widget.onDelete,
            onChanged: (searchTerm) {
              setState(() {});
            },
            hintText: "${Translate.of(context).translate(
              'find_event',
            )}...",
            onSubmitted: widget.onSearch,
            inputTextStyle: const TextStyle(color: Colors.white),
            hintTextStyle: const TextStyle(color: Colors.white),
            trailing: AppFilterButton(
              multiFilter: widget.filter,
              color: Colors.white,
              filterCallBack: widget.onFilter,
            ),
            controller: _textEditingController,
          ),
        ),
      ),
    );
  }
}
