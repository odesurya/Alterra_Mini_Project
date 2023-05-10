import 'package:alterra_mini_project/screens/checkout.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bottom_bar_matu/bottom_bar_matu.dart';

import '../widget/reuseable_row_for_cart.dart';
import '../main_wrapper.dart';
import '../model/base_model.dart';
import '../utils/constants.dart';
import '../widget/reuseable_button.dart';
import 'package:alterra_mini_project/model/cart_provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  CartProvider cartProvider = CartProvider();
  final int _index = 1;

  double calculateTotalPrice(CartProvider cartProvider, BaseModel baseModel) {
    double total = 0.0;
    if (cartProvider.itemsOnCart.isEmpty) {
      total = 0;
    } else {
      for (BaseModel data in cartProvider.itemsOnCart) {
        total = total + data.price * data.value;
      }
    }
    return total;
  }

  void onDelete(CartProvider cartProvider, BaseModel data) {
    cartProvider.delete(data);
  }

  void decrementItem(CartProvider cartProvider, BaseModel data) {
    cartProvider.decrementItem(data);
  }

  void incrementItem(CartProvider cartProvider, BaseModel data) {
    cartProvider.incrementItem(data);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Cart",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainWrapper()),
                (route) => false);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => cartProvider,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              SizedBox(
                width: size.width,
                height: size.height * 0.6,
                child: cartProvider.itemsOnCart.isEmpty

                    /// List is Empty:
                    ? Stack(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              FadeInUp(
                                delay: const Duration(milliseconds: 200),
                                child: const Image(
                                  image: AssetImage("assets/images/empty.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              FadeInUp(
                                delay: const Duration(milliseconds: 250),
                                child: const Text(
                                  "Your cart is empty right now :(",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: size.width,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 0,
                                ),
                                child: FadeInUp(
                                  delay: const Duration(milliseconds: 550),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 0),
                                    child: ReuseableButton(
                                      text: "Kembali ke menu",
                                      onTap: () {
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MainWrapper(),
                                          ),
                                          (Route<dynamic> route) => false,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )

                    /// List is Not Empty:
                    : Column(children: [
                        Expanded(
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: cartProvider.itemsOnCart.length,
                              itemBuilder: (context, index) {
                                var current = cartProvider.itemsOnCart[index];

                                return FadeInUp(
                                  delay:
                                      Duration(milliseconds: 100 * index + 80),
                                  child: Container(
                                    margin: const EdgeInsets.all(5.0),
                                    width: size.width,
                                    height: size.height * 0.25,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                offset: Offset(0, 4),
                                                blurRadius: 4,
                                                color:
                                                    Color.fromARGB(61, 0, 0, 0),
                                              )
                                            ],
                                            color: Colors.pink,
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    current.imageUrl),
                                                fit: BoxFit.cover),
                                          ),
                                          width: size.width * 0.4,
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 2.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: size.width * 0.52,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        current.name,
                                                        style: const TextStyle(
                                                            fontSize: 18),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        cartProvider
                                                            .delete(current);
                                                      },
                                                      icon: const Icon(
                                                        Icons.close,
                                                        color: Colors.grey,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              RichText(
                                                  text: TextSpan(
                                                      text: "Rp.",
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            "AlegreyaSans",
                                                        color: primaryColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      children: [
                                                    TextSpan(
                                                      text: current.price
                                                          .toStringAsFixed(0)
                                                          .replaceAllMapped(
                                                              RegExp(
                                                                  r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                              (Match m) =>
                                                                  '${m[1]}.'),
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            "AlegreyaSans",
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                                  ])),
                                              const Text(
                                                "color",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: "AlegreyaSans",
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Container(
                                                width: 40,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: current.selectedColor,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: primaryColor),
                                                ),
                                              ),
                                              Text(
                                                "Size ${current.size}",
                                                style: const TextStyle(
                                                  fontFamily: "AlegreyaSans",
                                                  fontSize: 20,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                  top: size.height * 0.02,
                                                ),
                                                width: size.width * 0.4,
                                                height: size.height * 0.04,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      width: size.width * 0.065,
                                                      height:
                                                          size.height * 0.045,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                      ),
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        onTap: () {
                                                          cartProvider
                                                              .decrementItem(
                                                                  current);
                                                        },
                                                        child: const Icon(
                                                          Icons.remove,
                                                          size: 16,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  size.width *
                                                                      0.02),
                                                      child: Text(
                                                        current.value
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily:
                                                              "AlegreyaSans",
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      width: size.width * 0.065,
                                                      height:
                                                          size.height * 0.045,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        onTap: () {
                                                          cartProvider
                                                              .incrementItem(
                                                                  current);
                                                        },
                                                        child: const Icon(
                                                          Icons.add,
                                                          size: 16,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: size.width,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 25.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FadeInUp(
                                    delay: const Duration(milliseconds: 500),
                                    child: ReuseableRowForCart(
                                      price: cartProvider.calculateTotalPrice(),
                                      text: 'Total',
                                    ),
                                  ),
                                  FadeInUp(
                                    delay: const Duration(milliseconds: 550),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2.0),
                                      child: ReuseableButton(
                                        text: "Checkout",
                                        onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Checkout()),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBarBubble(
        color: const Color(0xFFF61C85),
        selectedIndex: _index,
        backgroundColor: Colors.white,
        items: [
          BottomBarItem(
            iconData: Icons.home,
            label: 'Home',
          ),
          BottomBarItem(
            iconData: Icons.shopping_cart,
            label: 'Cart',
          ),
          BottomBarItem(
            iconData: Icons.assignment,
            label: 'Task',
          ),
          BottomBarItem(
            iconData: Icons.person,
            label: 'Profile',
          ),
        ],
        onSelect: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainWrapper(),
                ),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Cart(),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainWrapper(),
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainWrapper(),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
