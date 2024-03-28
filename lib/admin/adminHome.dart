import 'package:animate_do/animate_do.dart';
import 'package:coffeeapp/admin/widgets/drawer.dart';
import 'package:coffeeapp/component/app_routes.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var height, width;
  late Color myColor;

  // list dataimages
  List<Icon> icons = [
    const Icon(
      Icons.supervised_user_circle,
      size: 80,
      color: Color(0xffC67C4E),
    ),
    const Icon(
      Icons.shopping_cart,
      size: 80,
      color: Color(0xffC67C4E),
    ),
    const Icon(
      Icons.add_chart,
      size: 80,
      color: Color(0xffC67C4E),
    ),
    const Icon(
      Icons.warehouse,
      size: 80,
      color: Color(0xffC67C4E),
    ),
    const Icon(
      Icons.access_alarm,
      size: 80,
      color: Color(0xffC67C4E),
    ),
    const Icon(
      Icons.accessibility_outlined,
      size: 80,
      color: Color(0xffC67C4E),
    )
  ];

  List titles = ["Người dùng", "Mặt hàng", "Thống kê", "null", "null", "null"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.dstATop),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          key: _scaffoldKey, // Assigning the GlobalKey here
          drawer: const DrawerWidget(),
          body: Stack(children: [
            Positioned(
              top: 0,
              child: FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: Container(
                  decoration: const BoxDecoration(),
                  height: height * 0.25,
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 50,
                          left: 20,
                          right: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                _scaffoldKey.currentState?.openDrawer();
                              },
                              child: const Icon(
                                Icons.sort,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/user.jpg"))),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 20,
                          left: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dashboard',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Last Update: 20/3/2024',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                child: FadeInUp(
                    duration: const Duration(milliseconds: 1200),
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: const BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        width: width,
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.1,
                              mainAxisSpacing: 25,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        Navigator.pushNamed(
                                            context, Routes.user);
                                        break;
                                      case 1:
                                        Navigator.pushNamed(
                                            context, Routes.product);
                                        break;
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 20),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black26,
                                            spreadRadius: 1,
                                            blurRadius: 6,
                                          )
                                        ]),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        icons[index],
                                        Text(
                                          titles[index],
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black
                                                  .withOpacity(0.6)),
                                        )
                                      ],
                                    ),
                                  ));
                            }),
                      ),
                    )))
          ]),
        ));
  }
}
