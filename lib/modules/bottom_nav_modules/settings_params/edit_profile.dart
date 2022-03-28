import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app6/shared/components/elements.dart';
import 'package:flutter_app6/shared/cubit/cubit.dart';
import 'package:flutter_app6/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => appCubit()..getProfileData(),
        child: BlocConsumer<appCubit, appStates>(
          listener: (context, state) {
            if(state is stateEditProfileSuccess){
              if(state.editProfile!.status == true){
                showToast(msg: '${state.editProfile!.message}', state: toastState.succes);
              }else{
                showToast(msg: '${state.editProfile!.message}', state: toastState.error);
              }
            }else if(state is stateEditProfileError){
              showToast(msg: 'فقد الاتصال بالخادم', state: toastState.warning);
            }
          },
          builder: (context, state) {
            appCubit cubit = appCubit.get(context);


            return ConditionalBuilder(
              condition: cubit.profileData != null,
              fallback: (context) => Center(child: CircularProgressIndicator()),
              builder: (context) {
                nameController.text = cubit.profileData!.name!;
                emailController.text = cubit.profileData!.email!;
                phoneController.text = cubit.profileData!.phone!;

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
                              controller: nameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name',
                                prefixIcon: Icon(
                                  Icons.account_circle_outlined,
                                ),
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return "email must not be empty";
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
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email Address',
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                ),
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return "email must not be empty";
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
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Phone Number',
                                prefixIcon: Icon(
                                  Icons.phone,
                                ),
                              ),
                              validator: (value){
                                if(value!.isEmpty){
                                  return "email must not be empty";
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
                              condition: state is !stateEditProfileLoading,
                              fallback: (context) => Center(child: CircularProgressIndicator()),
                              builder: (context) => MaterialButton(
                                color: Colors.blue,
                                minWidth: double.infinity,
                                height: 55,
                                onPressed: (){
                                  if(formKey.currentState!.validate()){
                                    cubit.putEditProfile(name: nameController.text, email: emailController.text, phone: phoneController.text);
                                  }
                                },
                                child: Text(
                                  'UPDATE',
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
            );
          },
        ),
      ),
    );
  }
}
