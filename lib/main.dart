import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:quaderno_flutter/authentication/authentication.dart';
import 'package:quaderno_flutter/home/home.dart';
import 'package:quaderno_flutter/login/login.dart';
import 'package:quaderno_flutter/splash/splash.dart';

import 'package:quaderno_flutter/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var persistence = await Database.get('persistence');
  print(persistence);
  runApp(QuadernoTorneoApp(
    persistence: persistence,
    authenticationRepository: AuthenticationRepository(),
  ));
}

class QuadernoTorneoApp extends StatelessWidget {
  const QuadernoTorneoApp({
    Key key,
    this.persistence,
    @required this.authenticationRepository,
  })  : assert(authenticationRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final Map persistence;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
            authenticationRepository: authenticationRepository),
        child: AppView(persistence),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  final Map persistence;
  AppView(this.persistence);

  @override
  _AppViewState createState() => _AppViewState(persistence);
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final Map persistence;
  _AppViewState(this.persistence);

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(persistence),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
