// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:heidi/src/data/model/model_seller_request.dart';
import 'package:heidi/src/data/repository/container_repository.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:html/dom.dart' as dom;

class SellerRequestDetails extends StatelessWidget {
  final SellerRequestModel request;
  final bool isOwner;

  const SellerRequestDetails(
      {super.key, required this.request, required this.isOwner});

  Future<void> approveSeller(BuildContext context) async {
    final response = await ContainerRepository.updateSeller(request, 1);
    late String message;
    if (response) {
      message = Translate.of(context).translate('seller_approved');
      Navigator.pop(context, true);
    } else {
      message = Translate.of(context).translate('error_message');
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('request_seller')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dom.DocumentFragment.html(request.title).text ?? request.title,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16.0),
                Html(data: request.description),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Translate.of(context).translate('owes'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      "${request.paymentOwed ?? 0}€",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                if (request.user != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Translate.of(context).translate('maccount'),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        "${request.user!.firstname} ${request.user!.lastname}",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                const SizedBox(height: 64.0),
                if (isOwner)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppButton(Translate.of(context).translate('approve'),
                          onPressed: () {
                        approveSeller(context);
                      }),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
