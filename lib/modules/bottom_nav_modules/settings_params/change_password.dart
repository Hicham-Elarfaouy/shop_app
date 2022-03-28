import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app6/shared/components/elements.dart';
import 'package:flutter_app6/shared/cubit/cubit.dart';
import 'package:flutter_app6/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => appCubit()..getProfileData(),
        child: BlocConsumer<appCubit, appStates>(
          listener: (context, state) {
            if(state is stateChangePassSuccess){
              if(state.passwordModel!.status == true){
                  showToast(msg: '${state.passwordModel!.message}', state: toastState.succes);
                  oldPassController.clear();
                  newPassController.clear();
              }else{
                showToast(msg: 'المرجوا التأكد من المعلومات المدخلة', state: toastState.error);
              }
            }else if(state is stateChangePassError){
              showToast(msg: 'فقد الاتصال بالخادم', state: toastState.warning);
            }
          },
          builder: (context, state) {
            appCubit cubit = appCubit.get(context);

                return Center(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: oldPassController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Old Password',
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                ),
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return "this field must not be empty";
                                }
                              },
                              onFieldSubmitted: (value){
                                formKey.currentState!.validate();
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: newPassController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'New Password',
                                prefixIcon: Icon(
                                  Icons.password,
                                ),
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return "this field must not be empty";
                                }
                              },
                              onFieldSubmitted: (value){
                                formKey.currentState!.validate();
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ConditionalBuilder(
                              condition: state is !stateChangePassLoading,
                              fallback: (context) => Center(child: CircularProgressIndicator()),
                              builder: (context) => MaterialButton(
                                color: Colors.blue,
                                minWidth: double.infinity,
                                height: 55,
                                onPressed: (){
                                  if(formKey.currentState!.validate()){
                                    cubit.postChangePassword(oldPass: oldPassController.text, newPass: newPassController.text);
                                  }
                                },
                                child: Text(
                                  'CHANGE',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
          },
        ),
      ),
    );
  }
}
