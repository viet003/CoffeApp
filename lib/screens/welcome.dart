import 'package:coffeeapp/component/app_routes.dart';
import 'package:coffeeapp/controller/store.dart';
import 'package:coffeeapp/screens/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decode/jwt_decode.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final store = new Store();
  late Map<String, dynamic> decodedToken = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> _initializeStateAsync() async {
    String value = await store.getToken();
    if (value != '') {
      decodedToken = Jwt.parseJwt(value);
      if (decodedToken['role'] == 'admin') {
        Navigator.pushNamed(context, Routes.adminHome);
      } else {
        Navigator.pushNamed(context, Routes.home);
      }
    } else {
      Navigator.pushNamed(context, Routes.login);
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: size.height * 1,
              width: size.width,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg1.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Cà phê – khơi dậy\n niềm đam mê",
                    style: GoogleFonts.sora(
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: size.height * 0.010,
                  ),
                  Text(
                    "Ở đây có cà phê được pha một cách hạnh phúc,\n được phục vụ với tình yêu",
                    style: GoogleFonts.sora(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFA9A9A9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: size.height * 0.030,
                  ),
                  Container(
                    height: 62,
                    width: size.width * 0.80,
                    child: CustomButton(
                      title: 'Get Started',
                      onPressed: () => {
                        _initializeStateAsync()
                      }
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.030,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
