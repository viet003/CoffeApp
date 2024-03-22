import 'package:animate_do/animate_do.dart';
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
  List<String> items =
  List.generate(100, (index) => 'Item $index'); // Danh sách mẫu
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var height, width;
  late Color myColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final startIndex = currentPage * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    final displayedItems = items.sublist(
      startIndex,
      endIndex < items.length ? endIndex : items.length,
    );
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.8), BlendMode.dstATop),
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
              iconTheme:const IconThemeData(
                color: Colors.white,
              ),
            ),

            body: Stack(children: [
              ListView.builder(
                itemCount: displayedItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(displayedItems[index]),
                  );
                },
              ),
              Positioned(
                bottom: 0,
                child: Container(
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent.withOpacity(0.6)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center, // Căn giữa theo chiều ngang
                          crossAxisAlignment: CrossAxisAlignment.center, // Căn giữa theo chiều dọc
                          children: [
                            IconButton(
                              icon:const Icon(Icons.arrow_back),
                              color: Colors.white,
                              onPressed: currentPage == 0
                                  ? null
                                  : () {
                                setState(() {
                                  currentPage--;
                                });
                              },
                            ),
                            Text('Trang ${currentPage + 1}', style:const TextStyle(color: Colors.white),),
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              color: Colors.white,
                              onPressed: endIndex >= items.length
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
                    )
                ),
              )
            ]),
          ),
        ));
  }
}
