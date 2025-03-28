import 'package:flutter/cupertino.dart';

class CupertinoTaskScreen extends StatelessWidget {
  const CupertinoTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(home: ProfilePage());
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Profile Page"),
        leading: CupertinoNavigationBarBackButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(context);
          },
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 10,
            children: [
              CupertinoTextField(
                placeholder: "Name",

                prefix: Icon(CupertinoIcons.person),
              ),
              CupertinoTextField(
                placeholder: "Email",
                prefix: Icon(CupertinoIcons.mail),
              ),
              Row(
                children: [
                  Icon(CupertinoIcons.moon),
                  SizedBox(width: 5),
                  Text("Toggle dark mode"),
                  Spacer(),
                  CupertinoSwitch(
                    value: _isDarkTheme,
                    onChanged: (value) {
                      setState(() {
                        _isDarkTheme = value;
                      });
                    },
                  ),
                ],
              ),

              Row(
                children: [
                  Text("I agree to the terms and conditions."),
                  Spacer(),
                  CupertinoCheckbox(
                    value: _isDarkTheme,
                    onChanged: (value) {
                      setState(() {
                        _isDarkTheme = value ?? false;
                      });
                    },
                  ),
                ],
              ),

              CupertinoButton(
                child: Text("Save Changes"),
                onPressed: () {
                  showCupertinoDialog(
                    context: context,
                    builder:
                        (context) => CupertinoAlertDialog(
                          title: Text("Save changes"),
                          content: Text("Are you sure do you want to save?"),
                          actions: [
                            CupertinoDialogAction(
                              child: Text("Yes"),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => ProfileScreen(),
                                  ),
                                );
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text("No"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text("Profile Screen")),
      child: SafeArea(
        child: Center(child: CupertinoActivityIndicator(radius: 30)),
      ),
    );
  }
}
