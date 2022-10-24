// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:hosy/screens/home/widgets/ease_in_widget.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final IconData iconData;

  const RoundedButton(
      {Key? key,
      required this.text,
      required this.iconData,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EaseInWidget(
      onTap: onTap,
      child: Material(
        child: Container(
          padding: text != null
              ? const EdgeInsets.symmetric(vertical: 22.0, horizontal: 16.0)
              : const EdgeInsets.symmetric(vertical: 19.0, horizontal: 22.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    blurRadius: 12.0,
                    spreadRadius: 0.1)
              ]),
          child: text != null
              ? Text(
                  text,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Colors.white,
                      ),
                )
              : Icon(
                  iconData,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
