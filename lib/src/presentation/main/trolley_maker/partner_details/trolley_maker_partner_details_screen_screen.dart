import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heidi/src/data/model/model_trolley_maker_partner_details.dart';
import 'package:heidi/src/data/repository/trolley_maker_repository.dart';
import 'package:heidi/src/presentation/main/trolley_maker/partner_details/cubit/trolley_maker_partner_details_cubit.dart';
import 'package:heidi/src/presentation/main/trolley_maker/partner_details/cubit/trolley_maker_partner_details_state.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:url_launcher/url_launcher.dart';

class TrolleyMakerPartnerDetailsScreen extends StatefulWidget {
  final String gguid;
  final String companyName;
  const TrolleyMakerPartnerDetailsScreen(this.gguid, this.companyName,
      {super.key});

  @override
  State<TrolleyMakerPartnerDetailsScreen> createState() =>
      _TrolleyMakerPartnerDetailsScreenState();
}

class _TrolleyMakerPartnerDetailsScreenState
    extends State<TrolleyMakerPartnerDetailsScreen> {
  late TrolleyMakerPartnerDetailsCubit trolleyMakerCubit;

  TrolleyMakerPartnerDetailsInfo? companyInfo;

  @override
  void initState() {
    super.initState();
    trolleyMakerCubit =
        TrolleyMakerPartnerDetailsCubit(context.read<TrolleyMakerRepository>());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      trolleyMakerCubit.getPartnerDetails(widget.gguid);
    });
  }

  @override
  void dispose() {
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
            widget.companyName,
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            child: BlocConsumer<TrolleyMakerPartnerDetailsCubit,
                TrolleyMakerPartnerDetailsState>(
              listener: (context, state) {
                state.maybeWhen(
                  error: (msg) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(msg)));
                  },
                  success: (companyInfo) {
                    setState(() {
                      this.companyInfo = companyInfo;
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
                success: (companyInfo) {
                  return _getCardDetailsWidget();
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

  Widget _getCardDetailsWidget() {
    return Container(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: companyInfo?.featuredImageUrl ?? "",
                placeholder: (context, url) {
                  return AppPlaceholder(
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  );
                },
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return AppPlaceholder(
                    child: Container(
                      width: double.infinity,
                      height: 250,
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
            const SizedBox(
              height: 5,
            ),
            Text(
              companyInfo?.companyName ?? "",
              maxLines: 2,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Standort",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 1,
            ),
            Text(
              _getAddress(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 5,
            ),
            AppButton(
              "Navigation starten",
              mainAxisSize: MainAxisSize.max,
              onPressed: () {
                _launchMapNavigation(
                    companyInfo?.latitude, companyInfo?.longitude);
              },
              type: ButtonType.text,
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "öffnungszeiten",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            _getTimingRow(
                Translate.of(context).translate(
                  'monday',
                ),
                companyInfo?.openingHours.mon),
            _getTimingRow(
                Translate.of(context).translate(
                  'tuesday',
                ),
                companyInfo?.openingHours.tue),
            _getTimingRow(
                Translate.of(context).translate(
                  'wednesday',
                ),
                companyInfo?.openingHours.wed),
            _getTimingRow(
                Translate.of(context).translate(
                  'thursday',
                ),
                companyInfo?.openingHours.thu),
            _getTimingRow(
                Translate.of(context).translate(
                  'friday',
                ),
                companyInfo?.openingHours.fri),
            _getTimingRow(
                Translate.of(context).translate(
                  'saturday',
                ),
                companyInfo?.openingHours.sat),
            _getTimingRow(
                Translate.of(context).translate(
                  'sunday',
                ),
                companyInfo?.openingHours.sun),
            const SizedBox(
              height: 10,
            ),
            _getCommunicationInfoWidget(
                title: "Telefone",
                info: companyInfo?.phone,
                assetId: 'assets/images/ic_phone.svg',
                callback: () {
                  _launchPhone(companyInfo?.phone);
                }),
            _getCommunicationInfoWidget(
                title: "E-Mail",
                info: companyInfo?.email,
                assetId: 'assets/images/ic_mail.svg',
                callback: () {
                  _launchEmail(companyInfo?.email);
                }),
            _getCommunicationInfoWidget(
                title: "Website",
                info: companyInfo?.website,
                assetId: 'assets/images/ic_browser.svg',
                callback: () {
                  _launchWebsite(companyInfo?.website);
                }),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  String _getAddress() {
    return "${companyInfo?.street} \n${companyInfo?.zip} ${companyInfo?.city}\nLat: ${companyInfo?.latitude} Long: ${companyInfo?.longitude} ";
  }

  Widget _getTimingRow(String day, List<TimeSlot>? slot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(day,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.normal)),
            (slot == null || slot.isEmpty == true)
                ? Text("geschlossen",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.normal))
                : Text("${slot[0].start} - ${slot[0].end} Uhr",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.normal))
          ],
        )
      ],
    );
  }

  Widget _getCommunicationInfoWidget(
      {String? title,
      String? info,
      required String assetId,
      VoidCallback? callback}) {
    var color = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    return Column(
      children: [
        const Divider(
          color: Colors.grey,
          height: 1,
          thickness: 1,
          indent: 0,
          endIndent: 0,
        ),
        InkWell(
          onTap: callback,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Text(
                title ?? "",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(info ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.normal)),
                  SvgPicture.asset(
                    assetId,
                    height: 24,
                    width: 24,
                    semanticsLabel: 'communication info',
                    colorFilter: ColorFilter.mode(
                      color,
                      BlendMode.srcIn,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<void> _launchPhone(String? phoneNumber) async {
    if (phoneNumber == null) {
      // ToastUtil.showErrorToast("Phone number not available");
      return;
    }
    var androidUrl = "tel:$phoneNumber";
    try {
      await launchUrl(Uri.parse(androidUrl));
    } on Exception {
      // ToastUtil.showErrorToast('Failed to launch phone app.');
    }
  }

  Future<void> _launchWebsite(String? website) async {
    if (website == null) {
      // ToastUtil.showErrorToast("Phone number not available");
      return;
    }

    try {
      await launchUrl(Uri.parse(website));
    } on Exception {
      // ToastUtil.showErrorToast('Failed to launch phone app.');
    }
  }

  Future<void> _launchEmail(String? email) async {
    if (email == null) {
      // ToastUtil.showErrorToast("Phone number not available");
      return;
    }

    try {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: email,
      );
      await launchUrl(emailUri);
    } on Exception {
      // ToastUtil.showErrorToast('Failed to launch phone app.');
    }
  }

  Future<void> _launchMapNavigation(double? latitude, double? longitude) async {
    final Uri googleMapsUri = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=driving');

    final Uri appleMapsUri = Uri(
      scheme: 'maps',
      path: 'dir/',
      queryParameters: {
        'daddr': '$latitude,$longitude',
        'dirflg': 'd',
      },
    );
    try {
      if (Platform.isAndroid) {
        await launchUrl(googleMapsUri);
      } else {
        await launchUrl(appleMapsUri);
      }
    } catch (e) {}
  }
}
