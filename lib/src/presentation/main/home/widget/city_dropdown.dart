import 'dart:io';
import 'package:flutter/material.dart';
import 'package:heidi/src/utils/translate.dart';

class CitiesDropDown extends StatefulWidget {
  final ValueSetter<String>? setLocationCallback;
  final List<String>? cityTitlesList;
  final String? hintText;
  final String? selectedOption;

  const CitiesDropDown({
    super.key,
    required this.setLocationCallback,
    required this.cityTitlesList,
    this.hintText,
    this.selectedOption,
  });

  @override
  State<CitiesDropDown> createState() => _CitiesDropDownState();
}

class _CitiesDropDownState extends State<CitiesDropDown> {
  @override
  Widget build(BuildContext context) {
    String? chosenOption =
        widget.selectedOption != "" ? widget.selectedOption : null;
    EdgeInsets contentPadding = Platform.isIOS
        ? const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0)
        : const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0);

    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 14, right: 14, bottom: 8, top: 12),
        color: Theme.of(context).colorScheme.surface,
        child: SizedBox(
          child: DropdownButtonFormField<String>(
            value: chosenOption,
            onChanged: (newValue) {
              setState(() {
                widget.setLocationCallback!(newValue!);
                chosenOption = newValue;
              });
            },
            items: widget.cityTitlesList?.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 10.0),
                  child: Text(option, style: const TextStyle(fontSize: 16)),
                ),
              );
            }).toList(),
            decoration: InputDecoration(
              contentPadding: contentPadding,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).textTheme.bodyLarge?.color ??
                    Colors.white),
              ),
              labelText: widget.hintText ??
                  Translate.of(context).translate('select_location'),
              labelStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color ??
                    Colors.white,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
