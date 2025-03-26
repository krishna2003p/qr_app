import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myfirstapp/screens/provider/auto_provider.dart';
import 'package:provider/provider.dart';
import '../common/custom_button.dart';
import '../loader/loader_provider.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final IconData icon;
  final String inputType;
  final int maxLength;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    this.inputType = "text",
    this.maxLength = 50,
    this.controller,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    TextInputType keyboardType;
    List<TextInputFormatter>? inputFormatters;
    bool isPassword = false;

    switch (widget.inputType) {
      case "email":
        keyboardType = TextInputType.emailAddress;
        inputFormatters = [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
        ];
        break;
      case "password":
        keyboardType = TextInputType.text;
        isPassword = true;
        break;
      case "phone":
        keyboardType = TextInputType.phone;
        inputFormatters = [
          FilteringTextInputFormatter.digitsOnly,
        ];
        break;
      default:
        keyboardType = TextInputType.text;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: widget.controller,
        obscureText: isPassword ? _obscureText : false,
        keyboardType: keyboardType,
        maxLength: widget.maxLength,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: widget.label,
          prefixIcon: Icon(widget.icon, color: Colors.blue),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.9),
          counterText: "",
        ),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}



class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomTextField(
            label: "Email",
            icon: Icons.email,
            inputType: "email",
            maxLength: 100,
          ),
          const SizedBox(height: 15),
          const CustomTextField(
            label: "Password",
            icon: Icons.lock,
            inputType: "password",
            maxLength: 20,
          ),
          const SizedBox(height: 20),
          CustomLoadingButton(
            onPressed: (){
              if (kDebugMode) {
                print("Tapped");
              }
            },
            text: "Login",
            color: Colors.blue,
          ),
          TextButton(onPressed: () => authProvider.switchView('forgot'), child: const Text('Forgot Password?')),
          TextButton(onPressed: () => authProvider.switchView('register'), child: const Text('Create an Account')),
        ],
      ),
    );
  }
}

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomTextField(label: 'Name', icon: Icons.person),
          const SizedBox(height: 15),
          const CustomTextField(label: 'Email', icon: Icons.email),
          const SizedBox(height: 15),
          //const CustomTextField(label: 'Password', icon: Icons.lock, isPassword: true),
          const SizedBox(height: 20),
          _buildButton("Login", Colors.blue, () {
            final loaderProvider = Provider.of<LoaderProvider>(context, listen: false);
            loaderProvider.showLoader();
          }),
          TextButton(onPressed: () => authProvider.switchView('login'), child: const Text('Already have an account? Login')),
        ],
      ),
    );
  }
}

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomTextField(label: 'Enter your email', icon: Icons.email),
          const SizedBox(height: 20),
          _buildButton('Reset Password', Colors.orange, () {}),
          TextButton(onPressed: () => authProvider.switchView('login'), child: const Text('Back to Login')),
        ],
      ),
    );
  }
}

Widget _buildButton(String text, Color color, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: color,
      elevation: 5,
    ),
    child: Text(text, style: const TextStyle(fontSize: 18, color: Colors.white)),
  );
}
