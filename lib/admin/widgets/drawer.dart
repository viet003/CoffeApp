import 'package:coffeeapp/controller/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  Store store = Store();
  late String token;
  late Map<String, dynamic> decodedToken = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getToken();
  }

  Future<void> _getToken() async {
    String value = await store.getToken();
    setState(() {
      decodedToken = Jwt.parseJwt(value);
    });
  }

  Future<void> _logout(BuildContext context) async {
    await store.deleteToken();
    Navigator.pop(context);
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage("assets/images/bg1.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.8), // Thay đổi thành màu đen
                    BlendMode.dstATop,
                  ),
                ),
              ),
              child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 80,
                          height: 80,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/user.jpg'),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${decodedToken['username']}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                )),
                            Text('${decodedToken['email']}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ))
                          ],
                        )
                      ],
                    ),
                  ))),
          const ListTile(
            leading: Icon(
              CupertinoIcons.home,
              color: Colors.orange,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const ListTile(
            leading: Icon(
              CupertinoIcons.person,
              color: Colors.orange,
            ),
            title: Text(
              'My Account',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const ListTile(
            leading: Icon(
              CupertinoIcons.cart_fill,
              color: Colors.orange,
            ),
            title: Text(
              'My Orders',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.favorite,
              color: Colors.orange,
            ),
            title: Text(
              'My Wist List',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const ListTile(
            leading: Icon(
              CupertinoIcons.settings,
              color: Colors.orange,
            ),
            title: Text(
              'Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _logout(context);
            },
            child: const ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.orange,
              ),
              title: Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
