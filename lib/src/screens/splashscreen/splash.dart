// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({ Key key }) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{


//   AnimationController _controller;

//   @override
//   void initState() {
//     _controller = AnimationController(vsync: this, duration: Duration(seconds:5));
//     super.initState();
//   }

// @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff1C1C26),
//         body: Center(
//       child: Container(
//         child: Lottie.asset('assets/images/Splash_belnet_1 (1).json',    //belnet_splash.json
//             controller: _controller, onLoaded: (composition) {
//           _controller
//             ..duration = composition.duration
//             ..forward().whenComplete(() => //Navigator.pushReplacement(context, MaterialPageRoute(builder: builder))
//             // Navigator.pushReplacement(context,
//             //     MaterialPageRoute(builder: (context) => Container()))
//                 );
//         }),
//       ),
//     ));
//   }
// }