import 'package:flutter/material.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:heidi/src/data/model/model_waste_type.dart';

class AppMultiSelectTypeAhead extends StatefulWidget {
  final List<WasteType> items;
  final List<WasteType> selectedItems;
  final ValueChanged<List<WasteType>> onSelectionChanged;
  final VoidCallback? onConfirm;
  final bool isLoading;
  final String hintText;
  final String? errorText;
  final bool enabled;
  final String? sectionTitle;
  final String? sectionDescription;

  const AppMultiSelectTypeAhead({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.onSelectionChanged,
    this.onConfirm,
    this.isLoading = false,
    required this.hintText,
    this.errorText,
    this.enabled = true,
    this.sectionTitle,
    this.sectionDescription,
  });

  @override
  State<AppMultiSelectTypeAhead> createState() => _AppMultiSelectTypeAheadState();
}

class _AppMultiSelectTypeAheadState extends State<AppMultiSelectTypeAhead> {
  late MultiSelectController<WasteType> _controller;
  List<WasteType> _tempSelectedItems = [];

  @override
  void initState() {
    super.initState();
    _controller = MultiSelectController<WasteType>();
    _tempSelectedItems = List.from(widget.selectedItems);
  }

  @override
  void didUpdateWidget(AppMultiSelectTypeAhead oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedItems != oldWidget.selectedItems) {
      _tempSelectedItems = List.from(widget.selectedItems);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSelectionChanged(List<WasteType> selectedItems) {
    setState(() {
      _tempSelectedItems = selectedItems;
    });
    widget.onSelectionChanged(selectedItems); // Notify parent of changes immediately
  }

  

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final dropdownItems = widget.items.map(
      (wasteType) => DropdownItem<WasteType>(
        label: wasteType.name,
        value: wasteType,
        selected: _tempSelectedItems.any((selected) => selected.id == wasteType.id),
      ),
    ).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.sectionTitle != null)
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.sectionTitle!,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (_tempSelectedItems.isNotEmpty)
                TextButton(
                  onPressed: widget.enabled
                      ? () {
                          _controller.clearAll();
                          setState(() {
                            _tempSelectedItems.clear();
                          });
                        }
                      : null,
                  child: const Text('Alle löschen'),
                ),
            ],
          ),
        const SizedBox(height: 4),
        MultiDropdown<WasteType>(
          items: dropdownItems,
          controller: _controller,
          enabled: widget.enabled,
          // searchEnabled: true,
          chipDecoration: ChipDecoration(
            
            backgroundColor: theme.primaryColor.withOpacity(0.1),
            wrap: true,
            runSpacing: 2,
            spacing: 8,
            deleteIcon: Icon(Icons.close, size: 18, color: theme.primaryColor),
            labelStyle: TextStyle(
              color: theme.primaryColor,
              fontWeight: FontWeight.w500,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          ),
          fieldDecoration: FieldDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(color: isDark ? Colors.grey.shade400 : Colors.grey.shade600),
            prefixIcon: Icon(Icons.recycling, color: isDark ? Colors.grey.shade400 : Colors.grey.shade600),
            showClearIcon: false,
            backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: widget.errorText != null
                    ? theme.colorScheme.error
                    : (isDark ? Colors.grey.shade700 : Colors.grey.shade300),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: widget.errorText != null ? theme.colorScheme.error : theme.primaryColor,
                width: 2,
              ),
            ),
          ),
          dropdownDecoration: DropdownDecoration(
            marginTop: 2,
            maxHeight: 400,
            backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            header: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Wähle Abfallarten aus',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
            ),
          ),
          dropdownItemDecoration: DropdownItemDecoration(
            selectedBackgroundColor: theme.primaryColor.withOpacity(0.1),      
            selectedIcon: Icon(Icons.check_circle, color: theme.primaryColor),
            disabledIcon: Icon(Icons.lock, color: Colors.grey.shade400),
          ),
          validator: (value) {
            if (widget.errorText != null && (value == null || value.isEmpty)) {
              return widget.errorText;
            }
            return null;
          },
          onSelectionChange: _onSelectionChanged,
        ),          if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              widget.errorText!,
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error),
            ),
          ),
      ],
    );
  }
}