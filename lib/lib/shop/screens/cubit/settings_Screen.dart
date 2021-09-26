import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopppp/lib/shared/components.dart';
import 'package:shopppp/lib/shared/constants.dart';
import 'package:shopppp/lib/shop/cubit/cubit.dart';
import 'package:shopppp/lib/shop/cubit/states.dart';

class ShopSettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ShopCubit cubit = ShopCubit.get(context);

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object state) {
        var model = cubit.userModel;
        emailController.text = model.data.email;
        nameController.text = model.data.name;
        phoneController.text = model.data.phone;
        return ConditionalBuilder(
          condition: cubit.userModel != null,
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUserState)
                      LinearProgressIndicator(),
                    TextFormField(
                      controller: nameController,
                      onTap: () {},
                      keyboardType: TextInputType.name,
                      onChanged: (value) {},
                      onFieldSubmitted: (value) {},
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: emailController,
                      onTap: () {},
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {},
                      onFieldSubmitted: (value) {},
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'please enter your email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: phoneController,
                      onTap: () {},
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {},
                      onFieldSubmitted: (value) {},
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'please enter your phone';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        text: 'UPDATE',
                        function: () {
                          if(formKey.currentState.validate()){
                            ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }

                        }),

                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                      text: 'LOGOUT',
                      function: () {
                        signOut(context);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          fallback: (BuildContext context) {
            return Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}
