import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodflutter/auth/login_status.dart';
import 'package:foodflutter/login_screen.dart';
import 'package:foodflutter/screen/home.dart';
import 'package:provider/provider.dart';

import 'auth/auth.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  final key = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(color: Colors.pink),
          child: Column(
            children: [
              const SizedBox(
                height: 90,
              ),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: const [
                      Center(
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.blue, fontSize: 44),
                        ),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Center(
                        child: Text(
                          "Please Create New Account",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
              Expanded(
                  child: Container(
                //decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(43))),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(34),
                        topLeft: Radius.circular(34))),
                //  Column(children: [ //if do this, it will error
                child: Padding(
                    padding: EdgeInsets.all(23),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            decoration:
                                const BoxDecoration(color: Colors.white),
                          ),
                          Form(
                              key: key,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1, color: Colors.pink))),
                                    child: TextFormField(
                                      controller: nameController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter Your Name",
                                      ),
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return "Name Must Not be Empty";
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1, color: Colors.pink))),
                                    child: TextFormField(
                                      controller: emailController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter Your Email",
                                      ),
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return "Email Must Not be Empty";
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  Container(
                                    // decoration: BoxDecoration(color: Colors.white   ),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1, color: Colors.red))),
                                    child: TextFormField(
                                      controller: passwordController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter Your Password",
                                      ),
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return "Password Must Not be Empty";
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen()));
                                      },
                                      child: const Text(
                                        "Please Login",
                                        style: TextStyle(
                                            color: Colors.pink, fontSize: 22),
                                      )),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    decoration:
                                        BoxDecoration(color: Colors.green),
                                    height: 45,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: OutlinedButton(
                                        onPressed: () async {
                                          // async
                                          if (key.currentState!.validate()) {
                                            Map<String, dynamic> status =
                                                await Auth().register(
                                                    emailController.text,
                                                    passwordController.text);

                                            if (status['status']) {
                                              // if status is true , use provider
                                              Provider.of<LoginStatus>(context,
                                                      listen: false)
                                                  .setStatus(true);
                                              //  Navigator.pop(context);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Home()));
                                            }
                                          }
                                        },
                                        child: const Text(
                                          "Register",
                                          style: TextStyle(
                                              color: Colors.blue, fontSize: 20),
                                        )),
                                  )
                                ],
                              ))
                        ],
                      ),
                    )),
              )
                  // ],),
                  )
            ],
          )),
    );
  }
}
