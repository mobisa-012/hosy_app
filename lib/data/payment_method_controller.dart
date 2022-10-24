

import 'package:hosy/core/const/path_constants.dart';
import 'package:hosy/core/services/payment_method.dart';

class PaymentMethodController {
  static Future<List<PaymentMethod>> getMethods() async {
    return [
      const PaymentMethod(
        '2', 
        'M-pesa', 
        PathConstants.payment, 
        'Lipa na M-pesa'),
        const PaymentMethod(
          '0', 
          
          'Master card', 
          PathConstants.payment, 
          "**** **** **** 4863")
      ];
  }
}
