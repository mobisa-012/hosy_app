import 'package:equatable/equatable.dart';


class PaymentMethod extends Equatable {
  final String id;
  final String title;
  final String icon;
  final String description;

  PaymentMethod(
     this.id,
       this.title,
     this.icon,
      this.description);

  @override
  List<Object> get props => [id, title, icon, description];
}
