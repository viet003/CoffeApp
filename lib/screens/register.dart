import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: myColor,
        image: DecorationImage(
          image: const AssetImage("assets/images/bg.jpg"),
          fit: BoxFit.cover,
          colorFilter:
          ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(
            top: 80.0, // Make sure to use a double value with a decimal point
            child: FadeInUp(
              duration: Duration(milliseconds: 1000),
              child: _buildTop(),
            ),
          ),
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.coffee_rounded,
            size: 100,
            color: Colors.white,
          ),
          Text(
            "COFFEE",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
                letterSpacing: 2),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInUp(
            duration: Duration(milliseconds: 1100),
            child: Text(
              "Đăng ký",
              style: TextStyle(
                  color: myColor, fontSize: 32, fontWeight: FontWeight.w500),
            )),
        FadeInUp(
          duration: Duration(milliseconds: 1200),
          child: _buildGreyText("Welcome to our project! Let's Signup"),
        ),
        const SizedBox(height: 40),
        FadeInUp(
          duration: Duration(milliseconds: 1300),
          child: _buildGreyText("User name"),
        ),
        FadeInUp(
          duration: Duration(milliseconds: 1400),
          child: _buildInputField(userNameController),
        ),
        const SizedBox(height: 30),
        FadeInUp(
          duration: Duration(milliseconds: 1500),
          child: _buildGreyText("Email address"),
        ),
        FadeInUp(
          duration: Duration(milliseconds: 1600),
          child: _buildInputField(emailController),
        ),
        const SizedBox(height: 30),
        FadeInUp(
          duration: Duration(milliseconds: 1700),
          child: _buildGreyText("Password"),
        ),
        FadeInUp(
          duration: Duration(milliseconds: 1800),
          child: _buildInputField(passwordController, isPassword: true),
        ),
        const SizedBox(height: 30),
        FadeInUp(
          duration: Duration(milliseconds: 1900),
          child: _buildSignUpButton(),
        ),
        const SizedBox(height: 30,),
        FadeInUp(
          duration: Duration(milliseconds: 2000),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGreyText("or"),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Login')
              )
            ],
          )
        ),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("Email : ${emailController.text}");
        debugPrint("Password : ${passwordController.text}");
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("SIGN UP"),
    );
  }
}
