import 'dart:io';

import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_setting.dart';
import 'package:heidi/src/data/model/model_store.dart';
import 'package:heidi/src/presentation/main/home/widget/empty_product_item.dart';
import 'package:path_provider/path_provider.dart';

class AppStoreModel extends StatelessWidget {
  const AppStoreModel(
      {super.key,
      this.storeModel,
      this.onPressed,
      required this.type,
      this.trailing,
      required this.isRefreshLoader});

  final StoreModel? storeModel;
  final ProductViewType type;
  final VoidCallback? onPressed;
  final Widget? trailing;
  final bool isRefreshLoader;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ProductViewType.small:
        if (storeModel == null) {
          return const EmptyProductItem();
        }
        return InkWell(
          onTap: () async {
            onPressed!();
          },
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      storeModel!.name,
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      storeModel?.description ?? '',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
              trailing ?? Container()
            ],
          ),
        );
      case ProductViewType.grid:
        if (storeModel == null) {
          return const EmptyProductItem();
        }

        return InkWell(
          onTap: () async {
            onPressed!();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                storeModel?.description ?? '',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis),
              ),
              const SizedBox(height: 4),
              Text(
                storeModel!.name,
                maxLines: 2,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 8),
              Text(
                storeModel!.address ?? "",
                maxLines: 1,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        );

      case ProductViewType.list:
        if (storeModel == null) {
          return const EmptyProductItem();
        }

        return InkWell(
          onTap: () async {
            onPressed!();
          },
          child: Stack(
            children: [
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          storeModel!.name,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          storeModel?.description ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(height: 4),
                        const SizedBox(height: 8),
                        const Row(
                          children: <Widget>[
                            SizedBox(width: 4),
                          ],
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        );

      default:
        return Container(width: 160.0);
    }
  }

  Future<void> savePDFLocally(String pdfContent) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$pdfContent';
    final file = File(filePath);

    if (!await file.exists()) {
      await file.writeAsBytes(pdfContent.codeUnits);
    }
  }
}
