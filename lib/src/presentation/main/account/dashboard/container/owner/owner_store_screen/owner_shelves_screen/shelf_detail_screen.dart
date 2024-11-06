// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_shelf.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/utils/translate.dart';

class ShelfDetailsScreen extends StatefulWidget {
  final ShelfModel shelf;

  const ShelfDetailsScreen({super.key, required this.shelf});

  @override
  State<ShelfDetailsScreen> createState() => _ShelfDetailsScreenState();
}

class _ShelfDetailsScreenState extends State<ShelfDetailsScreen> {
  bool expandTitle = false;
  bool expandDescription = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('shelf_details')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      expandTitle = !expandTitle;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.shelf.title ??
                              Translate.of(context).translate('undefined'),
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          overflow: (expandTitle)
                              ? TextOverflow.clip
                              : TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon((expandTitle)
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      expandDescription = !expandDescription;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.shelf.description ??
                              Translate.of(context).translate('undefined'),
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: (expandDescription)
                              ? TextOverflow.clip
                              : TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon((expandDescription)
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down)
                    ],
                  ),
                ),
                if (widget.shelf.productName != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Translate.of(context).translate('product'),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.shelf.productName!,
                        style: Theme.of(context).textTheme.bodyMedium!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.shelf.formatDate(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                if (widget.shelf.productName != null)
                  const SizedBox(
                    height: 32,
                  ),
                if (widget.shelf.productName != null)
                  AppButton(Translate.of(context).translate('remove_product'),
                      onPressed: () {
                    showRemoveProductDialog(context);
                  })
              ],
            )),
      ),
    );
  }

  Future<void> showRemoveProductDialog(BuildContext buildContext) async {
    final result = await showDialog(
      context: buildContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translate.of(context).translate('remove_product')),
          content: Text(
              Translate.of(context).translate('are_you_sure_remove_product')),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                final bool success =
                    await ContainerRepository.removeProductFromShelf(
                        widget.shelf.id);
                if (success) {
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        Translate.of(context).translate("error_message"),
                      ),
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: Text(Translate.of(context).translate('yes')),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // No
              child: Text(Translate.of(context).translate('no')),
            ),
          ],
        );
      },
    );
    if (result == true) {}
  }
}
