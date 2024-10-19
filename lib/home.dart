import 'package:flutter/material.dart';
import 'package:packages_app/features/loading_percent/presentation/loading_percent_screen.dart';
import 'package:packages_app/features/otp_field/presentation/otp_field_screen.dart';
import 'package:packages_app/features/shimmer_loading/presentation/shimmer_loading_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ShimmerLoadingScreen()));
                },
                child: Text("Shimmer Loading Package"),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => OtpFieldScreen()));
                },
                child: Text("OTP Field Package"),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => LoadingPercentScreen()));
                },
                child: Text("Loading Percent Package"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
