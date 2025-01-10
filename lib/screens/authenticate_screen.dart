import 'package:flutter/material.dart';
import './signin_page.dart';
import './signup_page.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignUp = false;
  bool showPadding = false; // New variable for delayed padding visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
          ),

          // Positioned signup page
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            bottom:
                showSignUp ? MediaQuery.of(context).size.height * 0.55 : 0.0,
            left: 0.0,
            right: 0.0,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red[700],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: showSignUp
                  ? SignUpPage(
                      onSignInPressed: () {
                        setState(() {
                          showSignUp = false;
                          showPadding = false; // Hide padding on SignIn
                        });
                      },
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 80.0),
                          Text(
                            'Report details about the accident',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.8),
                              fontFamily: 'Roboto',
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            '''Easily capture crash details, notify your insurance carrier, book concierge services, and get real-time assistance. With step-by-step guidance, documenting the incident becomes straightforward and stress-free.''',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white.withOpacity(0.8),
                              fontFamily: 'Roboto',
                            ),
                          ),
                          const SizedBox(height: 80.0),
                          Text(
                            'Fast and Secure',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.8),
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),

          // Positioned Signin page
          if (!showSignUp)
            Positioned(
              top: 50.0,
              left: 0,
              right: 0,
              child: SignInPage(
                onSignUpPressed: () {
                  setState(() {
                    showSignUp = true;
                  });
                  // Add delay to show padding after signup
                  Future.delayed(const Duration(milliseconds: 500), () {
                    setState(() {
                      showPadding = true;
                    });
                  });
                },
              ),
            ),

          // Padding component at the bottom when signup is true
          if (showSignUp && showPadding)
            Positioned(
              bottom: 50.0, // Ensure it stays at the bottom
              left: 0.0,
              right: 0.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80.0),
                    Text(
                      'Report details about the accident',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.8),
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      '''Easily capture crash details, notify your insurance carrier, book concierge services, and get real-time assistance. With step-by-step guidance, documenting the incident becomes straightforward and stress-free.''',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white.withOpacity(0.8),
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(height: 80.0),
                    Text(
                      'Fast and Secure',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.8),
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
