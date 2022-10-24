import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: const Color(0xffeeeeee),
        highlightColor: Colors.grey.withOpacity(0.3),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 75.0,
                height: 75.0,
                color: const Color(0xffeeeeee),
              ),
              const SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 12.0),
                      height: 18.0,
                      color: const Color(0xffeeeeee),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 24.0),
                      height: 14.0,
                      color: const Color(0xffeeeeee),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      itemCount: 3,
    );
  }
}
