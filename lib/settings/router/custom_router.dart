import 'package:auto_route/annotations.dart';
import '../../weight_tracking/presentation/ui/screens/auth_screen.dart';
import '../../weight_tracking/presentation/ui/screens/home_screen.dart';
import '../../weight_tracking/presentation/ui/screens/register_screen.dart';
import '../../weight_tracking/presentation/ui/screens/splash_screen.dart';


@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
    routes: <AutoRoute>[
      AutoRoute(page: SplashScreen,initial: true),
      AutoRoute(page: HomeScreen),
      AutoRoute(page: AuthScreen),
      AutoRoute(page: RegisterScreen),
    ]
)
class $AppRouter {}