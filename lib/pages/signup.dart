import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:woodemo/api_service.dart';
import 'package:woodemo/models/customer.dart';
import 'package:woodemo/utils/form_helper.dart';
import 'package:woodemo/utils/progressHUD.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  APIService? apiService;
  CustomerModel? model;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isAPIcallprocess = false;

  @override
  void initState() {
    apiService = new APIService();
    model = new CustomerModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: true,
        title: Text('Sign Up'),
      ),
      body: ProgressHUD(
        child: Form(
          key: globalKey,
          child: _formUI(),
        ),
        inAsyncCall: isAPIcallprocess,
        opacity: 0.3,
      ),
    );
  }

  Widget _formUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHelper.fieldLabel("First Name"),
                FormHelper.textInput(
                  context,
                  model!.firstname,
                  (value) {
                    this.model?.firstname = value;
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Please Enter First Name';
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Last Name"),
                FormHelper.textInput(
                  context,
                  model!.lastname,
                  (value) {
                    this.model?.lastname = value;
                  },
                  onValidate: (value) {
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Email Id"),
                FormHelper.textInput(
                  context,
                  model!.email,
                  (value) {
                    this.model?.email = value;
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Please Enter Email';
                    }
                    if (value.toString().isNotEmpty &&
                        isEmail(value.toString())) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Password"),
                FormHelper.textInput(
                  context,
                  model!.password,
                  (value) {
                    this.model!.password = value;
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                  obscureText: hidePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: FormHelper.saveButton("Register", () {
                    if (validateAndSave()) {
                      print(model!.toJson());
                      setState(() {
                        isAPIcallprocess = true;
                      });

                      apiService!.createCustomer(model!).then((ret) {
                        setState(() {
                          isAPIcallprocess = false;
                        });

                        if (ret) {
                          FormHelper.showMessage(context, "WooCommerce App",
                              "Registration Successful", "Ok", () {
                            Navigator.of(context).pop();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => SignUp(),
                              ),
                            );
                          });
                        } else {
                          FormHelper.showMessage(context, "WooCommerce App",
                              "Email id already registered", "Ok", () {
                            Navigator.of(context).pop();
                          });
                        }
                      });
                    }
                  }),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => SignUp(),
                      ),
                    );
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
