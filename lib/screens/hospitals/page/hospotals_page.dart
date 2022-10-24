import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosy/screens/hospitals/bloc/hospital_bloc.dart';
import 'package:hosy/screens/hospitals/widgets/hospital_content.dart';


class Hospitals extends StatelessWidget {
  const Hospitals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }

  BlocProvider<HospitalBloc> _buildContext(BuildContext context) {
    return BlocProvider<HospitalBloc>(
      create: (BuildContext context) => HospitalBloc(),
      child: BlocConsumer<HospitalBloc, HospitalState>(
        buildWhen: (_, currState) => currState is HospitalInitial,
        builder: (context, state) {
          return const HospitalContent();
        },
        listenWhen: (_, currState) => true,
        listener: (context, state) {},
      ),
    );
  }
}
