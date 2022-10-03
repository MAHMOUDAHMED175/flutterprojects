import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pp/social_modules/social_register/cubit/cubit.dart';
import 'package:new_pp/social_modules/social_register/cubit/states.dart';

import '../../layout/news_app_layout/news_layout.dart';
import '../../shared/components/components.dart';

class RegisterScreen extends StatefulWidget {

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>socialRegisterCubit(),
        child: BlocConsumer<socialRegisterCubit , socialRegisterStates>(
          listener: (context, state) {},
          builder: (context, state){
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'TASAOQ',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          Text(
                            'REGISTER',
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          defaultFormField(
                            controller: nameController,
                            label: 'UserName',
                            prefix: Icons.person,
                            onSubmit: (value) {
                              if (formKey.currentState.validate()) {
                              }
                            },
                            validate: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return 'userName must not be empty';
                              }

                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                            controller: emailController,
                            label: 'Email',
                            prefix: Icons.email,
                            type: TextInputType.emailAddress,
                            onSubmit: (value) {
                              if (formKey.currentState.validate()) {

                              }
                            },
                            validate: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return 'email must not be empty';
                              }

                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                            controller: passwordController,
                            label: 'Password',
                            prefix: Icons.lock,
                            suffix: socialRegisterCubit.get(context).sufixIcon,
                            isPassword: socialRegisterCubit.get(context).isPassword,
                            suffixPressed: ()
                            {
                              setState(()
                              {
                                socialRegisterCubit.get(context).changePasswordVisibility();
                              });
                            },
                            type: TextInputType.visiblePassword,
                            onSubmit: (value){
                              if(formKey.currentState.validate())
                              {

                              }
                            },
                            validate: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return 'password is too short';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          defaultFormField(
                            controller:phoneController,
                            label: 'Phone',
                            prefix: Icons.phone,
                            type: TextInputType.phone,
                            onSubmit: (value) {
                              if (formKey.currentState.validate()) {

                              }
                            },
                            validate: (String value)
                            {
                              if(value.isEmpty)
                              {
                                return 'phone must not be empty';
                              }

                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! socialRegisterLoadingState,
                            builder:(context)=> defaultButton(
                              text: 'REGISTER',
                              onclick: ()
                              {

                                if(formKey.currentState.validate())
                                {
                                  socialRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text
                                  );

                                 // Navigator.push(context,MaterialPageRoute(builder:(context)=>NewsLayout() ));
                                }
                              },
                            ),
                          ),


                          SizedBox(
                            height: 10.0,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        )
    );

  }
}
