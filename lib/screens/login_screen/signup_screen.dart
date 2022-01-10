import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/services/user_services.dart';
import 'package:travelapp/widgets/error_snackbar.dart';
import 'package:travelapp/widgets/success_snackbar.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var firebaseAuth = AuthenticationService(FirebaseAuth.instance);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var isPasswordHidden = true;
  var isConfirmPasswordHidden = true;

  void onSignUp() async {
    var name = nameController.text;
    var email = emailController.text;
    var password = passwordController.text;
    var confirmPassword = confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ErrorSnackbar.show(context, 'Please fulfill all infomation!');
      return;
    }

    if (password != confirmPassword) {
      ErrorSnackbar.show(context, 'Password not matching!');
      return;
    }

    var result = await firebaseAuth.SignUp(name, email, password);

    if (result) {
      SuccessSnackbar.show(context, 'Signup successfully!');
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    } else {
      ErrorSnackbar.show(context, 'Signup failed, try again!');
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
                "Signup",
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
                  controller: nameController,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Name",
                    prefixIcon: Icon(
                      FontAwesomeIcons.user,
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
                      FontAwesomeIcons.envelope,
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
                  controller: confirmPasswordController,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: isConfirmPasswordHidden,
                  cursorColor: Colors.black,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Confirm Password",
                    prefixIcon: const Icon(
                      FontAwesomeIcons.lock,
                      size: 20,
                      color: Colors.black54,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isConfirmPasswordHidden
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        size: 20,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        setState(() {
                          isConfirmPasswordHidden = !isConfirmPasswordHidden;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: onSignUp,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3b4859),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      "SIGNUP",
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
                    "Already have an account? ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Login",
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
