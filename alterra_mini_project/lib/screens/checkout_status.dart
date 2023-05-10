import 'package:alterra_mini_project/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/base_model.dart';
import '../utils/constants.dart';
import 'package:alterra_mini_project/model/cart_provider.dart';
import 'package:alterra_mini_project/model/checkout_payment_provider.dart';

class CheckoutStatus extends StatefulWidget {
  const CheckoutStatus({super.key});

  @override
  State<CheckoutStatus> createState() => _CheckoutStatusState();
}

class _CheckoutStatusState extends State<CheckoutStatus> {
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
    final checkoutPaymentProvider =
        Provider.of<CheckoutPaymentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Checkout Payment",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontFamily: "AlegreyaSans",
          ),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => checkoutPaymentProvider,
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
                  const Icon(Icons.arrow_forward, color: primaryColor),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.payment,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    color: primaryColor,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ],
              ),
              Positioned(
                top: 200,
                left: 10,
                right: 10,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: 1.0,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(0),
                      border: Border.all(
                        color: const Color.fromARGB(255, 243, 74, 192)
                            .withOpacity(0.5),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 243, 74, 192)
                              .withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 72,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Transaction Completed',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainWrapper()),
                                (route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                                  Size(size.width * 0.9, size.height * 0.07),
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 14, 118),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Go to Home',
                                style: TextStyle(
                                  fontFamily: "AlegreyaSans",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainWrapper()),
                                (route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                                  Size(size.width * 0.9, size.height * 0.07),
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 14, 118),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Go to History',
                                style: TextStyle(
                                  fontFamily: "AlegreyaSans",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
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
