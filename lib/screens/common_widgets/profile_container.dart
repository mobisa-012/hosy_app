import 'package:flutter/material.dart';
import 'package:hosy/core/const/colors.dart';


class ProfileContainer extends StatelessWidget {
  final Widget child;
  final Function()? onTap;

  const ProfileContainer({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: AppColors.homeBackground,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
