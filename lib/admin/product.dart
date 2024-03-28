import 'package:coffeeapp/component/progressAPI.dart';
import 'package:coffeeapp/controller/productController.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';


class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  late int currentPage;
  int itemsPerPage = 10;
  late int startIndex = 0;
  late int length;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController searchController;
  late List<Map<String, dynamic>> displayedItems = [];
  final _formKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  final ProductController productController = ProductController();
  List<Map<String, dynamic>> listProduct = <Map<String, dynamic>>[];

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController stars = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController image = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    currentPage = 0;
    _loadProducts();
  }

  void _loadProducts() {
    productController.getProducts().then((product) {
      setState(() {
        listProduct = product;
        displayedItems = listProduct;
        isApiCallProcess = false;
      });
    }).catchError((error) {
      throw error;
    });
  }

  void _searchProducts(String value) {
    setState(() {
      displayedItems = listProduct
          .where((item) => item['name'].contains(value))
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
                Positioned(
                  bottom: 80,
                  right: 20,
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xffC67C4E),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.auto_fix_high_sharp,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        cancel();
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
                                    _buildFormInsert(),
                                  ],
                                ),
                              ),
                              insetPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              // Adjust padding as needed
                              actions: [_buildSubmitButton()],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormInsert() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputField(name, Icons.add_task_rounded, 'Tên sản phẩm'),
          _buildInputField(description, Icons.add_task_rounded, 'Mô tả'),
          _buildInputField(stars, Icons.add_task_rounded, 'Số sao'),
          _buildInputField(price, Icons.add_task_rounded, 'Giá sản phẩm'),
          _buildInputField(image, Icons.add_task_rounded, 'Đường dẫn hình ảnh'),
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

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          setState(() {
            isApiCallProcess = true;
          });
          Map<String, dynamic> data = {
            'name': name.text,
            'description': description.text,
            'stars': stars.text,
            'price': price.text,
            'image': image.text
          };
          productController.insertProduct(data).then((value) => {
            if (value['err'] == 0)
              {
                _loadProducts(),
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
      child: const Text("Submit"),
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
            'id': input['id'],
            'name': name.text,
            'description': description.text,
            'stars': stars.text,
            'price': price.text,
            'image': image.text
          };
          productController.updateProduct(data).then((value) => {
            if (value['err'] == 0)
              {
                _loadProducts(),
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

  void cancel() {
    setState(() {
      name.text = '';
      description.text = '';
      stars.text = '';
      price.text = '';
      image.text = '';
    });
  }

  // build child widget
  Widget _buildChild(Map<String, dynamic> input) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7), // Màu nền là màu đen
        borderRadius: BorderRadius.circular(20), // Border radius là 20
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
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
                    height: 150,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(input['image']),
                        fit: BoxFit.cover,
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
                          'Tên sản phẩm: ${input['name']} ',
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
                          'Mỗ tả: ${input['description']} ',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.9)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Đánh giá: ${input['stars']} ',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.9)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Giá: ${input['price']}đ',
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
                      setState(() {
                        name.text = input['name'];
                        description.text = input['description'];
                        stars.text = input['stars'];
                        price.text = input['price'].toString();
                        image.text = input['image'];
                      });
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
                                  _buildFormInsert(),
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
                                    productController.deleteProduct({ 'id': input['id']}).then((value) => {
                                      if(value['err'] == 0) {
                                        productController.getProducts().then((value) => {
                                          setState(() {
                                            listProduct = value;
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
          )
        ],
      ),
    );
  }
}
