import 'package:fitness_buddy/pages/login/login_page.dart';
import 'package:fitness_buddy/pages/profile/account_info.dart';
import 'package:fitness_buddy/pages/profile/delete_account.dart';
import 'package:fitness_buddy/pages/profile/notifications_config.dart';
import 'package:fitness_buddy/pages/profile/personal_info.dart';
import 'package:fitness_buddy/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';

class ProfileNavigator extends StatefulWidget {
 

  const ProfileNavigator({super.key});

  @override
  State<ProfileNavigator> createState() => _ProfileNavigatorState();
}



GlobalKey<NavigatorState> _profileNavigatorKey = GlobalKey<NavigatorState>();
class _ProfileNavigatorState extends State<ProfileNavigator> {
  

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _profileNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return const ProfilePage();
                case '/accountInfoView':
                  return  const AccountInfoView();
                case '/accountInfoChange':
                  return  const AccountInfoChange();
                case '/personalInfo':
                  return  const PersonalInfo();
                case '/deleteAccount':
                  return const DeleteAccount();
                case '/changeNotifications':
                  return const ChangeNotifications();
                case '/logoff':
                  return const LoginPage();
                default:
                  return const ProfilePage();
              }
            });
      },
    );
  }

}
