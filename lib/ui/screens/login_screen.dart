import 'package:apple_shop/ui/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auhtentication/authentication_event.dart';
import '../../bloc/auhtentication/authentication_bloc.dart';
import '../../../constants/colors.dart';
import '../../bloc/auhtentication/authentication_state.dart';
import '../../dependency_injection/di.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  bool _passwordVisible = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: CustomColor.blue,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/icon_application.png',
                      width: 100,
                      height: 94,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'اپل شاپ',
                      style: TextStyle(
                          fontFamily: 'SB', fontSize: 21, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Expanded(
                  child: Container(
                    height: 326,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: _usernameTextController,
                          decoration: InputDecoration(
                            labelText: 'نام کاربری',
                            labelStyle: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'SM',
                                color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  width: 3, color: CustomColor.blue),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          obscureText: _passwordVisible,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: _passwordTextController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: _passwordVisible
                                  ? const Icon(
                                      Icons.remove_red_eye,
                                      color: CustomColor.blue,
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                      color: CustomColor.blue,
                                    ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            labelText: 'رمز عبور',
                            labelStyle: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'SM',
                                color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  width: 2, color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  width: 3, color: CustomColor.blue),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthInitial) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(200, 48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'SB',
                                      color: Colors.white),
                                ),
                                onPressed: () {
                                  BlocProvider.of<AuthBloc>(context).add(
                                    AuthLoginRequiest(
                                      _usernameTextController.text,
                                      _passwordTextController.text,
                                    ),
                                  );
                                },
                                child: const Text('ورود به حساب کاربری'),
                              );
                            }
                            if (state is AuthLoading) {
                              return const CircularProgressIndicator();
                            }
                            if (state is AuthLoginGetData) {
                              Text widtet = const Text('');
                              state.AuthLogin.fold(
                                (l) {
                                  return widtet = Text(l);
                                },
                                (r) {
                                  return widtet = Text(r);
                                },
                              );
                              return widtet;
                            }
                            return const Text('');
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider<AuthBloc>(
                                  create: (context) => locator.get<AuthBloc>(),
                                  child: const RegisterScreen(),
                                ),
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'حساب کاربری ندارید؟',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'SM',
                                    color: Colors.black),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                'اینجا کلیک کنید',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'SM',
                                    color: CustomColor.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
