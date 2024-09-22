import 'package:fitness_buddy/pages/profile/account_info.dart';
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
                case '/accountInfo':
                  return  const AccountInfo();
                case '/personalInfo':
                  return  const PersonalInfo();
                default:
                  return const ProfilePage();
              }
            });
      },
    );
  }

}
