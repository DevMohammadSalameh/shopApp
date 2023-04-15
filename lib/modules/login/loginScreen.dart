// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/login_cubit.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "LOGIN",
                        style: TextStyle(
                          fontSize: 35,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "login in now to see our latest offers",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(controller: emailController,
                          type: TextInputType.number,
                          validate: (value){
                            if (value!.isEmpty) {
                              return "Email cannot be empty";
                            } else {
                              if (!(value.contains('@') || value.contains('.'))) {
                                return "pleas enter a valid email, example@mail.com ";
                              }
                            }
                      },
                          label: "email",
                          labelStyle: TextStyle(color: primaryColor),
                          suffix: Icons.email),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          controller: passwordController,
                          type: TextInputType.number,
                          validate: (value){if(value!.isEmpty){
                            return "password cannot be empty";
                          }},
                          label: "password",
                          labelStyle: TextStyle(color: primaryColor),
                          onSubmit: (value){
                            if (formKey.currentState!.validate()) {
                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          isPassword: LoginCubit.get(context).isPassword,
                          suffix: LoginCubit.get(context).passwordIcon,
                        suffixPressed: (){
                          LoginCubit.get(context).changePasswordState();
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultTextButton(function: (){
                        if (formKey.currentState!.validate()) {
                          LoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text);
                        }
                      }, child: ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) => Text(
                          "JOIN",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        fallback: (context) => CircularProgressIndicator(
                          color: secondaryColor,
                        ),
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("forget password ?"),
                          TextButton(
                              onPressed: () {
                                //TODO: forget password screen
                              },
                              child: Text(
                                "Yes i did!",
                                style: TextStyle(color: primaryColor),
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          Text("Don't have an account ?"),
                          TextButton(
                              style: ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.fromLTRB(5, 0, 0, 0)),
                              ),
                              onPressed: () {
                                //TODO: create an account screen
                              },
                              child: Text(
                                "Create an account",
                                style: TextStyle(color: primaryColor),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
