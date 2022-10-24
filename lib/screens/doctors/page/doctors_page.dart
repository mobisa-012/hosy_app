import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosy/screens/doctors/bloc/doctors_bloc.dart';
import 'package:hosy/screens/doctors/widgets/doctors_content.dart';

class Doctors extends StatelessWidget {
  const Doctors({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }

  Widget _buildContext(BuildContext context) {
    return BlocProvider<DoctorsBloc>(
      create: (BuildContext context) => DoctorsBloc(),
      child: BlocConsumer<DoctorsBloc, DoctorsState>(
        buildWhen: (_, currState) => currState is DoctorsInitial,
        builder: (context, state) {
          return const DoctorsContent();
        },
        listenWhen: (_, currState) => true,
        listener: (context, state) {},
      ),
    );
  }
}
