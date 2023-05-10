import 'package:alterra_mini_project/screens/checkout.dart';
import 'package:alterra_mini_project/screens/checkout_status.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../widget/reuseable_row_for_cart.dart';
import '../model/base_model.dart';
import '../utils/constants.dart';
import 'package:alterra_mini_project/model/cart_provider.dart';
import 'package:alterra_mini_project/model/checkout_payment_provider.dart';
import '../widget/payment_option.dart';

class CheckoutPayment extends StatefulWidget {
  const CheckoutPayment({super.key});

  @override
  State<CheckoutPayment> createState() => _CheckoutPaymentState();
}

class _CheckoutPaymentState extends State<CheckoutPayment> {
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

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              fontFamily: "AlegreyaSans",
              color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Checkout()),
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
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10.0, top: 10, left: 20, right: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Alamat Pengiriman:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: primaryColor),
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                              hintText: 'Masukkan alamat lengkap',
                              border: InputBorder.none,
                            ),
                            onChanged: (address) {
                              checkoutPaymentProvider.setAddress(address);
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a valid address';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Pilih Metode Pembayaran:',
                          style: TextStyle(
                            fontFamily: "AlegreyaSans",
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PaymentOption(
                                label: 'Gopay',
                                image: Image.asset(
                                  'assets/images/gopay.png',
                                  width: 50,
                                  height: 50,
                                ),
                                value: Provider.of<CheckoutPaymentProvider>(
                                            context,
                                            listen: false)
                                        .selectedPaymentOption ==
                                    'Gopay',
                                onChanged: (value) {
                                  Provider.of<CheckoutPaymentProvider>(context,
                                          listen: false)
                                      .setSelectedPaymentOption(
                                          value! ? 'Gopay' : null);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PaymentOption(
                                label: 'OVO',
                                image: Image.asset(
                                  'assets/images/ovo.png',
                                  width: 50,
                                  height: 50,
                                ),
                                value: Provider.of<CheckoutPaymentProvider>(
                                            context,
                                            listen: false)
                                        .selectedPaymentOption ==
                                    'OVO',
                                onChanged: (value) {
                                  Provider.of<CheckoutPaymentProvider>(context,
                                          listen: false)
                                      .setSelectedPaymentOption(
                                          value! ? 'OVO' : null);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PaymentOption(
                                label: 'BCA',
                                image: Image.asset(
                                  'assets/images/bca.png',
                                  width: 50,
                                  height: 50,
                                ),
                                value: Provider.of<CheckoutPaymentProvider>(
                                            context,
                                            listen: false)
                                        .selectedPaymentOption ==
                                    'BCA',
                                onChanged: (value) {
                                  Provider.of<CheckoutPaymentProvider>(context,
                                          listen: false)
                                      .setSelectedPaymentOption(
                                          value! ? 'BCA' : null);
                                },
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Pilihan Pembayaran: ${Provider.of<CheckoutPaymentProvider>(context, listen: false).selectedPaymentOption ?? '-'}',
                          style: const TextStyle(
                            fontFamily: "AlegreyaSans",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Provider.of<CartProvider>(context,
                                            listen: false)
                                        .clearCart();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CheckoutStatus(),
                                      ),
                                    );
                                  }
                                },
                                style: TextButton.styleFrom(
                                  minimumSize: Size(
                                      size.width * 0.9, size.height * 0.07),
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 14, 118),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                  child: Text(
                                    'Bayar Sekarang',
                                    style: TextStyle(
                                      fontFamily: "AlegreyaSans",
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
