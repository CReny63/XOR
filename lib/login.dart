import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/splash2.dart'; // Update paths if needed
import '../services/theme_provider.dart';

class LoginPage extends StatefulWidget {
  final ThemeProvider themeProvider;

  const LoginPage({Key? key, required this.themeProvider}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  File? _image;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  // -------------------------
  //     LOAD / SAVE CREDS
  // -------------------------
  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');
    String? savedPassword = prefs.getString('password');

    if (savedUsername != null && savedPassword != null) {
      setState(() {
        usernameController.text = savedUsername;
        passwordController.text = savedPassword;
      });
    }
  }

  Future<void> _saveCredentials(
      String username, String password, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
    await prefs.setString('email', email);
  }

  // -------------------------
  //         SIGN IN
  // -------------------------
  Future<void> _handleSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');
    String? savedPassword = prefs.getString('password');

    if (savedUsername == null || savedPassword == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No saved credentials. Please sign up first.'),
        ),
      );
      return;
    }

    if (usernameController.text == savedUsername &&
        passwordController.text == savedPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign In Successful!')),
      );
      // Navigate to Splash2
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Splash2()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password.')),
      );
    }
  }

  // -------------------------
  //       VALIDATE PWD
  // -------------------------
  bool _validatePassword(String password) {
    // Must be >= 7 chars, include digit & special char
    final passwordRegex =
        RegExp(r'^(?=.*[!@#$%^&*(),.?":{}|<>])(?=.*\d).{7,}$');
    return passwordRegex.hasMatch(password);
  }

  // -------------------------
  //       SIGN UP DIALOG
  // -------------------------
  void _showSignUpDialog() {
    final TextEditingController signUpUsernameController =
        TextEditingController();
    final TextEditingController signUpPasswordController =
        TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Sign Up"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    // Profile Image Picker
                    GestureDetector(
                      onTap: () async {
                        final XFile? pickedFile = await _picker.pickImage(
                            source: ImageSource.gallery);
                        if (pickedFile != null) {
                          setStateDialog(() {
                            _image = File(pickedFile.path);
                          });
                        }
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey.shade300,
                        child: _image == null
                            ? const Icon(Icons.camera_alt, size: 40)
                            : ClipOval(
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: signUpUsernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: signUpPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Basic field checks
                    if (signUpUsernameController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        signUpPasswordController.text.isEmpty ||
                        confirmPasswordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('All fields are required.'),
                        ),
                      );
                      return;
                    }
                    // Password validation
                    if (!_validatePassword(signUpPasswordController.text)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Password must be at least 7 characters, '
                            'include 1 digit and 1 special character.',
                          ),
                        ),
                      );
                      return;
                    }
                    // Confirm password match
                    if (signUpPasswordController.text !=
                        confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Passwords do not match.'),
                        ),
                      );
                      return;
                    }
                    // Profile picture check
                    if (_image == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a profile picture.'),
                        ),
                      );
                      return;
                    }

                    // Save user credentials
                    await _saveCredentials(
                      signUpUsernameController.text,
                      signUpPasswordController.text,
                      emailController.text,
                    );

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Sign Up Successful!')),
                    );

                    // Navigate to Splash2
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Splash2()),
                    );
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // -------------------------
  //         BUILD UI
  // -------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient AppBar
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 188, 155, 142),
                Color.fromARGB(255, 120, 87, 65),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      // Milk Tea-like background
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 219, 191, 167), // Lighter milk-tea shade
              Color.fromARGB(255, 138, 103, 80), // Darker milk-tea shade
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        // Use SingleChildScrollView + Center + Column for a consistent, centered layout
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Container for username + password
                  Container(
                    width: 280, // narrower width
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(color: Colors.brown.shade300, width: 1),
                    ),
                    child: Column(
                      children: [
                        // Username
                        TextField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Password
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Forgot Password link
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Forgot password logic
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.brown),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Gap between container and buttons
                  const SizedBox(height: 20),

                  // Sign-In Button
                  SizedBox(
                    width: 280,
                    child: ElevatedButton(
                      onPressed: _handleSignIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Sign-In',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Sign-Up Button
                  SizedBox(
                    width: 280,
                    child: ElevatedButton(
                      onPressed: _showSignUpDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Sign-Up',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
