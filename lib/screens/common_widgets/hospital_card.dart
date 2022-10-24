import 'package:flutter/material.dart';
import 'package:hosy/core/const/colors.dart';


class HospitalCard extends StatelessWidget {
  final Widget child;
  final Function() onTap;
  final bool withCall;

  const HospitalCard({
    super.key,
    required this.onTap,
    required this.withCall,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: AppColors.textColor.withOpacity(0.12),
                  blurRadius: 5.0,
                  spreadRadius: 1.1)
            ]),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(child: child),
                  if (withCall)
                    const Icon(
                      Icons.call,
                      color: AppColors.buttonColor,
                      size: 20,
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
