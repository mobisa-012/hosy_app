

import 'package:hosy/core/const/path_constants.dart';
import 'package:hosy/core/services/payment_method.dart';

class PaymentMethodController {
  static Future<List<PaymentMethod>> getMethods() async {
    return [
      PaymentMethod(
        '2', 
        'M-pesa', 
        PathConstants.payment, 
        'Lipa na M-pesa'),
        PaymentMethod(
          '0', 
          
          'Master card', 
          PathConstants.payment, 
          "**** **** **** 4863")
      ];
  }
}
