// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/loginScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_states.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.registerModel.status) {
              CacheHelper.setData(
                      key: "token", value: state.registerModel.data!.token)
                  .then((value) {
                token = state.registerModel.data!.token;
                showToast(
                    text: state.registerModel.message as String,
                    state: ToastStates.SUCCESS);
                navigateAndFinish(context, LoginScreen());
              });
            } else {
              showToast(
                  text: state.registerModel.message as String,
                  state: ToastStates.ERROR);
            }
          }
          else{
            if(state is RegisterErrorState){
              showToast(text: state.Error.toString(), state: ToastStates.ERROR);
            }
          }
        },
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
                        "Register",
                        style: TextStyle(
                          fontSize: 35,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "register now to see our latest offers",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "name cannot be empty";
                            }
                            return null;
                          },
                          label: "name",
                          labelStyle: TextStyle(color: primaryColor),
                          suffix: Icons.person),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Email cannot be empty";
                            } else {
                              if (!(value.contains('@') ||
                                  value.contains('.'))) {
                                return "pleas enter a valid email, example@mail.com ";
                              }
                            }
                            return null;
                          },
                          label: "email",
                          labelStyle: TextStyle(color: primaryColor),
                          suffix: Icons.email),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "phone cannot be empty";
                            }
                            return null;
                          },
                          label: "phone",
                          labelStyle: TextStyle(color: primaryColor),
                          suffix: Icons.phone),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.number,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "password cannot be empty";
                          }
                          return null;
                        },
                        label: "password",
                        labelStyle: TextStyle(color: primaryColor),
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            RegisterCubit.get(context).userRegister(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                            );
                            if (state is RegisterSuccessState) {
                              navigateAndFinish(context, LoginScreen());
                            }
                          }
                        },
                        isPassword: RegisterCubit.get(context).isPassword,
                        suffix: RegisterCubit.get(context).passwordIcon,
                        suffixPressed: () {
                          RegisterCubit.get(context).changePasswordState();
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultTextButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text);
                              if (state is RegisterSuccessState) {
                                navigateAndFinish(context, LoginScreen());
                              }
                            }
                          },
                          child: ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context) => Text(
                              "REGISTER",
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
                          Text("Already have an account ?"),
                          TextButton(
                              style: ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.fromLTRB(5, 0, 0, 0)),
                              ),
                              onPressed: () {
                                navigateTo(context, LoginScreen());
                              },
                              child: Text(
                                "login",
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
