import 'package:alterra_mini_project/screens/cart.dart';
import 'package:alterra_mini_project/screens/chekout_payment.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../widget/reuseable_row_for_cart.dart';
import '../model/base_model.dart';
import '../utils/constants.dart';
import '../widget/reuseable_button.dart';
import 'package:alterra_mini_project/model/cart_provider.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  CartProvider cartProvider = CartProvider();
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
          "Checkout",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontFamily: "AlegreyaSans",
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Cart()),
                (route) => false);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              LineIcons.user,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: ChangeNotifierProvider(
        create: (_) => cartProvider,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.shopping_cart,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  const Icon(Icons.arrow_forward, color: Colors.grey),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.payment,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  const Icon(Icons.arrow_forward, color: Colors.grey),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ],
              ),

              Positioned(
                top: 80,
                left: 0,
                right: 0,
                child: SizedBox(
                  width: size.width,
                  height: size.height * 0.6,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: cartProvider.itemsOnCart.length,
                      itemBuilder: (context, index) {
                        var current = cartProvider.itemsOnCart[index];

                        return FadeInUp(
                          delay: Duration(milliseconds: 100 * index + 80),
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            width: size.width,
                            height: size.height * 0.25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 4,
                                        color: Color.fromARGB(61, 0, 0, 0),
                                      )
                                    ],
                                    color: Colors.pink,
                                    image: DecorationImage(
                                        image: AssetImage(current.imageUrl),
                                        fit: BoxFit.cover),
                                  ),
                                  width: size.width * 0.4,
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.52,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              current.name,
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Text(
                                        "color",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "AlegreyaSans",
                                        ),
                                      ),
                                      Container(
                                        width: 40,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: current.selectedColor,
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: primaryColor),
                                        ),
                                      ),
                                      Text(
                                        "Size = ${current.size}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontFamily: "AlegreyaSans",
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
                                            const Text(
                                              'Jumlah: ',
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontFamily: "AlegreyaSans",
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: size.width * 0.02,
                                              ),
                                              child: Text(
                                                current.value.toString(),
                                                style: const TextStyle(
                                                  fontFamily: "AlegreyaSans",
                                                  fontSize: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                          text: TextSpan(
                                              text: "Rp.",
                                              style: const TextStyle(
                                                fontFamily: "AlegreyaSans",
                                                fontSize: 22,
                                                color: primaryColor,
                                              ),
                                              children: [
                                            TextSpan(
                                              text: current.price
                                                  .toStringAsFixed(0)
                                                  .replaceAllMapped(
                                                      RegExp(
                                                          r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                      (Match m) => '${m[1]}.'),
                                              style: const TextStyle(
                                                fontFamily: "AlegreyaSans",
                                                fontSize: 24,
                                              ),
                                            )
                                          ])),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),

              /// Bottom Card
              Positioned(
                bottom: 0,
                child: Container(
                  width: size.width,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 21.0),
                    child: Column(
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
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: ReuseableButton(
                                text: "Checkout",
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CheckoutPayment()));
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
