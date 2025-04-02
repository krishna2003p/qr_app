import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myfirstapp/screens/home/home_screen.dart';
import 'package:myfirstapp/screens/provider/auto_provider.dart';
import 'package:provider/provider.dart';
import '../common/custom_button.dart';
import '../loader/loader_provider.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
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
  Widget build(BuildContext context) {
    TextInputType keyboardType;
    List<TextInputFormatter>? inputFormatters;
    bool isPassword = inputType == "password";

    switch (inputType) {
      case "email":
        keyboardType = TextInputType.emailAddress;
        inputFormatters = [FilteringTextInputFormatter.deny(RegExp(r'\s'))];
        break;
      case "phone":
        keyboardType = TextInputType.phone;
        inputFormatters = [FilteringTextInputFormatter.digitsOnly];
        break;
      default:
        keyboardType = TextInputType.text;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
      child: isPassword
          ? _PasswordTextField(
        label: label,
        icon: icon,
        controller: controller,
        maxLength: maxLength,
      )
          : _RegularTextField(
        label: label,
        icon: icon,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        controller: controller,
        maxLength: maxLength,
      ),
    );
  }
}

// Widget for regular text fields
class _RegularTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final int maxLength;

  const _RegularTextField({
    required this.label,
    required this.icon,
    required this.keyboardType,
    this.inputFormatters,
    this.controller,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      decoration: _buildInputDecoration(icon, label),
      style: const TextStyle(fontSize: 16),
    );
  }
}

// Widget for password field with visibility toggle
class _PasswordTextField extends StatefulWidget {
  final String label;
  final IconData icon;
  final TextEditingController? controller;
  final int maxLength;

  const _PasswordTextField({
    required this.label,
    required this.icon,
    this.controller,
    required this.maxLength,
  });

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  final ValueNotifier<bool> _obscureText = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _obscureText,
      builder: (context, obscureText, child) {
        return TextField(
          controller: widget.controller,
          obscureText: obscureText,
          maxLength: widget.maxLength,
          decoration: _buildInputDecoration(
            widget.icon,
            widget.label,
            suffixIcon: IconButton(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
                child: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  key: ValueKey<bool>(obscureText),
                  color: Colors.grey,
                ),
              ),
              onPressed: () => _obscureText.value = !_obscureText.value,
            ),
          ),
          style: const TextStyle(fontSize: 16),
        );
      },
    );
  }
}

// Common Input Decoration
InputDecoration _buildInputDecoration(IconData icon, String label, {Widget? suffixIcon}) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(fontSize: 14, color: Colors.blueAccent),
    prefixIcon: Icon(icon, color: Colors.blueAccent),
    suffixIcon: suffixIcon,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.blue, width: 2),
    ),
    filled: true,
    fillColor: Colors.white.withValues(alpha: 0.95),
    counterText: "",
    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
  );
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
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
