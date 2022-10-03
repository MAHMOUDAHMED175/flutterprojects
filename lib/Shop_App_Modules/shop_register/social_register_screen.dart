import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pp/Shop_App_Modules/shop_register/cubit/cubit.dart';

import '../../Shop_App_layout/shopLayout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper/cacheHelper.dart';
import 'cubit/states.dart';

class shopRegisterScreen extends StatefulWidget {

  @override
  State<shopRegisterScreen> createState() => _shopRegisterScreenState();
}

class _shopRegisterScreenState extends State<shopRegisterScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>shopRegisterCubit(),
        child: BlocConsumer<shopRegisterCubit , shopRegisterStates>(
          listener: (context, state) {

            if(state is shopRegisterSuccessState){
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
                print(state.loginModel.message);
                print(state.loginModel.status);
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
                            suffix: shopRegisterCubit.get(context).sufixIcon,
                            isPassword: shopRegisterCubit.get(context).isPassword,
                            suffixPressed: ()
                            {
                              setState(()
                              {
                                shopRegisterCubit.get(context).changePasswordVisibility();
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
                            condition: state is! shopRegisterLoadingState,
                            builder:(context)=> defaultButton(
                              text: 'REGISTER',
                              onclick: ()
                              {

                                if(formKey.currentState.validate())
                                {
                                  shopRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text
                                  );

                               // Navigator.push(context,MaterialPageRoute(builder:(context)=>shopLayout() ));
                                }
                              },
                            ),
                            fallback: (context)=>Center(child: CircularProgressIndicator()),

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
