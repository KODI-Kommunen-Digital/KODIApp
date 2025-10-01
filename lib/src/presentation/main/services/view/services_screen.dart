import 'package:custom_in_app_webview/custom_in_app_webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/presentation/main/services/model/services_response_model.dart';
import 'package:heidi/src/presentation/main/services/view/services_bloc.dart';
import 'package:heidi/src/presentation/main/services/view/services_event.dart';
import 'package:heidi/src/presentation/main/services/view/services_state.dart';
import 'package:heidi/src/utils/extensions/string_extension.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:heidi/src/utils/extensions/list_extension.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  void didChangeDependencies() {
    context.read<ServicesBloc>().add(LoadServicesData());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(Translate.of(context).translate('services')),
        ),
        body: Center(
          child: BlocConsumer<ServicesBloc, ServicesState>(
            listener: (_, state) {},
            builder: (_, state) {
              if (services is ServicesLoading) {
                return CircularProgressIndicator();
              } else if (services is ServicesError) {
                return Text(
                    Translate.of(context).translate('err_load_service'));
              } else if (state is ServicesLoaded) {
                if (state.services.isNotNullOrEmpty) {
                  return buildServiceUI(state.services!);
                }
                return Text(Translate.of(context).translate('no_service'));
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget buildServiceUI(List<ServiceResponseModel> services) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 2 tiles per row
    final crossAxisCount = 2;
    final spacing = 16.0;

    // Calculate tile width
    final tileWidth =
        (screenWidth - (spacing * (crossAxisCount + 1))) / crossAxisCount;

    // Calculate number of rows needed
    final rowCount = (services.length / crossAxisCount).ceil();

    // Calculate tile height to fill screen
    final tileHeight = (screenHeight - ((rowCount + 1) * spacing)) / rowCount;

    final childAspectRatio = tileWidth / tileHeight;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox.expand(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount, // 2 tiles per row
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: childAspectRatio, // Adjust height/width ratio
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return GestureDetector(
              onTap: () async {
                if(service.type == ServiceType.navigation && service.navigationUrl.isNotNullOrEmpty){
                  CustomInAppWebView.showAsBottomSheet(
                    context: context,
                    url: service.navigationUrl!,
                    title: service.navigationUrl!,
                  );
                } else if(service.type == ServiceType.contact){

                }
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      service.bgImg,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      color: Colors.black
                          .withValues(alpha: 0.4), // Overlay for readability
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          service.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
