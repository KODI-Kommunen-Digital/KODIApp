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

  void login() async {
    await Navigator.pushNamed(context, Routes.signIn);
    context.read<QrCodeCubit>().onLoad();
  }

  void showLoginDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            Translate.of(context).translate('login_required'),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  Translate.of(context).translate('login_required_qr_code'),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            AppButton(
              Translate.of(context).translate('back'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              type: ButtonType.text,
            ),
            AppButton(
              Translate.of(context).translate('login'),
              onPressed: () {
                Navigator.of(context).pop();
                login();
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
                showLoginDialog();
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
      body: Center(
        child: Container(
          width: qrSize,
          height: qrSize,
          color: Colors.white,
          child: QrImageView(
            data: widget.data,
            version: QrVersions.auto,
            size: qrSize,
          ),
        ),
      ),
    );
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
