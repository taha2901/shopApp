import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/components/show_toast.dart';
import 'package:shopapp/components/sign_out.dart';
import 'package:shopapp/cubits/login_cubit/login_cubit.dart';
import 'package:shopapp/cubits/register_cubit/register_cubit.dart';
import 'package:shopapp/cubits/shop_cubit/shops_cubit.dart';
import 'package:shopapp/helper/cach.dart';
import 'package:shopapp/layout/shop_app/shop_layout.dart';
import 'package:shopapp/widgets/custom_button.dart';
import 'package:shopapp/widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  var emailController = TextEditingController();
  var passWordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is ShopRegisterSuccess) {
            if (state.registerModel.status == true) {
              ChachHelper.saveData(
                      key: 'token', value: state.registerModel.data!.token)
                  .then((value) {
                token = state.registerModel.data!.token;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShopLayout(),
                  ),
                  (route) => false,
                );
              });
              print('The Token is ${state.registerModel.data!.token}');
              showToast(
                  msg: state.registerModel.message!,
                  state: ToastStates.SUCCESS);
            } else {
              print(state.registerModel.message);
              showToast(
                  msg: state.registerModel.message!, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    
                      Text(
                        'Register',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      Text('Register now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.grey)),
                      const SizedBox(
                        height: 30.0,
                      ),
                      CustomTextField(
                        hint: 'name',
                        prefixIcon: const Icon(Icons.person),
                        controller: nameController,
                        onSubmitted: (value) {
                          emailController.text = value;
                        },
                        type: TextInputType.name,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      CustomTextField(
                        hint: 'Email Address',
                        type: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email_outlined),
                        controller: emailController,
                        onSubmitted: (value) {
                          emailController.text = value;
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      CustomTextField(
                        hint: 'password',
                        prefixIcon: const Icon(Icons.lock_outlined),
                        obscure: RegisterCubit.get(context).isObsecure,
                        onSubmitted: (value) {
                          passWordController.text = value;
                        },
                        controller: passWordController,
                        suffixIcon: RegisterCubit.get(context).suffix,
                        suffixPressed: () {
                          RegisterCubit.get(context).changePasswordVisibility();
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      CustomTextField(
                        hint: 'phone',
                        prefixIcon: const Icon(Icons.phone),
                        type: TextInputType.phone,
                        onSubmitted: (value) {
                          passWordController.text = value;
                        },
                        controller: phoneController,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      state is ShopRegisterLoaded
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : CustomButton(
                              text: 'Register',
                              color: Colors.blue,
                              textcolor: Colors.white,
                              circular: 10.0,
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passWordController.text);
                                }
                              },
                            ),
                      const SizedBox(
                        height: 15.0,
                      ),
                     
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
