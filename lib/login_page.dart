import 'package:flutter/material.dart';
import 'package:parsec/Square_box.dart';
import 'package:parsec/my_button.dart';
import 'package:parsec/my_textfield.dart';

class LoginPage extends StatelessWidget {
   LoginPage({Key? key}) : super(key: key);

  // text editing controllers
  final  usernameController = TextEditingController();
  final  passwordController = TextEditingController();

  // Sign user in
   void signUserIn() {}
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children:  [
              // logo
              const SizedBox(height: 70,),
              const Icon(Icons.directions_bus,
              size: 100,),
              const SizedBox(height: 30,),

              // welcome
              const Text('Welcome to Hubli-Dharwad',
                style: TextStyle(color: Colors.black,
                fontSize: 20,
                )
              ),
              const SizedBox(height: 1,),
              const Text('Bus Rapid Transit System',
                  style: TextStyle(color: Colors.black,
                    fontSize: 20,
                  )
              ),
              const SizedBox(height: 25,),

              // username
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
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
              // forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text('Forgot Password?'),
                  ],
                ),
              ),

              const SizedBox(height: 10,),


              // sign in

              MyButton(
                onTap: signUserIn,
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
                      child: Text('Or continue with'),
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
                children: const [
                // google button
                SquareTile(imagePath:'lib/images/google_logo.png' ,),
                  SizedBox(width: 25,),
                // apple button
                SquareTile(imagePath:'lib/images/apple_logo.png' ,),

              ],),
              const SizedBox(height: 25,),

              // not a member register now?
              const Text('Not a member? Register now!')
            ],
          ),
        ),
      ),
    );
  }
}
