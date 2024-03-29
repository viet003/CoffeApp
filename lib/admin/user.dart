import 'package:coffeeapp/component/progressAPI.dart';
import 'package:coffeeapp/controller/userController.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  late int currentPage;
  int itemsPerPage = 10;
  late int startIndex = 0;
  late int length;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController searchController;
  late List<Map<String, dynamic>> displayedItems = [];
  final _formKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  final UserController userController = UserController();
  List<Map<String, dynamic>> listUsers = <Map<String, dynamic>>[];

  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    currentPage = 0;
    _loadUsers();
  }

  void _loadUsers() {
    userController.getUsers().then((product) {
      setState(() {
        listUsers = product;
        displayedItems = listUsers;
        isApiCallProcess = false;
      });
    }).catchError((error) {
      throw error;
    });
  }

  void _searchProducts(String value) {
    setState(() {
      displayedItems = listUsers
          .where((item) => item['username'].contains(value))
          .toList();
      _resetPage();
    });
  }

  void _resetPage() {
    currentPage = 0;
    startIndex = 0;
    _updateEndIndex();
  }

  void _updateEndIndex() {
    int tempEndIndex = (startIndex + itemsPerPage < displayedItems.length)
        ? startIndex + itemsPerPage
        : displayedItems.length;
    if (tempEndIndex != displayedItems.length) {
      startIndex = tempEndIndex - itemsPerPage;
    }
  }

  void _nextPage() {
    setState(() {
      if (!_isLastPage()) {
        currentPage++;
        startIndex = currentPage * itemsPerPage;
        _updateEndIndex();
      }
    });
  }

  bool _isLastPage() {
    return (startIndex + itemsPerPage >= displayedItems.length);
  }

  void _previousPage() {
    setState(() {
      if (!_isFirstPage()) {
        currentPage--;
        startIndex = currentPage * itemsPerPage;
        _updateEndIndex();
      }
    });
  }

  bool _isFirstPage() {
    return (currentPage == 0);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Quản lý sản phẩm',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black.withOpacity(0.8),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        child: progressAPI(
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 52,
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: searchController,
                        onChanged: _searchProducts,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xff313131),
                          contentPadding: const EdgeInsets.only(
                            top: 23,
                            bottom: 2,
                            right: 5,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          hintText: "Search coffee",
                          hintStyle: GoogleFonts.sora(
                            color: const Color(0xff989898),
                          ),
                          prefixIcon: const Icon(
                            Iconsax.search_normal,
                            color: Colors.white,
                            size: 20,
                          ),
                          suffixIcon: Container(
                            width: 44,
                            height: 44,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xffC67C4E),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Iconsax.setting_4,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Expanded(
                      child: ListView.builder(
                        itemCount: displayedItems.length,
                        itemBuilder: (context, index) {
                          return _buildChild(displayedItems[index]);
                        },
                      ),
                    ),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent.withOpacity(0.7),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            color: Colors.white,
                            onPressed: _isFirstPage() ? null : _previousPage,
                          ),
                          Text(
                            'Trang ${currentPage + 1}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            color: Colors.white,
                            onPressed: _isLastPage() ? null : _nextPage,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUpdateButton(Map<String, dynamic> input) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          setState(() {
            isApiCallProcess = true;
          });
          Map<String, dynamic> data = {
            'email': input['email'],
            'newpassword': passwordController.text,
            'role': 'admin'
          };
          userController.changePassbyAdmin(data).then((value) => {
            if (value['err'] == 0)
              {
                _loadUsers(),
                Navigator.pop(context),
                cancel()
              }
            else
              {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Thông báo'),
                      content: SizedBox(
                        height: 100,
                        child: Column(
                          children: [Text(value['msg'])],
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Đóng'),
                        ),
                      ],
                    );
                  },
                )
              }
          });
        }
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 10,
        // shadowColor: myColor,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text("Cập nhật"),
    );
  }

  Widget _buildFormUpdate() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputField(passwordController, Icons.add_task_rounded, 'Mật khẩu mới'),
        ],
      ),
    );
  }

  Widget _buildInputField(
      TextEditingController controller, IconData icon, String label) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        icon: Icon(icon),
      ),
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Không được bỏ trống thông tin.';
        }
        return null;
      },
    );
  }

  void cancel() {
    setState(() {
      passwordController.text = '';
    });
  }

  // build child widget
  Widget _buildChild(Map<String, dynamic> input) {
    bool isActive = input['isActive'] as bool;
    return Container(
      margin: EdgeInsets.only(top:10),
      height: 200,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7), // Màu nền là màu đen
        borderRadius: BorderRadius.circular(20), // Border radius là 20
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              left: 20,
              right: 10,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white,
                      image:const DecorationImage(
                        image: AssetImage("assets/images/user.jpg"),
                        fit: BoxFit.cover, // Có thể thay đổi tùy theo yêu cầu của bạn
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ID: ${input['id']} ',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Tên người dùng: ${input['username']} ',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.9)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Email: ${input['email']} ',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.9)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Trạng thái: ${input['isActive'] ? 'Đang hoạt động' : 'Dừng hoạt động'}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.9)),
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
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xffC67C4E),
                  ),
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            scrollable: true,
                            content: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Center(
                                    child: Text(
                                      'Thông tin chi tiết',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  _buildFormUpdate(),
                                ],
                              ),
                            ),
                            insetPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            // Adjust padding as needed
                            actions: [_buildUpdateButton(input)],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.auto_fix_high_sharp, size: 30, color: Colors.white,),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xffC67C4E),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isApiCallProcess = true;
                      });
                      Map<String, dynamic> data = {
                        'id': input['id'],
                        'isActive': input['isActive']
                      };
                      userController.setState(data).then((value) => {
                        if(value['err'] == 0) {
                          userController.getUsers().then((value) => {
                            setState(() {
                              isApiCallProcess = false;
                              displayedItems = value;
                            }),
                          })
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Thông báo'),
                                content: SizedBox(
                                  height: 100,
                                  child: Column(
                                    children: [Text(value['msg'])],
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Đóng'),
                                  ),
                                ],
                              );
                            },
                          )
                        }
                      });
                    },
                    icon: Icon( isActive ? Icons.lock_clock_sharp : Icons.change_circle, size: 30, color: Colors.white,),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xffC67C4E),
                  ),
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Thông báo',
                              textAlign: TextAlign.center,
                            ),
                            content: const SizedBox(
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                      'Thông tin tài khoản sẽ được xóa khỏi cơ sở dữ liệu. Bạn có chắc chắn không?')
                                ],
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    userController.deleteUsers({ 'id': input['id']}).then((value) => {
                                      if(value['err'] == 0) {
                                        userController.getUsers().then((value) => {
                                          setState(() {
                                            displayedItems = value;
                                            isApiCallProcess = false;
                                          }),
                                          Navigator.pop(context),
                                        })
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Thông báo'),
                                              content: SizedBox(
                                                height: 100,
                                                child: Column(
                                                  children: [Text(value['msg'])],
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Đóng'),
                                                ),
                                              ],
                                            );
                                          },
                                        )
                                      }
                                    });
                                  }, child: const Text('Có')),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Đóng'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.cancel_outlined, size: 30, color: Colors.white,),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
