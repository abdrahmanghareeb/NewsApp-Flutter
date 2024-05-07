
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:local_auth/local_auth.dart';
import 'package:news_app/Layouts/NewsLayout.dart';

class FingerprintScreen extends StatefulWidget {
  const FingerprintScreen({super.key});

  @override
  State<FingerprintScreen> createState() => _FingerprintScreenState();
}

enum SupportState {
  unknown,
  supported,
  unSupported,
}

class _FingerprintScreenState extends State<FingerprintScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  SupportState supportState = SupportState.unknown;
  List<BiometricType>? availableBiometrics;

  @override
  void initState() {
    auth.isDeviceSupported().then((bool isSupported) => setState(() =>
    supportState =
    isSupported ? SupportState.supported : SupportState.unSupported));
    super.initState();
    checkBiometric();
    getAvailableBiometrics();
  }

  Future<void> checkBiometric() async {
    late bool canCheckBiometric;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
      print('Biometric supported: $canCheckBiometric');
    } on PlatformException catch (e) {
      print(e);
      canCheckBiometric = false;
    }
  }

  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> biometricTypes;
    try {
      biometricTypes = await auth.getAvailableBiometrics();
      print('supported biometric $biometricTypes');
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      availableBiometrics = biometricTypes;
    });
  }

  Future<void> authenticateWithBiometrics() async {
    try {
      final authenticated = await auth.authenticate(
        localizedReason: 'Authenticate with FingerPrint or Face ID',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (!mounted) return;
      if (authenticated) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => newsHomePage()));
      }
    } on PlatformException catch (e) {
      print(e);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   "Use Your Finger",
            //   style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       fontSize: 25,
            //       color: supportState == SupportState.supported
            //           ? Colors.green
            //           : supportState == SupportState.unSupported
            //               ? Colors.red
            //               : Colors.green),
            // ),
            Image.asset("assets/fingerprint.png"),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                  // style: ElevatedButton.styleFrom(backgroundColor: HexColor(main_color)),
                  onPressed: authenticateWithBiometrics,
                  child: const Text('Authenticate with Fingerprint' , style: TextStyle(color: Colors.white),)),
            ),
          ],
        ),
      ),
    );
  }
}