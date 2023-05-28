// import 'package:flutter/foundation.dart';
import 'package:chatx/pages/auth/register_page.dart';
import 'package:chatx/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../helper/helper_function.dart';
import '../../services/database_service.dart';
import '../../widgets/widgets.dart';
import '../home_page.dart';
// import 'package:CHATX/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _isLoading = false;
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).primaryColor,
      // ),
      body: _isLoading ? Center(child: CircularProgressIndicator(color:Theme.of(context).primaryColor)) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 80),
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                  
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "While",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  
                  const SizedBox(height: 10,),
            
                  const Text(
                    "Login to unlock possibilities",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400
                    ),
                  ),
            
                  const SizedBox(height: 20,),
            
                  const CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.person_3_rounded,
                      color: Colors.white,
                      size: 70,
                    )
                  ),

                  const SizedBox(height: 40),

                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      labelText: "Email",
                      prefixIcon: const Icon(
                        Icons.email,
                        color: const Color.fromARGB(255, 48, 47, 47),
                      )
                    ),
                    onChanged: (val) {
                      setState(() {
                        email = val;
                        // print(email);
                      });


                    },

                    validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!)
                                ? null
                                : "Please enter a valid email";
                          },

                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(
                      labelText: "Password",
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color.fromARGB(255, 48, 47, 47),
                      )
                    ),

                    validator: (val) {
                      if(val!.length<6){
                        return "Password must be atleast 6 characters long";
                      }
                      else{
                        return null;
                      }
                    },

                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),

                  const SizedBox(height: 20,),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                        )
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                        ),
                      ),

                      onPressed: (){
                        login();
                      },
                    ),
                  ),

                  const SizedBox(height: 10,),

                  Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      children: <TextSpan>[
                        TextSpan(
                          text: "Register here",
                          style: const TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            nextScreen(context, const RegisterPage());
                          }
                        ),
                      ],
                      style: const TextStyle(color: Colors.black,fontSize: 14) 
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    if(formKey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });

      await authService.loginWithUserNameAndPassword( email, password).then((value) async {
        if (value == true) {
          
          QuerySnapshot snapshot = await DatabaseService(uid:FirebaseAuth.instance.currentUser!.uid).gettingUserData(email); 

          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(
            snapshot.docs[0]['fullName']
          );


          // saving the shared preference state
          nextScreenReplace(context, const HomePage());
        }
        else{
          showSnackBar(context,const Color.fromARGB(255, 206, 94, 86),value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}