
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/auth_services_google.dart';
import 'package:productivity_app/my_textfield.dart';
import 'package:productivity_app/my_button.dart';
import 'package:productivity_app/square_box.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final  emailController = TextEditingController();

  final  passwordController = TextEditingController();

  final  confirmpasswordController = TextEditingController();

  // New user Sign up
  void signUserUp() async {
    // To show loading circle
    showDialog(context: context, builder: (context) {
      return const Center(child: CircularProgressIndicator(),);
    },
    );
    // try sign up
    try{
      if(passwordController.text == confirmpasswordController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
      } else {
        showErrorMessage();
        Navigator.pop(context);
      }
      Navigator.pop(context);

    } on FirebaseAuthException catch (error){
      Navigator.pop(context);
      if(error.code == 'user-not-found'){

        wrongEmailMessage();

      } else if (error.code == 'wrong-password'){
        wrongPasswordMessage();
      }
    }


  }


  void wrongEmailMessage(){
    showDialog(context: context, builder: (context){
      return AlertDialog(title: const Text('Wrong Email Entered'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.grey[400],
        elevation: 30.0,
      );
    }
    );
  }

  void showErrorMessage(){
    showDialog(context: context, builder: (context){
      return AlertDialog(title: const Text('Passwords Do not match!!'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.grey[400],
        elevation: 30.0,
      );
    }
    );
  }
  void wrongPasswordMessage(){
    showDialog(context: context, builder: (context){
      return const AlertDialog(title: Text('Wrong Password Entered'),);
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children:  [
                // logo
                const SizedBox(height: 30,),
                const Text('Care Dally',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
                const SizedBox(height: 30,),
                // welcome
                const Text('Create An Account ',
                    style: TextStyle(color: Colors.white,
                      fontSize: 20,
                    )
                ),
                // const SizedBox(height: 1,),
                // const Text('Productive World',
                //     style: TextStyle(color: Colors.black,
                //       fontSize: 20,
                //     )
                // ),
                const SizedBox(height: 35,),

                // username
                MyTextField(
                  controller: emailController,
                  hintText: 'email@gmail.com',
                  obscureText: false,
                ),
                const SizedBox(height: 10,),
                // password

                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10,),
                // confirm password
                MyTextField(
                  controller: confirmpasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10,),
                // forgot password
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: const [
                //       Text('Forgot Password?'),
                //     ],
                //   ),
                // ),

                const SizedBox(height: 10,),


                // sign in

                MyButton(
                  text: 'Sign Up!',
                  onTap: signUserUp,
                ),
                const SizedBox(height: 50,),

                // or continue with

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children:  [
                      Expanded(child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      )),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text('Or continue with',
                                style: TextStyle(color: Colors.white),),
                      ),

                      Expanded(child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ))

                    ],
                  ),
                ),
                const SizedBox(height: 25,),

                // google and apple sign-in buttons

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(imagePath:'lib/images/google_logo.png' ,
                    onTap: () => AuthService().signInWithGoogle(),
                    ),
                    const SizedBox(width: 25,),
                    // apple button
                    SquareTile(imagePath:'lib/images/apple_logo.png' ,
                    onTap: () {},
                    ),

                  ],),
                const SizedBox(height: 25,),

                // not a member register now?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an Account?', style: TextStyle(color: Colors.white),),
                    const SizedBox(width: 5,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text('Login!', style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white
                      ),),
                    )


                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

