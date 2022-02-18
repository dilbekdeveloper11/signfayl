import 'package:clay_containers/widgets/clay_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseapp/Provider/signupProvider.dart';
import 'package:firebaseapp/screens/homepage.dart';
import 'package:firebaseapp/widgets/Sizeconfig.dart';
import 'package:firebaseapp/widgets/Widgets.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _firebaseInit = Firebase.initializeApp();
  final FirebaseAuth _authUser = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final _initFireBase = Firebase.initializeApp();
    return Scaffold(
      appBar: NewGradientAppBar(
        centerTitle: true,
        title: Text('LOGIN PAGE'),
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.purple, Colors.redAccent],
        ),
      ),
      body: Widgets.padding(
        top: 70,
        left: 20,
        right: 20,
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Enter your Email/Phone Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (v) {
                  if (!RegExp(
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      .hasMatch(v!)) {
                    return "Email formati noto'g'ri !";
                  }
                },
              ),
              SizedBox(height: getH(20)),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator: (v) {
                  if (v!.length < 6) {
                    return "Iltimos kattaroq kod kiriting";
                  }
                },
              ),
              SizedBox(height: getH(70)),
              InkWell(
                child: Container(
                  width: getW(380),
                  height: getH(55),
                  child: const Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: const GradientBoxBorder(
                        gradient: LinearGradient(
                            colors: [Colors.green, Colors.orange]),
                        width: 4,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                ),
                onTap: () async{
                  if (_formkey.currentState!.validate()) {
                   await SignUp()
                        .signup(context,
                             _emailController.text,  _passwordController.text)
                        .then((value) {
                      if (value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "ROYXATDAN MUVAFFAQQIYATLI OTGANINGIZ BILAM TABRIKLAYMAN"),
                          ),
                        );
                      } else {
                        print("ERROR");
                      }
                    });
                  }
                },
              ),
              SizedBox(height: getH(10)),
              Container(
                width: getW(380),
                height: getH(55),
                child: const Center(
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.amber,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                decoration: BoxDecoration(
                    border: const GradientBoxBorder(
                      gradient:
                          LinearGradient(colors: [Colors.black, Colors.yellow]),
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(12)),
              ),
              SizedBox(height: getH(10)),
              Container(
                width: getW(380),
                height: getH(55),
                child: const Center(
                  child: Text(
                    "Phone number send sms",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                decoration: BoxDecoration(
                    border: const GradientBoxBorder(
                      gradient: LinearGradient(
                          colors: [Colors.blueGrey, Colors.brown]),
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signUpWithEmailAndPassword(String e, String p) async {
    try {
      UserCredential _credential =
          await _authUser.createUserWithEmailAndPassword(email: e, password: p);
      User? _user = _credential.user;
      await _user!.sendEmailVerification();
      debugPrint("User: ${_user.email}");
      return _user;
    } catch (e) {
      print("User sign up error: $e");
    }
  }

  Future<bool?> signIn(String e, String p) async {
    if (_authUser.currentUser == null) {
      try {
        UserCredential? _signedUser =
            await _authUser.signInWithEmailAndPassword(email: e, password: p);
        return true;
      } catch (e) {
        print("Error: $e");
        return false;
      }
    }
  }

  Future resetPassword() async {
    String? email = "dilbekbaxtiyorov23@gmail.com";

    try {
      await _authUser.sendPasswordResetEmail(email: email);
      debugPrint("Email jonatildi parol tiklash uchun");
      return true;
    } catch (e) {
      print("$e");
    }
  }

  Future verifySms() async {
    await _authUser.verifyPhoneNumber(
        phoneNumber: _emailController.text,
        verificationCompleted: (v) {
          debugPrint("Muvaffaqqiyatli yakunlandiiiiiiiiii");
        },
        verificationFailed: (v) {
          debugPrint("Kod jonatilmadiiiiiiiiiiiii");
        },
        codeSent: (verificationId, resendToken) async {
          debugPrint("Kod jonatildiiiiiiiiii");
          String code = "112233";

          PhoneAuthCredential _phoneCredential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: code);
          await _authUser.signInWithCredential(_phoneCredential);
        },
        codeAutoRetrievalTimeout: (verificationId) {});
  }
}
