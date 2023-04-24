
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../layout/cubit/layout_cubit.dart';
import '../../layout/cubit/layout_states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

   SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopLayoutCubit.get(context).userModel;

        nameController.text = model!.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;

        return ConditionalBuilder(
          condition: ShopLayoutCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children:
                [
                  // if(state is ShopLoadingUpdateUserState)
                  //   LinearProgressIndicator(),
                  // SizedBox(
                  //   height: 20.0,
                  // ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: ( value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }

                      return null;
                    },
                    label: 'Name',
                    labelStyle: const TextStyle(color: primaryColor),
                    prefix: Icons.person,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: ( value) {
                      if (value!.isEmpty) {
                        return 'email must not be empty';
                      }

                      return null;
                    },
                    label: 'Email Address',
                    labelStyle: const TextStyle(color: primaryColor),
                    prefix: Icons.email,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'phone must not be empty';
                      }

                      return null;
                    },
                    label: 'Phone',
                    labelStyle: const TextStyle(color: primaryColor),
                    prefix: Icons.phone,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultTextButton(
                    function: ()
                    {
                      if(formKey.currentState!.validate())
                      {
                        ShopLayoutCubit.get(context).updateUserData(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                        );
                      }
                    },
                    child: const Text(
                      "UPDATE",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultTextButton(
                    function: () {
                      signOut(context);
                    },
                    child: const Text(
                      "LOGOUT",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}