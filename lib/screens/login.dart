import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -40,
                    height: 400,
                    width: width,
                    child: FadeInUp(duration: Duration(seconds: 1), child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/loginimg.webp'),
                              fit: BoxFit.fill
                          )
                      ),
                    )),
                  ),
                  Positioned(
                    height: 400,
                    width: width+20,
                    child: FadeInUp(duration: Duration(milliseconds: 1000), child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/background-2.png'),
                              fit: BoxFit.fill
                          )
                      ),
                    )),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
                mainAxisAlignment: MainAxisAlignment.start, // Align column to the start
                mainAxisSize: MainAxisSize.min, // Minimize the vertical size
                children: <Widget>[
                  FadeInUp(duration:const Duration(milliseconds: 1500), child: Text("Login", style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),)),
                  const SizedBox(height: 30,),
                  FadeInUp(duration: const Duration(milliseconds: 1700), child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email address"
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Mật khẩu"
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                  SizedBox(height: 20,),
                  FadeInUp(duration: Duration(milliseconds: 1700), child: Center(child: TextButton(onPressed: () {}, child: Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(196, 135, 198, 1)),)))),
                  SizedBox(height: 30,),
                  FadeInUp(duration: Duration(milliseconds: 1900), child: MaterialButton(
                    onPressed: () {},
                    color: Color.fromRGBO(49, 39, 79, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height: 50,
                    child: Center(
                      child: Text("Login", style: TextStyle(color: Colors.white),),
                    ),
                  )),
                  SizedBox(height: 30,),
                  FadeInUp(duration: Duration(milliseconds: 2000), child: Center(child: TextButton(onPressed: () {}, child: Text("Create Account", style: TextStyle(color: Color.fromRGBO(49, 39, 79, .6)),)))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
