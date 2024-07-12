import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_product_request.dart';
import 'package:heidi/src/presentation/widget/app_list_title.dart';
import 'package:heidi/src/utils/translate.dart';

class ProductRequestScreen extends StatelessWidget {
  final List<ProductRequestModel> requests;

  const ProductRequestScreen({super.key, required this.requests});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Translate.of(context).translate('product_request')),
          centerTitle: true,
        ),
        body: (requests.isNotEmpty)
            ? ListView.builder(
                itemBuilder: (context, index) {
                  ProductRequestModel item = requests[index];
                  return AppListTitle(
                    title: item.title,
                    subtitle: item.description,
                    trailing: Text("${item.price.toString()}€"),
                    leading: Text(item.reqType.toString()),
                  );
                },
                itemCount: requests.length,
              )
            : Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(Icons.sentiment_satisfied),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        Translate.of(context).translate('list_is_empty'),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ));
  }
}
