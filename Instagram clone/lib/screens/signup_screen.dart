import 'dart:math';
import 'dart:typed_data';

import 'package:dev/resources/auth_methods.dart';
import 'package:dev/responsive/mobile_screen_layout.dart';
import 'package:dev/responsive/responsive_layout.dart';
import 'package:dev/responsive/web_screen_layout.dart';
import 'package:dev/screens/login_screen.dart';
import 'package:dev/utils/colors.dart';
import 'package:dev/utils/util.dart';
import '/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  final TextEditingController _biocontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  Uint8List? _image;
  bool _isloading = false;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passcontroller.dispose();
    _biocontroller.dispose();
    _usernamecontroller.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethods().SignUpUser(
      email: _emailcontroller.text,
      password: _passcontroller.text,
      username: _usernamecontroller.text,
      bio: _biocontroller.text,
      file: _image!,
    );
    print(res);

    setState(() {
      _isloading = false;
    });

    if (res == 'success') {
      showSnakBar(res, context);
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
  }

  void navigatorToLogIn() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
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
            const SizedBox(height: 24),
            // Circular widget for your image
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1433086966358-54859d0ed716?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                        ),
                      ),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ))
              ],
            ),
            SizedBox(
              height: 24,
            ),

            // Log In detail
            // username details
            TextfieldInput(
              hintText: 'Enter your username',
              textInputType: TextInputType.text,
              textEditingController: _usernamecontroller,
            ),
            const SizedBox(height: 24),
            //
            //  email details
            TextfieldInput(
              hintText: 'Enter Your Email',
              isPass: false,
              textInputType: TextInputType.emailAddress,
              textEditingController: _emailcontroller,
            ),
            const SizedBox(height: 24),
            //
            //  password details
            TextfieldInput(
              hintText: 'Create Password',
              isPass: true,
              textInputType: TextInputType.text,
              textEditingController: _passcontroller,
            ),
            const SizedBox(height: 24),
            //
            // bio details
            TextfieldInput(
              hintText: 'Enter Bio',
              textInputType: TextInputType.text,
              textEditingController: _biocontroller,
            ),
            const SizedBox(height: 24),
            //
            // sign up details
            InkWell(
              onTap: signUpUser,
              child: Container(
                child: _isloading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('Sign Up'),
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
                  child: const Text("Already have an account?"),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: navigatorToLogIn,
                  child: Container(
                    child: const Text(
                      " Log In",
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
