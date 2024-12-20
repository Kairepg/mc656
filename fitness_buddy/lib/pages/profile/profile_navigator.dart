import 'package:fitness_buddy/pages/profile/account_info/account_info_change_page.dart';
import 'package:fitness_buddy/pages/profile/account_info/account_info_page.dart';
import 'package:fitness_buddy/pages/profile/delete_account/delete_account_page.dart';
import 'package:fitness_buddy/pages/profile/menu/menu_navigator_page.dart';
import 'package:fitness_buddy/pages/profile/notifications_config/notifications_config_page.dart';
import 'package:fitness_buddy/pages/profile/personal_info/personal_info_change_page.dart';
import 'package:fitness_buddy/pages/profile/personal_info/personal_info_view_page.dart';
import 'package:flutter/material.dart';

class ProfileNavigator extends StatefulWidget {
  const ProfileNavigator({super.key});

  @override
  State<ProfileNavigator> createState() => _ProfileNavigatorState();
}

GlobalKey<NavigatorState> _profileNavigatorKey = GlobalKey<NavigatorState>();

class _ProfileNavigatorState extends State<ProfileNavigator> {
  BuildContext? contexto;

  @override
  void initState() {
    super.initState();
    contexto = context;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _profileNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext contextNavigator) {
              switch (settings.name) {
                case '/menu':
                  return MenuNavigatorPage(contextRotasTema: context);
                case '/accountInfoView':
                  return const AccountInfoViewPage();
                case '/accountInfoChange':
                  return const AccountInfoChangePage();
                case '/personalInfoView':
                  return const PersonalInfoViewPage();
                case '/personalInfoChange':
                  return const PersonalInfoChangePage();
                case '/deleteAccount':
                  return const DeleteAccount();
                case '/changeNotifications':
                  return const ChangeNotifications();
                default:
                  return MenuNavigatorPage(contextRotasTema: contexto);
              }
            });
      },
    );
  }
}
