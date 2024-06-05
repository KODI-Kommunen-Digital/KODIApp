// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_contact.dart';
import 'package:heidi/src/presentation/main/home/contact/cubit/contact_cubit.dart';
import 'package:heidi/src/presentation/main/home/contact/cubit/contact_state.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/translate.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ContactCubit>().onLoad();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactCubit, ContactState>(
        builder: (context, state) => state.maybeWhen(
            loading: () => const ContactLoading(),
            loaded: (list) => ContactLoaded(list: list),
            orElse: () => ErrorWidget("Failed to load contacts.")));
  }
}

class ContactLoading extends StatelessWidget {
  const ContactLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ContactLoaded extends StatelessWidget {
  final List<ContactPerson> list;

  const ContactLoaded({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    String uniqueKey = UniqueKey().toString();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Translate.of(context).translate("contact")),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16, left: 16),
            child: InkWell(
              onTap: () async {
                await Clipboard.setData(
                    ClipboardData(text: list[index].email ?? ""));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text(Translate.of(context).translate('email_copied'))));
              },
              child: Row(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: "${list[index].image}?cacheKey=$uniqueKey",
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    placeholder: (context, url) {
                      return AppPlaceholder(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          width: 140,
                          height: 140,
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Image.network(
                        '${Application.picturesURL}admin/DefaultForum.jpeg',
                        width: 120,
                        height: 140,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Handle errors here
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            width: 120,
                            height: 140,
                            child: const Icon(Icons.error),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          // Display the AppPlaceholder while the image is loading
                          if (loadingProgress == null) {
                            return child;
                          }
                          return AppPlaceholder(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              width: 140,
                              height: 140,
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${list[index].firstname} ${list[index].lastname}",
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          list[index].role,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(height: 2),
                        Visibility(
                          visible: list[index].email != null,
                          child: Text(
                            "Email: ${list[index].email ?? ""}",
                            maxLines: 2,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Visibility(
                            visible: list[index].phone != null,
                            child: const SizedBox(height: 2)),
                        Visibility(
                          visible: list[index].phone != null,
                          child: Text(
                            "Tel.: ${list[index].phone ?? ""}",
                            maxLines: 2,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: list.length,
      ),
    );
  }
}
