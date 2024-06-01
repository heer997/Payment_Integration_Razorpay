import "package:flutter/material.dart";
import "package:razorpay_flutter/razorpay_flutter.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Payment Integration Razorpay",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.grey,
          centerTitle: true,
        ),
      ),
      home: const PaymentIntegration(),
    );
  }
}

class PaymentIntegration extends StatefulWidget {
  const PaymentIntegration({super.key});

  @override
  State<PaymentIntegration> createState() {
    return PaymentIntegrationState();
  }
}

class PaymentIntegrationState extends State<PaymentIntegration> {
  late Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Successful : ${response.paymentId}");

    /// You can add logic here for successful payment
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error : ${response.code} - ${response.message}");

    /// You can add logic here for failed payment
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet : ${response.walletName}");

    /// You can add logic here for external wallet payment
  }

  void _openCheckout() {
    var options = {
      "key": "rzp_test_0lvHq6Hwdy6tdu",
      "amount": 2000,
      "name": "Demo Payment",
      "description": "Payment for the demo product",
      "prefill": {"contact": "5477863321", "email": "demo@example.com"},
      "external": {
        "wallets": ["paytm"],
      },
    };

    try {
      razorpay.open(options);
    } catch (error) {
      print("Error : $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Payment Integration Razorpay",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _openCheckout();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            fixedSize: const Size(300.0, 50.0),
          ),
          child: const Text(
            "Make Payment",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
