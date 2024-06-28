// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
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
        title: Column(
          children: [
            Text(Translate.of(context).translate('portal_head')),
            Text(Translate.of(context).translate('portal_subhead'),
                style: Theme.of(context).textTheme.bodyLarge)
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 36,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              Translate.of(context).translate('portal_text'),
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 36,
          ),
          const SizedBox(
            height: 36,
          ),
          Text(
            Translate.of(context).translate('i_am'),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    minimumSize: const Size(150, 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    maximumSize: const Size(150, double.infinity)),
                child: Text(
                  Translate.of(context).translate('portal_employee'),
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
                onPressed: () async {
                  //TODO check if user is allowed to view applications
                  final prefs = await Preferences.openBox();
                  prefs.setKeyValue(Preferences.categoryId, 20);
                  prefs.setKeyValue(Preferences.type, 'category');
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    minimumSize: const Size(150, 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    maximumSize: const Size(150, double.infinity)),
                child: Text(
                  Translate.of(context).translate('portal_company'),
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
                onPressed: () async {
                  UserModel? user = await UserRepository.loadUser();
                  if (user != null) {
                    Navigator.pushNamed(
                      context,
                      Routes.submit,
                      arguments: {
                        'isApplicant': true,
                      },
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(Translate.of(context)
                            .translate('login_required'))));
                    Navigator.pushNamed(context, Routes.signIn);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: Image(
                  image: AssetImage("assets/images/portal_1.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 150,
                height: 150,
                child: Image(
                  image: AssetImage("assets/images/portal_2.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )

        ],
      ),
    );
  }
}
