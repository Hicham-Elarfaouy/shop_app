import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app6/modules/home_layout.dart';
import 'package:flutter_app6/shared/components/constants.dart';
import 'package:flutter_app6/shared/components/elements.dart';
import 'package:flutter_app6/shared/cubit/cubit.dart';
import 'package:flutter_app6/shared/cubit/states.dart';
import 'package:flutter_app6/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool isVisible = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appCubit(),
      child: BlocConsumer<appCubit,appStates>(
        listener: (context, state) {
          if(state is stateRegisterSuccess){
            if(state.userModel!.status == true){
              CacheHelper.putshared(key: 'isLogin', value: true).then((value) {
                navigateToAndFinish(context, HomeLayout());

                showToast(msg: '${state.userModel!.message}', state: toastState.succes);
                CacheHelper.putshared(key: 'token', value: state.userData!.token);
                token = state.userData!.token;
              }).catchError((error) {
                print(error.toString());
              });
            }else{
              showToast(msg: '${state.userModel!.message}', state: toastState.error);
            }
          }else if(state is stateRegisterError){
            showToast(msg: 'فقد الاتصال بالخادم', state: toastState.warning,);
          }
        },
        builder: (context, state) {
          appCubit cubit = appCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'REGISTER',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'register now to browse our hot offerts',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name',
                              prefixIcon: Icon(
                                Icons.text_fields,
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
                            controller: passwordController,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: isVisible ? false : true ,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              prefixIcon: Icon(
                                Icons.lock_outline,
                              ),
                              suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Icon(
                                  isVisible ? Icons.visibility : Icons.visibility_off,

                                ),
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
                            height: 30,
                          ),
                          ConditionalBuilder(
                            condition: state is !stateRegisterLoading,
                            fallback: (context) => Center(child: CircularProgressIndicator()),
                            builder: (context) => MaterialButton(
                              color: Colors.blue,
                              minWidth: double.infinity,
                              height: 55,
                              onPressed: (){
                                if(formKey.currentState!.validate()){
                                  cubit.checkUserRegister(
                                    email: emailController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              child: Text(
                                'REGISTER',
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
              ),
            ),
          );
        },
      ),
    );
  }
}
