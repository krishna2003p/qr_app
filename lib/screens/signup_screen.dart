import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 89, 33, 243), // Background Color
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // White Model (Form)
              Container(
                margin: const EdgeInsets.only(top: 160), // Push it down
                padding: const EdgeInsets.all(24),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.80, // Increase height
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80), // Space for Overlapping Icon

                    // Username Field
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Username",
                        hintText: "Enter your name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Phone Number Field
                    TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        hintText: "(+84) 332249402",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Password Field
                    TextField(
                      obscureText: !isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "********",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Terms & Conditions
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                          activeColor: const Color.fromARGB(255, 89, 33, 243),
                        ),
                        const Expanded(
                          child: Text(
                            "By creating an account you agree to our Terms and Conditions",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isChecked ? () {} : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 89, 33, 243),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text("Sign up"),
                      ),
                    ),

                    const Spacer(), // Pushes the bottom text down

                    // Sign In Link
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to Sign In
                        },
                        child: const Text(
                          "Have an account?  Sign in",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // Welcome Text & Profile Icon (Above White Card)
              Positioned(
                top: 40, // Position it above the white card
                child: Column(
                  children: [
                    // "Welcome to us" Text
                    const Text(
                      "Welcome to us,",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "Hello there, create new account",
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 15),

                    // Profile Image Circle
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 245, 240, 240),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 50,
                          color: Color.fromARGB(255, 89, 33, 243),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
