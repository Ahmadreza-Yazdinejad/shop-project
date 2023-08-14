import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auhtentication/authentication_event.dart';
import '../../bloc/auhtentication/authentication_bloc.dart';
import '../../../constants/colors.dart';
import '../../bloc/auhtentication/authentication_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _passwordConfirmTextController =
      TextEditingController();
  bool _passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                      height: 100,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'اپل شاپ',
                      style: TextStyle(
                          fontFamily: 'SB', fontSize: 24, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
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
                            borderSide:
                                const BorderSide(width: 2, color: Colors.black),
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
                          labelText: 'رمز عبور',
                          labelStyle: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'SM',
                              color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(width: 2, color: Colors.black),
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
                        controller: _passwordConfirmTextController,
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
                          labelText: 'تکرار رمز عبور',
                          labelStyle: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'SM',
                              color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(width: 2, color: Colors.black),
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
                                  AuthRegisterRequiest(
                                      _usernameTextController.text,
                                      _passwordTextController.text,
                                      _passwordConfirmTextController.text),
                                );
                              },
                              child: const Text('ثبت نام'),
                            );
                          }
                          if (state is AuthLoading) {
                            return const CircularProgressIndicator();
                          }
                          if (state is AuthRegisterGetData) {
                            Text widtet = const Text('');
                            state.AuthRegister.fold(
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
                    ],
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
