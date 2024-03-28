import 'package:coffeeapp/component/app_routes.dart';
import 'package:coffeeapp/screens/widgets/coffee_size.dart';
import 'package:coffeeapp/screens/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class Detail extends StatefulWidget {
  final String image;
  final String price;
  final String stars;
  final String name;
  final String description;

  const Detail({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.stars,
    required this.description
  });

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  int selectedSize = 1;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white, // Color for Android
        statusBarBrightness:
            Brightness.light, // Dark == white status bar -- for IOS.
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.050,
              ),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.chevron_left,
                        color: Color(0xff2F2D2C),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.095,
                    ),
                    Text(
                      'Thông tin sản phẩm',
                      style: GoogleFonts.sora(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.095,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Iconsax.heart,
                        color: Color(0xff2F2D2C),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.030,
              ),
              Container(
                height: 226,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image:  DecorationImage(
                    image: NetworkImage(widget.image),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.020,
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: GoogleFonts.sora(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff2F2D2C)),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "với Chocolate",
                      style: GoogleFonts.sora(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff9B9B9B),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(
                            Iconsax.star1,
                            color: Color(0xffFBBE21),
                          ),
                        ),
                        Text(
                          widget.stars,
                          style: GoogleFonts.sora(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff2F2D2C),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.010,
                        ),
                        Text(
                          "(230)",
                          style: GoogleFonts.sora(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xffF9F9F9),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.beach_access_rounded,
                            color: Color(0xffC67C4E),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.020,
                        ),
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xffF9F9F9),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.bolt_outlined,
                            color: Color(0xffC67C4E),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Căn sang trái
                    children: [
                      SizedBox(
                        height: size.height * 0.010,
                      ),
                      Container(
                        height: 2,
                        decoration: const BoxDecoration(color: Color(0xffEAEAEA)),
                      ),
                      SizedBox(
                        height: size.height * 0.020,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Căn sang trái
                        children: [
                          Text(
                            "Mô tả",
                            style: GoogleFonts.sora(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.010,
                          ),
                          RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                              text: widget.description,
                              style: GoogleFonts.sora(
                                  color: const Color(0xff9B9B9B),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  height: 1.64),
                              children: [
                                TextSpan(
                                  text: "    Đọc thêm",
                                  style: GoogleFonts.sora(
                                    color: const Color(0xffC67C4E),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.020,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Căn sang trái
                        children: [
                          Text(
                            "Size",
                            style: GoogleFonts.sora(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.020,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CoffeeSize(
                                title: "S",
                                index: 0,
                                selectedSize: selectedSize,
                                onClick: () {
                                  setState(() {
                                    selectedSize = 0;
                                  });
                                },
                              ),
                              CoffeeSize(
                                title: "M",
                                index: 1,
                                selectedSize: selectedSize,
                                onClick: () {
                                  setState(() {
                                    selectedSize = 1;
                                  });
                                },
                              ),
                              CoffeeSize(
                                title: "L",
                                index: 2,
                                selectedSize: selectedSize,
                                onClick: () {
                                  setState(() {
                                    selectedSize = 2;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.020,
                      ),
                    ],
                  ),
                )
              ),
              Container(
                height: 121,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Giá: ",
                              style: GoogleFonts.sora(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff9B9B9B)),
                            ),
                            Text(
                              "${widget.price} đ",
                              style: GoogleFonts.sora(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xffC67C4E)),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 217,
                          height: 62,
                          child: CustomButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, Routes.order),
                            title: 'Thêm vào giỏ hàng',
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
