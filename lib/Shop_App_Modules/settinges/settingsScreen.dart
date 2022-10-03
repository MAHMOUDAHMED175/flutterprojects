import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pp/shared/components/components.dart';
import 'package:new_pp/shared/components/constants.dart';

import '../../Shop_App_layout/cubitShop/cubitShop.dart';
import '../../Shop_App_layout/cubitShop/statesShop.dart';


class settingsScreen extends StatelessWidget {
  @override
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  var passwordController=TextEditingController();
  var FormKey=GlobalKey<FormState>();
 bool isPasswordShowen =false;
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit,shopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var loginModel=shopCubit.get(context).loginModel;
        nameController.text=loginModel.data.name;
        emailController.text=loginModel.data.email;
        phoneController.text=loginModel.data.phone;

        return ConditionalBuilder(
          condition:state is!shopLoadingGetProfileState,
          builder:(context)=> SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: FormKey,
                child: Column(
                  children: [
                    if(state is shopLoadingUpdateProfileState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height:20.0,
                    ),
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      validate: (String value){

                        if(value.isEmpty)
                        {
                          return 'name must not be empty';
                        }
                      },
                      label: 'Your Name',
                      prefix: Icons.person,
                    ),
                    SizedBox(
                      height:20.0,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      label: 'Your Email',
                      validate: (String value){
                        if(value.isEmpty)
                        {
                          return 'email must not be empty';
                        }
                      },
                      prefix: Icons.email,
                    ),
                    SizedBox(
                      height:20.0,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String value){
                        if(value.isEmpty)
                        {
                          return 'phone must not be empty';
                        }
                      },
                      label: 'Your Phone',
                      prefix: Icons.phone,
                    ),
                    // SizedBox(
                    //   height:20.0,
                    // ),
                    // defaultFormField(
                    //   controller: passwordController,
                    //   type: TextInputType.visiblePassword,
                    //     validate: (String value){
                    //       if(value.isEmpty)
                    //       {
                    //         return 'password must not be empty';
                    //       }
                    //     },
                    //   label: 'Your Password',
                    //   prefix: Icons.password,
                    //   suffix: shopCubit.get(context).sufixIcon,
                    //   isPassword: shopCubit.get(context).isPasswordShowen,
                    //    suffixPressed: (){
                    //     shopCubit.get(context).changePasswordForProfile();
                    //    }
                    // ),
                    SizedBox(
                      height:20.0,
                    ),
                    defaultButton(
                      onclick: (){
                        if(FormKey.currentState.validate()){

                          shopCubit.get(context).updateProfile(
                            name:nameController.text,
                            email:emailController.text,
                            phone:phoneController.text,
                          );
                        }
                      },
                      isUpperCase: true,
                      text: 'update',

                    ),


                    SizedBox(
                      height:20.0,
                    ),
                    defaultButton(
                      onclick: (){
                        sinOut(context);
                      },
                      text: 'LOGOUT',

                    )
                  ],
                ),
              ),
            ),
          ),
          fallback:(context)=>Center(child: CircularProgressIndicator(),),
        );
      },

    );
  }
}
