import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:heidi/src/utils/translate.dart';

class LocationPickerBottomSheet extends StatefulWidget {
  const LocationPickerBottomSheet({super.key});

  @override
  State<LocationPickerBottomSheet> createState() =>
      _LocationPickerBottomSheetState();
}

class _LocationPickerBottomSheetState
    extends State<LocationPickerBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedAddress = '';
  double? _selectedLat;
  double? _selectedLng;
  bool _isLoading = false;
  bool _isFetchingGps = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> _searchSuggestions(String query) async {
    if (query.trim().length < 2) return [];
    setState(() => _isLoading = true);
    try {
      // Gera, Germany bounding box: left(minLon), top(maxLat), right(maxLon), bottom(minLat)
      const viewbox = '12.02,50.96,12.22,50.83';
      final uri = Uri.parse(
        'https://nominatim.openstreetmap.org/search'
        '?q=${Uri.encodeComponent('${query.trim()}, Gera')}'
        '&format=json'
        '&countrycodes=de'
        '&viewbox=$viewbox'
        '&bounded=1'
        '&limit=10',
      );
      final response = await http.get(
        uri,
        headers: {'User-Agent': 'de.gera.mobileapp/1.0'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data
            .cast<Map<String, dynamic>>()
            .where((item) =>
                (item['display_name'] as String? ?? '')
                    .toLowerCase()
                    .contains('gera'))
            .toList();
      }
    } catch (_) {
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
    return [];
  }

  Future<void> _useCurrentLocation(BuildContext context) async {
    final loc = Location();

    bool serviceEnabled = await loc.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await loc.requestService();
      if (!serviceEnabled) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                Translate.of(context).translate('location_service_disabled')),
          ));
        }
        return;
      }
    }

    PermissionStatus permission = await loc.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await loc.requestPermission();
    }

    if (permission == PermissionStatus.deniedForever) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            content: Text(Translate.of(context)
                .translate('location_permission_denied_permanently')),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(ctx);
                  await launchUrl(Uri.parse('app-settings:'));
                },
                child: Text(
                    Translate.of(context).translate('open_settings')),
              ),
            ],
          ),
        );
      }
      return;
    }

    if (permission != PermissionStatus.granted) return;

    if (!mounted) return;
    setState(() => _isFetchingGps = true);

    try {
      final locationData = await loc.getLocation();
      final lat = locationData.latitude;
      final lng = locationData.longitude;
      if (lat == null || lng == null) return;

      final uri = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse'
        '?lat=$lat&lon=$lng&format=json',
      );
      final response = await http.get(
        uri,
        headers: {'User-Agent': 'de.gera.mobileapp/1.0'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final address = data['display_name'] as String? ?? '';
        if (address.isNotEmpty && mounted) {
          setState(() {
            _selectedAddress = address;
            _selectedLat = lat;
            _selectedLng = lng;
            _searchController.text = address;
          });
        }
      }
    } catch (_) {
    } finally {
      if (mounted) setState(() => _isFetchingGps = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Container(
        color: theme.scaffoldBackgroundColor,
        padding: EdgeInsets.fromLTRB(16, 0, 16, 16 + bottomInset),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Title
            Text(
              Translate.of(context).translate('choose_location_now'),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Use current location button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed:
                    _isFetchingGps ? null : () => _useCurrentLocation(context),
                icon: _isFetchingGps
                    ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: theme.colorScheme.primary,
                        ),
                      )
                    : Icon(Icons.my_location,
                        size: 18, color: theme.colorScheme.primary),
                label: Text(
                  _isFetchingGps
                      ? Translate.of(context).translate('fetching_location')
                      : Translate.of(context).translate('use_current_location'),
                  style: TextStyle(color: theme.colorScheme.primary),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                      color: theme.colorScheme.primary.withValues(alpha: 0.5)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Search field with dropdown
            TypeAheadField<Map<String, dynamic>>(
              controller: _searchController,
              constraints: BoxConstraints(
                minHeight: bottomInset > 0 ? 80 : 250,
                maxHeight: bottomInset > 0 ? 200 : 350,
              ),
              suggestionsCallback: _searchSuggestions,
              loadingBuilder: (context) => Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      Translate.of(context).translate('search_address_hint'),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              emptyBuilder: (context) => Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  Translate.of(context).translate('no_results_found'),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
              builder: (context, controller, focusNode) => TextField(
                controller: controller,
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintText:
                      Translate.of(context).translate('search_address_hint'),
                  prefixIcon: const Icon(Icons.search, size: 20),
                  suffixIcon: _isLoading
                      ? Padding(
                          padding: const EdgeInsets.all(12),
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 1.5,
                    ),
                  ),
                  filled: true,
                  fillColor: isDark ? Colors.grey[800] : Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
              ),
              itemBuilder: (context, suggestion) => ListTile(
                dense: true,
                leading: Icon(
                  Icons.location_on_outlined,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                title: Text(
                  suggestion['display_name'] as String? ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall,
                ),
              ),
              onSelected: (suggestion) {
                final address = suggestion['display_name'] as String? ?? '';
                final lat = double.tryParse(suggestion['lat'] as String? ?? '');
                final lng = double.tryParse(suggestion['lon'] as String? ?? '');
                setState(() {
                  _selectedAddress = address;
                  _selectedLat = lat;
                  _selectedLng = lng;
                  _searchController.text = address;
                });
              },
            ),
            const SizedBox(height: 18),

            // Selected address preview
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              child: _selectedAddress.isNotEmpty
                  ? Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: theme.colorScheme.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _selectedAddress,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),

            const Spacer(),

            // Confirm button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _selectedAddress.isNotEmpty
                    ? () => Navigator.pop(context, {
                          'address': _selectedAddress,
                          'lat': _selectedLat,
                          'lng': _selectedLng,
                        })
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.black87,
                  disabledBackgroundColor:
                      theme.colorScheme.primary.withValues(alpha: 0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  Translate.of(context).translate('update_address'),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
