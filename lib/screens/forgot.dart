import 'package:animate_do/animate_do.dart';
import 'package:coffeeapp/controller/forgotController.dart';
import 'package:coffeeapp/models/forgotModel.dart';
import 'package:flutter/material.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late ForgotRequestModel forgotRequestModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forgotRequestModel = new ForgotRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor.withOpacity(0.8);
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        // color: myColor,
        image: DecorationImage(
          image: const AssetImage("assets/images/bg.jpg"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(myColor.withOpacity(0.5), BlendMode.dstATop),
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
          Positioned(
              bottom: 0,
              child: Form(
                key: _formKey,
                child: _buildBottom(),
              )),
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
      height: MediaQuery.of(context).size.height * 0.7,
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
              "Khôi phục mật khẩu",
              style: TextStyle(
                  color: myColor, fontSize: 32, fontWeight: FontWeight.w500),
            )),
        FadeInUp(
          duration: Duration(milliseconds: 1200),
          child: _buildGreyText("Bạn quên mật khẩu? Lấy lại"),
        ),
        const SizedBox(height: 60),
        FadeInUp(
          duration: Duration(milliseconds: 1300),
          child: _buildGreyText("Địa chỉ email"),
        ),
        FadeInUp(
          duration: Duration(milliseconds: 1400),
          child: _buildInputField(emailController),
        ),
        const SizedBox(height: 40),
        FadeInUp(
          duration: Duration(milliseconds: 1500),
          child: _buildForgotButton(),
        ),
        SizedBox(
          height: 50,
        ),
        FadeInUp(
          duration: Duration(milliseconds: 1600),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _buildGreyText("or"),
            TextButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  elevation: 20,
                ),
                child: Text('Đăng nhập'))
          ]),
        ),
        SizedBox(
          height: 10,
        ),
        FadeInUp(
          duration: Duration(milliseconds: 1700),
          child: _buildOtherLogin(),
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
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : Icon(Icons.done),
      ),
      obscureText: isPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Không được bỏ trống thông tin.';
        }
        return null;
      },
    );
  }

  Widget _buildForgotButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          forgotRequestModel.email = emailController.text;
          forgotController SignUpCtr = new forgotController();
          SignUpCtr.forgot(forgotRequestModel).then((value) => {
                if (value != null)
                  {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Thông báo'),
                          content: Container(
                            height: 100,
                            child: Column(
                              children: [Text(value.msg)],
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                if (value.err == 0) {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text('Đóng'),
                            ),
                          ],
                        );
                      },
                    ),
                  }
              });
        }
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("Submit"),
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildGreyText("Hoặc đăng nhập với"),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Tab(icon: Image.asset("assets/images/facebook.png")),
              const SizedBox(
                width: 20,
              ),
              Tab(icon: Image.asset("assets/images/twitter.png")),
              // Tab(icon: Image.asset("assets/images/github.png")),
            ],
          )
        ],
      ),
    );
  }
}
