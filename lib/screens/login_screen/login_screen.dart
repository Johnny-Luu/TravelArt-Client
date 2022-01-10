import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/app.dart';
import 'package:travelapp/screens/home_screen/home_screen.dart';
import 'package:travelapp/screens/login_screen/signup_screen.dart';
import 'package:travelapp/services/user_services.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var firebaseAuth = AuthenticationService(FirebaseAuth.instance);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isPasswordHidden = true;

  void onLogIn() async {
    var email = emailController.text;
    var password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      // TODO: HANDLE EMPTY FIELDS HERE
      print("empty");
      return;
    }

    bool result = await firebaseAuth.LogIn(email, password);

    if (result) {
      // TODO: HANDLE LOGIN SUCCESSFUL HERE
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => App()));
    } else {
      // TODO: HANDLE LOGIN FAILED HERE
      print("login failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/img-login-background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                "Login",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF3b4859),
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: emailController,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Email",
                    prefixIcon: Icon(
                      FontAwesomeIcons.userAlt,
                      size: 20,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: passwordController,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: isPasswordHidden,
                  cursorColor: Colors.black,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Password",
                    prefixIcon: const Icon(
                      FontAwesomeIcons.lock,
                      size: 20,
                      color: Colors.black54,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordHidden
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        size: 20,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordHidden = !isPasswordHidden;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    "forgot password?",
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: onLogIn,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3b4859),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()));
                    },
                    child: const Text(
                      "Signup",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
