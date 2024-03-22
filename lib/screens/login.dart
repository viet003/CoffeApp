import 'package:animate_do/animate_do.dart';
import 'package:coffeeapp/component/app_routes.dart';
import 'package:coffeeapp/controller/loginController.dart';
import 'package:coffeeapp/models/loginModel.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:coffeeapp/controller/store.dart';
import 'package:coffeeapp/component/progressAPI.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool rememberUser = false;
  bool isApiCallProcess = false;
  late LoginRequestModel loginRequestModel;

  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel();
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
        body: progressAPI(
          child: Stack(children: [
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
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
        ),
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
              "Đăng nhập",
              style: TextStyle(
                  color: myColor, fontSize: 32, fontWeight: FontWeight.w500),
            )),
        FadeInUp(
          duration: Duration(milliseconds: 1200),
          child: _buildGreyText("Welcome to our project! Let's login"),
        ),
        const SizedBox(height: 40),
        FadeInUp(
          duration: Duration(milliseconds: 1300),
          child: _buildGreyText("Địa chỉ email"),
        ),
        FadeInUp(
          duration: Duration(milliseconds: 1400),
          child: _buildInputField(emailController),
        ),
        const SizedBox(height: 20),
        FadeInUp(
          duration: Duration(milliseconds: 1500),
          child: _buildGreyText("Mật khẩu"),
        ),
        FadeInUp(
          duration: Duration(milliseconds: 1600),
          child: _buildInputField(passwordController, isPassword: true),
        ),
        const SizedBox(height: 20),
        FadeInUp(
          duration: Duration(milliseconds: 1700),
          child: _buildRememberForgot(),
        ),
        const SizedBox(height: 10),
        FadeInUp(
          duration: Duration(milliseconds: 1800),
          child: _buildLoginButton(),
        ),
        const SizedBox(height: 10),
        FadeInUp(
          duration: Duration(milliseconds: 1900),
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
        suffixIcon: isPassword
            ? const Icon(Icons.remove_red_eye)
            : const Icon(Icons.done),
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

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
                value: rememberUser,
                onChanged: (value) {
                  setState(() {
                    rememberUser = value!;
                  });
                }),
            _buildGreyText("Lưu thông tin"),
          ],
        ),
        TextButton(
            onPressed: () => Navigator.pushNamed(
                  context,
                  Routes.forgot,
                ),
            child: const Text("Quên mật khẩu?"))
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          setState(() {
            isApiCallProcess = true;
          });
          loginRequestModel.email = emailController.text;
          loginRequestModel.password = passwordController.text;
          loginController loginCtr = new loginController();
          loginCtr.login(loginRequestModel).then((value) {
            setState(() {
              isApiCallProcess = false;
            });
            if (value.token.isNotEmpty) {
              Map<String, dynamic> decodedToken = Jwt.parseJwt(value.token);
              String role = decodedToken['role'];
              Store save = new Store();
              save.saveToken(value);
              if (role == 'admin') {
                Navigator.pushNamed(context, Routes.adminHome);
              } else {
                Navigator.pushNamed(context, Routes.home);
              }

              emailController.text = '';
              passwordController.text = '';
            } else {
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
                          Navigator.pop(context);
                        },
                        child: Text('Đóng'),
                      ),
                    ],
                  );
                },
              );
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
      child: const Text("Đăng nhập"),
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGreyText("Chưa có tài khoản?"),
              TextButton(
                  onPressed: () => Navigator.pushNamed(
                        context,
                        Routes.register,
                      ),
                  child: Text('Đăng ký')),
            ],
          ),
          const SizedBox(height: 5),
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
