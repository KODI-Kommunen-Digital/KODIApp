import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/qr_code/cubit/qr_code_cubit.dart';
import 'package:heidi/src/presentation/main/account/dashboard/container/qr_code/cubit/qr_code_state.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key});

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<QrCodeCubit>().onLoad(false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QrCodeCubit, QrCodeState>(
        builder: (context, state) => state.maybeWhen(
            loading: () => const QrCodeLoading(),
            loaded: (data, validUntil, accountId, name) => QrCodeLoaded(
                data: data,
                validUntil: validUntil,
                accountId: accountId,
                name: name),
            error: (msg) {
              if (msg == 'login') {
                return const QrCodeLogin();
              }
              return const QrCodeLoading();
            },
            orElse: () => ErrorWidget("Failed to load.")));
  }
}

class QrCodeLoaded extends StatefulWidget {
  final String data;
  final String? validUntil;
  final int? accountId;
  final String name;

  const QrCodeLoaded(
      {super.key,
      required this.data,
      required this.validUntil,
      required this.accountId,
      required this.name});

  @override
  State<QrCodeLoaded> createState() => _QrCodeLoadedState();
}

class _QrCodeLoadedState extends State<QrCodeLoaded> {
  late double qrSize;

  void showNewQRDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            Translate.of(context).translate('generate_new_qr'),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  Translate.of(context)
                      .translate('are_you_sure_new_qr'),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            AppButton(
              Translate.of(context).translate('yes'),
              onPressed: () {
                context.read<QrCodeCubit>().onLoad(true);
                Navigator.of(context).pop();
              },
              type: ButtonType.text,
            ),
            AppButton(
              Translate.of(context).translate('no'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              type: ButtonType.text,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    qrSize = (MediaQuery.of(context).size.height +
            MediaQuery.of(context).size.width) /
        3.5;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("QR Code"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: qrSize,
                height: qrSize,
                child: QrImageView(
                  data: widget.data,
                  version: QrVersions.auto,
                  size: qrSize,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.name,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 2,
              ),
              if(widget.validUntil != null)
              Text(
                '${Translate.of(context).translate('valid_until')}: ${widget.validUntil}',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
              ),
              const SizedBox(height: 16,),
              AppButton(Translate.of(context).translate('generate_new_qr'), onPressed: () {
                showNewQRDialog();
              })
            ],
          ),
        ],
      ),
    );
  }
}

class QrCodeLogin extends StatelessWidget {
  const QrCodeLogin({super.key});

  void login(BuildContext context) async {
    await Navigator.pushNamed(context, Routes.signIn);
    // ignore: use_build_context_synchronously
    context.read<QrCodeCubit>().onLoad(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("QR Code"),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Translate.of(context).translate('login_required'),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    Translate.of(context).translate('login_required_qr_code'),
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AppButton(
                    Translate.of(context).translate('login'),
                    onPressed: () {
                      login(context);
                    },
                    type: ButtonType.normal,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  AppButton(
                    Translate.of(context).translate('back'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    type: ButtonType.normal,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class QrCodeLoading extends StatelessWidget {
  const QrCodeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("QR Code"),
        ),
        body: const Center(child: CircularProgressIndicator.adaptive()));
  }
}
