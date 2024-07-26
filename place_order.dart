import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:gradient_slide_to_act/gradient_slide_to_act.dart';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({super.key});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _animation = Tween(begin: 100.0, end: 270.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _imagesListDetails() {
    List<Widget> details = [];
    List<String> imagesList = [
      'images/icecream_products/cone1.png',
      'images/icecream_products/cone2.png',
      'images/icecream_products/cone3.png',
      'images/icecream_products/cone4.png',
    ];
    List<int> prices = [340, 220, 480, 310];
    for (int i = 0; i < imagesList.length; i++) {
      details.add(
        ProductDetails(
          image: imagesList[i],
          price: prices[i],
          animation: _animation,
        ),
      );
    }
    return details;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> imagesListDtls = _imagesListDetails();
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text(
          "Order",
          style: TextStyle(
              color: Colors.black, fontFamily: 'Cherry', fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 660,
              child: Swiper(
                itemCount: imagesListDtls.length,
                itemBuilder: (context, index) {
                  return imagesListDtls[index];
                },
              ),
            ),
            Container(
                alignment: Alignment.center,
                child: GradientSlideToAct(
                  onSubmit: () async {
                    showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                        elevation: 5,
                        backgroundColor: Colors.grey,
                        title: Text(
                          "Order Placed",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                    await Future.delayed(const Duration(milliseconds: 1200),
                        () {
                      Get.back();
                    });
                    Get.back();
                  },
                  backgroundColor: const Color.fromARGB(108, 197, 5, 194),
                  text: "Place Order",
                  textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 12, 56, 134),
                    Color.fromARGB(255, 106, 12, 123),
                    Color.fromARGB(255, 131, 82, 17),
                  ]),
                )),
          ],
        ),
      ),
    );
  }
}

class ProductDetails extends StatefulWidget {
  const ProductDetails(
      {super.key,
      required this.image,
      required this.price,
      required this.animation});
  final String image;
  final int price;
  final Animation<double> animation;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int i = 0;
  late int price1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                height: 520,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(200),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color.fromARGB(217, 12, 57, 134),
                        Color.fromARGB(217, 106, 12, 123),
                        Color.fromARGB(217, 131, 82, 17),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.black54,
                        offset: Offset(10, 10),
                      )
                    ]),
              ),
            ),
            AnimatedBuilder(
              animation: widget.animation,
              builder: (context, child) {
                return SizedBox(
                  height: widget.animation.value + 200,
                  width: widget.animation.value + 100,
                  child: Image.asset(
                    widget.image,
                    width: widget.animation.value,
                    height: widget.animation.value,
                  ),
                );
              },
            ),
            Positioned(
              top: 470,
              left: 30,
              child: Text(
                'Rs. ${widget.price}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontFamily: 'Cherry',
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: "btn1",
                    backgroundColor: Color.fromARGB(182, 84, 3, 98),
                    foregroundColor: Colors.amber,
                    onPressed: () {
                      setState(() {
                        i++;
                      });
                    },
                    child: const Icon(Icons.add),
                  ),
                  Text(' items : $i',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Cherry")),
                  FloatingActionButton(
                    heroTag: "btn2",
                    backgroundColor: Color.fromARGB(182, 84, 3, 98),
                    foregroundColor: Colors.amber,
                    onPressed: () {
                      setState(() {
                        if (i > 0) {
                          i--;
                        }
                      });
                      const SizedBox(
                        height: 5,
                      );
                    },
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
              Text(
                ' Total : ${i * widget.price}',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    fontFamily: "Cherry"),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
