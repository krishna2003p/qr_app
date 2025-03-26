import 'package:flutter/material.dart';
import 'package:myfirstapp/screens/provider/auto_provider.dart';
import 'package:provider/provider.dart';
import 'auth_view.dart';
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black.withAlpha(5),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bgGif.gif'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(color: Colors.black.withValues(alpha: 0.5)),
          Column(
            children: [
              Expanded(child: Container()),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white.withValues(alpha: 0.95), Colors.blue.withValues(alpha: 0.2)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 1)],
                    ),
                    child: _buildAuthSection(authProvider),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAuthSection(AuthProvider authProvider) {
    switch (authProvider.currentView) {
      case 'register':
        return const RegisterView();
      case 'forgot':
        return const ForgotPasswordView();
      default:
        return const LoginView();
    }
  }
}
