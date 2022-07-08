import 'package:change_money_cashier_app/di/get_it.dart';
import 'package:change_money_cashier_app/routes/fade_page_route_builder.dart';
import 'package:change_money_cashier_app/routes/route_constants.dart';
import 'package:change_money_cashier_app/routes/routes.dart';
import 'package:change_money_cashier_app/utils/colors.dart';
import 'package:change_money_cashier_app/utils/navigation_service.dart';
import 'package:change_money_cashier_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:change_money_cashier_app/di/get_it.dart' as getIt;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await getIt.init();
  GetIt.I.isReady<SharedPreferences>().then((_) {
    runApp(MyApp());
  });
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Change Money App',
              navigatorKey: getItInstance<NavigationService>().navigationKey,
              theme: ThemeData(
                unselectedWidgetColor: primaryColor,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                primaryColor: primaryColor,
                fontFamily: 'Poppins',
              ),
              builder: (context, child) {
                return child!;
              },
              initialRoute: RouteList.splash,
              onGenerateRoute: (RouteSettings settings) {
                final routes = Routes.getRoutes(settings);
                final WidgetBuilder builder = routes![settings.name]!;
                return FadePageRouteBuilder(
                  builder: builder,
                  settings: settings,
                );
              },
            );
          },
        );
      },
    );
  }
}

int diffInDays(DateTime date1, DateTime date2) {
  return ((date1.difference(date2) -
                  Duration(hours: date1.hour) +
                  Duration(hours: date2.hour))
              .inHours /
          24)
      .round();
}
