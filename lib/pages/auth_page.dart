import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/app_parts/form_box.dart';
import 'package:untitled/custom_widjets/custom_buttons/custom_elevated_button.dart';
import 'package:untitled/custom_widjets/custom_texts/time_text.dart';
import 'package:untitled/custom_widjets/custom_texts/title_text.dart';
import 'package:untitled/helpers/dimensions.dart';
import 'package:untitled/pages/home_page.dart';
import 'package:untitled/states/main_state.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  void showError(BuildContext context, String error, bool message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 1500),
        backgroundColor: message ? Colors.green : Colors.red,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimeText(
              text: error,
              fontSize: Dimensions.size(18),
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final users = FirebaseFirestore.instance.collection('users');
    final state = Provider.of<MainState>(context);
    TextEditingController idController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    void addUserData(String email, String id, String uid) {
      users.doc(uid).set({
        'box1': {
          'weeks': {
            'week1': {'data': [], 'state': false},
            'week2': {'data': [], 'state': false},
            'week3': {'data': [], 'state': false},
            'week4': {'data': [], 'state': false},
            'week5': {'data': [], 'state': false},
            'week6': {'data': [], 'state': false},
            'week7': {'data': [], 'state': false}
          },
          'state': false,
          'title': 'medicament',
          'open': false,
          'close': false
        },
        'box2': {
          'weeks': {
            'week1': {'data': [], 'state': false},
            'week2': {'data': [], 'state': false},
            'week3': {'data': [], 'state': false},
            'week4': {'data': [], 'state': false},
            'week5': {'data': [], 'state': false},
            'week6': {'data': [], 'state': false},
            'week7': {'data': [], 'state': false}
          },
          'state': false,
          'title': 'medicament',
          'open': false,
          'close': false
        },
        'box3': {
          'weeks': {
            'week1': {'data': [], 'state': false},
            'week2': {'data': [], 'state': false},
            'week3': {'data': [], 'state': false},
            'week4': {'data': [], 'state': false},
            'week5': {'data': [], 'state': false},
            'week6': {'data': [], 'state': false},
            'week7': {'data': [], 'state': false}
          },
          'state': false,
          'title': 'medicament',
          'open': false,
          'close': false
        },
        'box4': {
          'weeks': {
            'week1': {'data': [], 'state': false},
            'week2': {'data': [], 'state': false},
            'week3': {'data': [], 'state': false},
            'week4': {'data': [], 'state': false},
            'week5': {'data': [], 'state': false},
            'week6': {'data': [], 'state': false},
            'week7': {'data': [], 'state': false}
          },
          'state': false,
          'title': 'medicament',
          'open': false,
          'close': false
        },
        'box5': {
          'weeks': {
            'week1': {'data': [], 'state': false},
            'week2': {'data': [], 'state': false},
            'week3': {'data': [], 'state': false},
            'week4': {'data': [], 'state': false},
            'week5': {'data': [], 'state': false},
            'week6': {'data': [], 'state': false},
            'week7': {'data': [], 'state': false}
          },
          'state': false,
          'title': 'medicament',
          'open': false,
          'close': false
        },
        'box6': {
          'weeks': {
            'week1': {'data': [], 'state': false},
            'week2': {'data': [], 'state': false},
            'week3': {'data': [], 'state': false},
            'week4': {'data': [], 'state': false},
            'week5': {'data': [], 'state': false},
            'week6': {'data': [], 'state': false},
            'week7': {'data': [], 'state': false}
          },
          'state': false,
          'title': 'medicament',
          'open': false,
          'close': false
        },
        'email': email,
        'id': id,
        'uid': uid,
      });
    }

    void clearAll() {
      idController.clear();
      emailController.clear();
      passwordController.clear();
    }

    Future<void> createUser(String email, String password, String id) async {
      state.changeisLoading();
      final doc =
          await FirebaseFirestore.instance.collection('id').doc('1').get();
      List ids = doc.get('ids');
      bool condition = ids.contains(id);
      if (condition == false) {
        // ignore: use_build_context_synchronously
        showError(context, "invaled id", false);
        state.changeisLoading();
        idController.clear();
        return;
      }
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          state.changeisLoading();
          clearAll();
          // ignore: use_build_context_synchronously
          showError(context, 'The password provided is too weak!', false);
          return;
        } else if (e.code == 'email-already-in-use') {
          state.changeisLoading();
          // ignore: use_build_context_synchronously
          showError(context, 'The account already exists ', false);
          clearAll();
          return;
        } else {
          state.changeisLoading();

          // ignore: use_build_context_synchronously
          showError(context, 'invalid email!', false);
          return;
        }
      }
      final userUid = FirebaseAuth.instance.currentUser!.uid;
      addUserData(email, id, userUid.toString());
      state.changeisLoading();
      // ignore: use_build_context_synchronously
      showError(context, "Registration done!", true);
      state.changeRegister();
      clearAll();
    }

    Future<void> signIn(String email, String password) async {
      state.changeisLoading();
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          state.changeisLoading();

          showError(context, "email not found !", false);
          return;
        } else if (e.code == 'wrong-password') {
          state.changeisLoading();

          showError(context, "wrong password !", false);
          return;
        } else {
          state.changeisLoading();

          showError(context, "invalid email or password!", false);
          return;
        }
      }
      state.changeisLoading();
      final userUid = FirebaseAuth.instance.currentUser!.uid.toString();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomePage(userUid: userUid)));
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(Dimensions.size8),
            alignment: Alignment.bottomLeft,
            width: double.maxFinite,
            height: Dimensions.height(300),
            decoration: const BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dimensions.height(70),
                ),
                TitleText(
                  text: state.register ? "Sign in" : "Log in",
                  fontSize: Dimensions.size(35),
                  color: Colors.white,
                ),
                SizedBox(
                  height: Dimensions.height(15),
                ),
                TimeText(
                  text: "Welcome  ",
                  fontSize: Dimensions.size(20),
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(Dimensions.size8),
              width: double.maxFinite,
              height: Dimensions.height(600),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    Dimensions.size(50),
                  ),
                  topLeft: Radius.circular(
                    Dimensions.size(50),
                  ),
                ),
              ),
              child: SingleChildScrollView(
                child: state.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: Dimensions.height(30),
                          ),
                          TitleText(
                              text: "Health Box",
                              fontSize: Dimensions.size(40)),
                          SizedBox(
                            height: Dimensions.height(50),
                          ),
                          state.register
                              ? FormBox(
                                  hint: "id",
                                  icon: Icons.abc,
                                  controller: idController,
                                )
                              : const SizedBox(),
                          FormBox(
                            hint: "email",
                            icon: Icons.email,
                            controller: emailController,
                          ),
                          FormBox(
                            hint: "password",
                            icon: Icons.lock,
                            controller: passwordController,
                          ),
                          SizedBox(
                            height: Dimensions.height(50),
                          ),
                          CustomElevatedButton(
                              text: state.register ? "register" : "Log in",
                              width: Dimensions.width(130),
                              height: Dimensions.height(60),
                              onPressed: state.register
                                  ? () {
                                      createUser(
                                          emailController.text,
                                          passwordController.text,
                                          idController.text);
                                    }
                                  : () {
                                      signIn(emailController.text,
                                          passwordController.text);
                                      clearAll();
                                    }),
                          SizedBox(
                            height: Dimensions.height(60),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TimeText(
                                text: state.register
                                    ? "you have an account ?"
                                    : "you didn't register yet ?",
                                fontSize: Dimensions.size(20),
                              ),
                              TextButton(
                                onPressed: () {
                                  state.changeRegister();
                                },
                                child: TimeText(
                                  text: state.register ? "Log in" : "register",
                                  fontSize: Dimensions.size(20),
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
