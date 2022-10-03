



import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Shop_App_layout/shopLayout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper/cacheHelper.dart';
import '../shop_register/social_register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class shopLogin extends StatefulWidget {

  @override
  State<shopLogin> createState() => _shopLoginState();
}

class _shopLoginState extends State<shopLogin> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>shopLoginCubit(),
        child: BlocConsumer<shopLoginCubit , shopLoginStates>(
          listener: (context, state) {
            if(state is shopLoginSuccessState){
              if(state.loginModel.status){
                // دى علشان تظهر رساله كدا على السريع بنقول فيها لليوزر مبروك او error
                // Fluttertoast.showToast(
                //     msg:state.loginModel.message,// "اكتب الايميل والباسورد صح ياابن الناصح "
                //     toastLength: Toast.LENGTH_LONG,
                //     gravity: ToastGravity.SNACKBAR,
                //     timeInSecForIosWeb: 4,
                //     backgroundColor: Colors.white,
                //     textColor: Colors.black,
                //     fontSize: 20.2
                // );
                showToast(
                    text: state.loginModel.message,
                    state:ToastStates.SUCCESS
                );
                CacheHelper.savedata(
                    key: 'token',
                    value: state.loginModel.data.token
                ).then((value){
                  token=state.loginModel.data.token;

                  navigateAndFinish(context, shopLayout());
                });

              }else{

                showToast(
                    text: state.loginModel.message,
                    state:ToastStates.ERROR
                );
              }
            }
            
            
          },
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
                            suffix: shopLoginCubit.get(context).sufixIcon,
                            isPassword: shopLoginCubit.get(context).isPassword,
                            suffixPressed: ()
                            {
                              setState(()
                              {
                                shopLoginCubit.get(context).changePasswordVisibility();
                              });
                            },
                            type: TextInputType.visiblePassword,
                            onSubmit: (value){
                              if(formKey.currentState.validate())
                              {

                                shopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
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
                            condition: state is! shopLoginLoadingState,
                            builder:(context)=> defaultButton(
                              text: 'LOGIN',
                              isUpperCase: true,


                              onclick: ()
                              {
                                if(formKey.currentState.validate())
                                {
                                  //   Navigator.push(context,MaterialPageRoute(builder:(context)=>NewsLayout() ));

                                  shopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                  );
                                }
                                return null;
                              },
                            ),
                            fallback: (context)=>Center(child: CircularProgressIndicator()),
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
                                        builder: (context)=>shopRegisterScreen()
                                    )
                                   );
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
