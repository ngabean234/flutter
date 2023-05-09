import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_login/home.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController passwordvalcontroller = TextEditingController();

  bool errorValidation = false;

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("SignUp Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'images/lion.jpg',
                width: 500,
                height: 200,
              ),
              Text("Email"),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Tuliskan Email",
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("Password"),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                obscureText: true,
                controller: passwordcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Tuliskan Password",
                  errorText: errorValidation ? "Password Tidak Sama" : null,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("Validasi Password"),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                obscureText: true,
                controller: passwordvalcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Tuliskan Password",
                  errorText: errorValidation ? "Password Tidak Sama" : null,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      passwordcontroller.text == passwordvalcontroller.text
                          ? errorValidation = false
                          : errorValidation = true;
                    });
                    if (errorValidation) {
                      print("Eror");
                    } else {
                      signUp();
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Daftar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
