import 'package:dev/providers/user_provider.dart';
import 'package:dev/utils/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  const ResponsiveLayout(
      {Key? key,
      required this.mobileScreenLayout,
      required this.webScreenLayout})
      : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
   UserProvider  _userProvider = Provider.of(context, listen: false);
   await _userProvider.refershUser();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, contaniers) {
      if (contaniers.maxWidth > webScreenSize) {
        return widget.webScreenLayout;
      }
      return widget.mobileScreenLayout;
    });
  }
}
