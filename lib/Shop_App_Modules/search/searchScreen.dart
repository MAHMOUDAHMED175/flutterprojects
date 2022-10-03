import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pp/Shop_App_Modules/search/searchCubit.dart';
import 'package:new_pp/Shop_App_Modules/search/searchStates.dart';
import 'package:new_pp/shared/components/components.dart';
class searchScreen extends StatelessWidget {
  @override
  var searchController=TextEditingController();
  var FormKey=GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>searchCupit(),
      child: BlocConsumer<searchCupit,searchStates>(
          listener:(context, state) {},
          builder:(context, state) {
            return Scaffold(
              appBar: AppBar(
                title:
                  Text('TASAOQ',
                  style: TextStyle(

                      color: Colors.deepOrangeAccent

                  ),
                  ),

              ),
              body: Form(
                key: FormKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                        controller:searchController,
                        type: TextInputType.text,
                        validate: (String value){
                          {
                            if(value.isEmpty){
                              return 'type to search';
                            }
                            return null;
                          }
                        },
                        onSubmit: (String text){

                          searchCupit.get(context).search(text);


                          if(FormKey.currentState.validate());
                        },
                        label: 'search',
                        prefix: Icons.search,
                      ),

                      SizedBox(
                        height:20.0,
                      ),

                      if(state is searchLoadingState)
                        LinearProgressIndicator(),



                      SizedBox(
                        height:20.0,
                      ),
                      if(state is searchSuccessState)
                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context,index)=>BuildListProduct(searchCupit.get(context).model.data.data[index],context),
                            separatorBuilder: (context,index)=>SizedBox(
                              height: 10.0,
                            ),
                            itemCount: searchCupit.get(context).model.data.data.length,
                          ),
                        ),



                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
