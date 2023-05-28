// import 'package:firebase_core/firebase_core.dart';
import 'package:chatx/helper/helper_function.dart';
import 'package:chatx/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService{
  final firebaseAuth = FirebaseAuth.instance;
  // Login User

  Future loginWithUserNameAndPassword(String email,String password) async {
    try{

      User user = (await firebaseAuth.signInWithEmailAndPassword(email: email,password:password)).user!;
      if(user != null){
        // await DatabaseService(uid: user.uid).updateUserData(fullName, email);

        return true;
      }

    }on FirebaseAuthException catch(e){
      print(e);
      return e.message;
    }
  }



  // Register User

  Future registerUserWithEmailandPassword(String fullName,String email,String password) async {
    try{

      User user = (await firebaseAuth.createUserWithEmailAndPassword(email: email,password:password)).user!;
      if(user != null){
        await DatabaseService(uid: user.uid).savingUserData(fullName, email);

        return true;
      }

    }on FirebaseAuthException catch(e){
      print(e);
      return e.message;
    }
  }

  // Signout User
  Future signOut() async {
    try{
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");

      await firebaseAuth.signOut();
    } catch(e){
      return null;
    }
  }
}