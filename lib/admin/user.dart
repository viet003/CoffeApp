import 'package:coffeeapp/component/progressAPI.dart';
import 'package:coffeeapp/controller/userController.dart';
import 'package:flutter/material.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  int currentPage = 0;
  int itemsPerPage = 10; // Số phần tử trên mỗi trang
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var height, width;
  late Color myColor;
  List<Map<String, dynamic>> listuser = <Map<String, dynamic>>[];
  final UserController userController = new UserController();
  bool isApiCallProcess = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.getUsers().then((users) {
      setState(() {
        listuser = users;
        isApiCallProcess = false;
      });
    }).catchError((error) {
      print("Error: $error");
    });
  }

  // Future<void> getUser() async {
  //   listuser = await userController.getUsers();
  // }

  @override
  Widget build(BuildContext context) {
    final startIndex = currentPage * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    final displayedItems = listuser.sublist(
      startIndex,
      endIndex < listuser.length ? endIndex : listuser.length,
    );
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
          ),
        ),
        child: Container(
          child: Scaffold(
              backgroundColor: Colors.transparent,
              key: _scaffoldKey,
              appBar: AppBar(
                title: const Text(
                  'Quản lý người dùng',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent.withOpacity(0.6),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
              ),
              body: progressAPI(
                child: Stack(children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: ListView.builder(
                      itemCount: displayedItems.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.only(
                                top: 20, left: 10, right: 10, bottom: 10),
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black.withOpacity(0.4)),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 30,
                                    left: 20,
                                    right: 10,
                                  ),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width -
                                        50, //
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              color: Colors.white,
                                              image: const DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/user.jpg"))),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'ID: ${listuser[index]?['id']}',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                  fontSize: 16,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Tên người dùng: ${listuser[index]?['username']}',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.8)),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Email: ${listuser[index]?['email']}',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.8)),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Trạng thái: ${listuser[index]?['isActive'] ? 'Hoạt động' : 'Dừng hoạt động'}',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.8)),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              30), // Border radius 30
                                          color: Colors.white, // Màu nền trắng
                                        ),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.auto_fix_high_sharp,
                                              size: 30),
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              10), // Khoảng cách giữa các nút
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              30), // Border radius 30
                                          color: Colors.white, // Màu nền trắng
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isApiCallProcess = true;
                                            });
                                            userController.setState({
                                              'id': listuser[index]['id'],
                                              'isActive': listuser[index]['isActive']
                                              // No need for casting if it's a boolean
                                            }).then((value) => {
                                                  if (value['err'] == 0)
                                                    {
                                                      userController
                                                          .getUsers()
                                                          .then((users) {
                                                        setState(() {
                                                          listuser = users;
                                                          isApiCallProcess =
                                                              false;
                                                        });
                                                      }).catchError((error) {
                                                        print("Error: $error");
                                                      }),
                                                    }
                                                });
                                          },
                                          icon: Icon(
                                              listuser[index]?['isActive']
                                                  ? Icons.block_flipped
                                                  : Icons
                                                      .change_circle_outlined,
                                              size: 30),
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              10), // Khoảng cách giữa các nút
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              30), // Border radius 30
                                          color: Colors.white, // Màu nền trắng
                                        ),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.cancel_outlined,
                                              size: 30),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ));
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent.withOpacity(0.6)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // Căn giữa theo chiều ngang
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // Căn giữa theo chiều dọc
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back),
                                  color: Colors.white,
                                  onPressed: currentPage == 0
                                      ? null
                                      : () {
                                          setState(() {
                                            currentPage--;
                                          });
                                        },
                                ),
                                Text(
                                  'Trang ${currentPage + 1}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                IconButton(
                                  icon: Icon(Icons.arrow_forward),
                                  color: Colors.white,
                                  onPressed: endIndex >= listuser.length
                                      ? null
                                      : () {
                                          setState(() {
                                            currentPage++;
                                          });
                                        },
                                ),
                              ],
                            ),
                          ],
                        )),
                  )
                ]),
                inAsyncCall: isApiCallProcess,
                opacity: 0.3,
              )),
        ));
  }
}
