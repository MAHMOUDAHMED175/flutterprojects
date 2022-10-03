import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pp/social_modules/social_register/social_register_screen.dart';
import '../../layout/news_app_layout/news_layout.dart';
import '../../shared/components/components.dart';
import '../social_login/cubit/states.dart';
import 'cubit/cubit.dart';

class SocialLogin extends StatefulWidget {

  @override
  State<SocialLogin> createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>socialLoginCubit(),
      child: BlocConsumer<socialLoginCubit , socialLoginStates>(
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
                          'Login',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
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
                          suffix: socialLoginCubit.get(context).sufixIcon,
                          isPassword: socialLoginCubit.get(context).isPassword,
                          suffixPressed: ()
                          {
                            setState(()
                            {
                              socialLoginCubit.get(context).changePasswordVisibility();
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
                        ConditionalBuilder(
                          condition: state is! socialLoginLoadingState,
                          builder:(context)=> defaultButton(
                            text: 'LOGIN',
                            onclick: ()
                            {
                              if(formKey.currentState.validate())
                              {
                             //   Navigator.push(context,MaterialPageRoute(builder:(context)=>NewsLayout() ));

                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        // defaultButton(
                        //   text: 'ReGIster',
                        //   send: ()
                        //   {
                        //     if(formKey.currentState.validate())
                        //     print(emailController.text);
                        //     print(passwordController.text);
                        //   },
                        // ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            TextButton(
                              onPressed: () {},
                              child: TextButton(
                                child: Text('Register Now',),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=>RegisterScreen()
                                  ));
                                },
                              ),
                            ),
                          ],
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
