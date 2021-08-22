import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:webzent/components.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentGateway extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<PaymentGateway> {
  // static const platform = const MethodChannel("razorpay_flutter");
  Razorpay _razorpay;
  String orderId='';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text(''),
          ),
        ),
      ),
    );
  }
Future<String> generateOrderId() async{
  var authn = 'Basic ' + base64Encode(utf8.encode('rzp_test_7WnoIHuyTof8oh:yUb02ajHrBZYGTjMguedEnPy'));

  var headers = {
    'content-type': 'application/json',
    'Authorization': authn,
  };

  var data = '{ "amount": 10000, "currency": "INR", "receipt": "receipt#R1", "payment_capture": 1 }'; // as per my experience the receipt doesn't play any role in helping you generate a certain pattern in your Order ID!!

  var res = await http.post('https://api.razorpay.com/v1/orders', headers: headers, body: data);
  if (res.statusCode != 200) throw Exception('http.post error: statusCode= ${res.statusCode}');
  print('ORDER ID response => ${res.body}');
  orderId=json.decode(res.body)['id'].toString();
  return json.decode(res.body)['id'].toString();
}
  @override
  void initState() {
    generateOrderId();
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    openCheckout();
  }

  //confirmation dialog for exiting the payment gateway
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (_) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              actions: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    color: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            color: Color.fromRGBO(56, 103, 180, 1),
                            child: Text(
                              'Are You Sure!',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            height: 60,
                            width: 400,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: Text(
                              'Click YES to Cancel the payment or\nNO to Continue',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.blue[800]),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ButtonTheme(
                                minWidth: 80.0,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => Components(),
                                        ),
                                        (_) => false);
                                    // Navigator.of(context).pop();
                                    // Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'YES',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ButtonTheme(
                                minWidth: 80.0,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  color: Colors.red,
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text(
                                    'NO',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ) ??
        false;
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key':
        'rzp_test_7WnoIHuyTof8oh',
      'amount': '10000',
      'name': 'Webzent',
      'order_id': orderId,
      // 'description': '',
      'prefill': {'contact': '7900333724', 'email': 'chaudharygirish7@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {

    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => Components(),
        ),
        (_) => false);
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    print("faillllllllllll");
    print(response.message.toString());

    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => Components(),
        ),
        (_) => false);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("wallet");
    print(response);
  }
}
