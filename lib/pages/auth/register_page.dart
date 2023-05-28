import 'package:chatx/helper/helper_function.dart';
import 'package:chatx/pages/home_page.dart';
import 'package:chatx/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;

  final formKey = GlobalKey<FormState>();
  
  String email = "";
  String password = "";
  String fullName = "";
  AuthService authServce = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).primaryColor,
      // ),
      body: _isLoading ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)) : SingleChildScrollView(
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
                    "Register Here",
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
                      labelText: "Full Name",
                      prefixIcon: const Icon(
                        Icons.person,
                        color: const Color.fromARGB(255, 48, 47, 47),
                      )
                    ),

                    validator: (val){
                      if(val!.isNotEmpty){
                        return null;
                      }
                      else{
                        return "Name cannot b empty";
                      }
                    },
                    onChanged: (val) {
                      setState(() {
                        fullName = val;
                        // print(email);
                      });
                    },
                  ),

                  const SizedBox(height: 15,),
                  

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
                        "Reister",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                        ),
                      ),

                      onPressed: (){
                        register();
                      },
                    ),
                  ),

                  const SizedBox(height: 10,),

                  Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      children: <TextSpan>[
                        TextSpan(
                          text: "Login",
                          style: const TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            nextScreen(context, const LoginPage());
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
  register () async {
    if(formKey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });

      await authServce.registerUserWithEmailandPassword(fullName, email, password).then((value) async {
        if (value == true) {
          // saving the shared preference state
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(fullName);
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