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
    context.read<QrCodeCubit>().onLoad();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QrCodeCubit, QrCodeState>(
        builder: (context, state) => state.maybeWhen(
            loading: () => const QrCodeLoading(),
            loaded: (data, validUntil, accountId) => QrCodeLoaded(
                  data: data,
                  validUntil: validUntil,
                  accountId: accountId,
                ),
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
  final String validUntil;
  final int accountId;

  const QrCodeLoaded(
      {super.key,
      required this.data,
      required this.validUntil,
      required this.accountId});

  @override
  State<QrCodeLoaded> createState() => _QrCodeLoadedState();
}

class _QrCodeLoadedState extends State<QrCodeLoaded> {
  late double qrSize;

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
                '${Translate.of(context).translate('valid_until')}: ${widget.validUntil}',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              )
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
    context.read<QrCodeCubit>().onLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("QR Code"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
