import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/bloc/internet_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocConsumer<InternetBloc, InternetState>(
            listener: (context, state) {
              if (state is InternetGainedState) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Internet Connected"),
                  backgroundColor: Colors.green,
                ));
              } else if (state is InternetLostState) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Not Connected"),
                  backgroundColor: Colors.red,
                ));
              }
            },
            builder: (context, state) {
              if (state is InternetGainedState) {
                return Text("Connected");
              } else if (state is InternetLostState) {
                return Text("Not Connected");
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),

        //   child: Center(
        //   child: BlocBuilder<InternetBloc, InternetState>(
        //     builder: (context, state) {
        //
        //     },
        //   ),
        // )
      ),
    );
  }
}
