import 'package:dev/resources/auth_methods.dart';
import 'package:dev/responsive/mobile_screen_layout.dart';
import 'package:dev/responsive/responsive_layout.dart';
import 'package:dev/responsive/web_screen_layout.dart';
import 'package:dev/screens/signup_screen.dart';
import 'package:dev/utils/colors.dart';
import 'package:dev/utils/util.dart';
import '/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  bool _isloading = false;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passcontroller.dispose();
  }

  void loginUser() async {
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailcontroller.text, password: _passcontroller.text);

    if (res == 'success') {
      showSnakBar(res, context);
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout());
          },
        ),
      );
    } else {
      showSnakBar(res, context);
    }
    setState(() {
      _isloading = false;
    });
  }

  void navigatorToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //
          //
          children: [
            Flexible(child: Container(), flex: 2),
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              color: primaryColor,
              height: 64,
            ),
            const SizedBox(height: 64),
            //
            //
            // Log In details
            TextfieldInput(
              hintText: 'Enter Your Email',
              isPass: false,
              textInputType: TextInputType.emailAddress,
              textEditingController: _emailcontroller,
            ),
            const SizedBox(height: 24),
            TextfieldInput(
              hintText: 'Enter Password',
              isPass: true,
              textInputType: TextInputType.text,
              textEditingController: _passcontroller,
            ),
            const SizedBox(height: 24),
            //
            //  login button
            InkWell(
              onTap: loginUser,
              child: Container(
                child: _isloading
                    ? const CircularProgressIndicator(
                        color: primaryColor,
                      )
                    : const Text('Log In'),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  color: blueColor,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Flexible(child: Container(), flex: 2),
            //
            //
            //  Sign Up details
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text("Don't have an account?"),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: navigatorToSignUp,
                  child: Container(
                    child: const Text(
                      " Sign Up",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    ));
  }
}
