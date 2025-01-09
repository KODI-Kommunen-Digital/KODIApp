import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_trolley_maker_partners.dart';
import 'package:heidi/src/data/repository/trolley_maker_repository.dart';
import 'package:heidi/src/presentation/main/trolley_maker/partner/cubit/trolley_maker_partners_cubit.dart';
import 'package:heidi/src/presentation/main/trolley_maker/partner/cubit/trolley_maker_partners_state.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class TrolleyMakerPartnersScreen extends StatefulWidget {
  const TrolleyMakerPartnersScreen({super.key});

  @override
  State<TrolleyMakerPartnersScreen> createState() =>
      _TrolleyMakerPartnersScreenState();
}

class _TrolleyMakerPartnersScreenState
    extends State<TrolleyMakerPartnersScreen> {
  late TrolleyMakerPartnersCubit trolleyMakerCubit;

  List<TrolleyMakerPartners>? partnersList;

  @override
  void initState() {
    super.initState();
    trolleyMakerCubit =
        TrolleyMakerPartnersCubit(context.read<TrolleyMakerRepository>());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      trolleyMakerCubit.getPartnerList();
    });
  }

  @override
  void dispose() {
    // Cleanup logic here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => trolleyMakerCubit,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            Translate.of(context).translate('title_partner'),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            child: BlocConsumer<TrolleyMakerPartnersCubit,
                TrolleyMakerPartnersState>(
              listener: (context, state) {
                state.maybeWhen(
                  error: (msg) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(msg)));
                  },
                  success: (response) {
                    setState(() {
                      setInitialState(response);
                    });
                  },
                  orElse: () {},
                );
              },
              builder: (context, state) => state.when(
                initial: () {
                  return Container();
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
                success: (response) {
                  return _getPartnersListWidget();
                },
                error: (message) {
                  return _getErrorScreenWidget(message);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getErrorScreenWidget(String message) {
    return Center(
      child: Text(message, textAlign: TextAlign.center),
    );
  }

  void setInitialState(List<TrolleyMakerPartners> response) {
    setState(() {
      partnersList = response;
    });
  }

  Widget _getPartnersListWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        itemCount: partnersList?.length,
        itemBuilder: (context, index) {
          return PartnerListItemWidget(
              imageUrl: partnersList?[index].logoUrl,
              title: partnersList?[index].companyName ?? "",
              description: _getCategoriesText(partnersList?[index].categories),
              city: partnersList?[index].city,
              street: partnersList?[index].street,
              gguid: partnersList?[index].gguid);
        },
      ),
    );
  }

  _getCategoriesText(List<String>? categories) {
    return categories?.join(', ');
  }
}

class PartnerListItemWidget extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String description;
  final String? city;
  final String? street;
  final String? gguid;

  const PartnerListItemWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.city,
    required this.street,
    required this.gguid,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTodDetails(context, gguid, title);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: imageUrl ?? "",
                placeholder: (context, url) {
                  return AppPlaceholder(
                    child: Container(
                      width: 120,
                      height: 140,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  );
                },
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: 120,
                    height: 140,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return AppPlaceholder(
                    child: Container(
                      width: 120,
                      height: 140,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.error),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
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
                    description,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    city ?? "",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    street ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.w500),
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateTodDetails(BuildContext context, String? gguid, String title) {
    Navigator.pushNamed(context, Routes.trolleyMakerPartnerDetails, arguments: {
      'gguid': gguid,
      'company_name': title,
    });
  }
}
