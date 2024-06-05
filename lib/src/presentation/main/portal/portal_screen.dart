// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class PortalScreen extends StatefulWidget {
  const PortalScreen({super.key});

  @override
  State<PortalScreen> createState() => _PortalScreenState();
}

class _PortalScreenState extends State<PortalScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Translate.of(context).translate('portal_head')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Translate.of(context).translate('choose_profile_type'),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            AppButton(
              Translate.of(context).translate('company'),
              onPressed: () async {
                //TODO check if user is allowed to view applications
                final prefs = await Preferences.openBox();
                prefs.setKeyValue(Preferences.categoryId, 20);
                Navigator.pushNamed(
                  context,
                  Routes.listProduct,
                  arguments: {
                    'id': 20,
                    'title':
                        Translate.of(context).translate('category_applicant')
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            AppButton(
              Translate.of(context).translate('applicant'),
              onPressed: () async {
                UserModel? user = await UserRepository.loadUser();
                if (user != null) {
                  Navigator.pushNamed(
                    context,
                    Routes.submit,
                    arguments: {
                      'isNewList': false,
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          Translate.of(context).translate('login_required'))));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
