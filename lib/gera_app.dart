import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:heidi/src/data/repository/forum_repository.dart';
import 'package:heidi/src/data/repository/list_repository.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/main_screen.dart';
import 'package:heidi/src/presentation/cubit/bloc.dart';
import 'package:heidi/src/presentation/main/splash_screen/splash_screen.dart';
import 'package:heidi/src/presentation/main/welcome/welcome_screen.dart';
import 'package:heidi/src/utils/configs/language.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/language_manager.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:provider/provider.dart';

final globalNavKey = GlobalKey<NavigatorState>();

class GeraApp extends StatefulWidget {
  final Preferences prefBox;

  const GeraApp(
      this.prefBox, {
        super.key,
      });

  @override
  State<GeraApp> createState() => _GeraAppState();
}

class _GeraAppState extends State<GeraApp> {
  @override
  void initState() {
    super.initState();
    AppBloc.applicationCubit.onSetup();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => ListRepository(widget.prefBox),
        ),
        RepositoryProvider(
          create: (context) => ForumRepository(widget.prefBox),
        )
      ],
      child: MultiBlocProvider(
        providers: AppBloc.providers,
        child: BlocBuilder<LanguageCubit, Locale>(
          builder: (context, lang) {
            return BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, theme) {
                return ChangeNotifierProvider(
                  create: (_) => LanguageManager(),
                  child: MaterialApp(
                    navigatorKey: globalNavKey,
                    debugShowCheckedModeBanner: false,
                    theme: theme.lightTheme,
                    themeMode: ThemeMode.light,
                    darkTheme: theme.darkTheme,
                    onGenerateRoute: Routes.generateRoute,
                    localizationsDelegates: const [
                      Translate.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: AppLanguage.supportLanguage,
                    home: Scaffold(
                      body: BlocBuilder<ApplicationCubit, ApplicationState>(
                        builder: (context, state) {
                          if (state == const ApplicationState.onboardingLoaded()) {
                            return const WelcomeScreen();
                          }
                          if (state == const ApplicationState.loaded()) {
                            return const MainScreen();
                          }
                          if (state == const ApplicationState.loading()) {
                            return const SplashScreen();
                          }
                          return const MainScreen();
                        },
                      ),
                    ),
                    builder: (context, child) {
                      final data = MediaQuery.of(context).copyWith(
                        textScaler:
                        TextScaler.linear(theme.textScaleFactor ?? 1),
                      );
                      return MediaQuery(
                        data: data,
                        child: child!,
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
