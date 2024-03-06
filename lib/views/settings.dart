import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/components/sign_out.dart';
import 'package:shopapp/cubits/shop_cubit/shops_cubit.dart';
import 'package:shopapp/styles/colors.dart';
import 'package:shopapp/widgets/custom_button.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocConsumer<ShopsCubit, ShopsState>(
      listener: (context, state) {
        if (state is ShopSucessUsersState) {
          nameController.text = state.loginModel.data!.name;
          emailController.text = state.loginModel.data!.email;
          phoneController.text = state.loginModel.data!.phone;
        }
      },
      builder: (context, state) {
        var model = ShopsCubit.get(context).usersModel;
        nameController.text = model!.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;
        return ConditionalBuilder(
          condition: ShopsCubit.get(context).usersModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: nameController,
                      label: 'Enter Name',
                      prefix: Icons.person,
                      type: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'name must be not empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: emailController,
                      label: 'Enter Email',
                      prefix: Icons.mail,
                      type: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'email must be not empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      label: 'Enter Phone',
                      prefix: Icons.phone,
                      type: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'phone must be not empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomButton(
                      text: 'Logout',
                      color: defaultColor,
                      textcolor: Colors.white,
                      circular: 10,
                      onTap: () {
                        signOut(context);
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomButton(
                      text: 'Update',
                      color: Colors.blue,
                      textcolor: Colors.white,
                      circular: 10.0,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          ShopsCubit.get(context).updateUserData(
                            name: nameController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
