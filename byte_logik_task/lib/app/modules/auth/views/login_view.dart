import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/utils.dart';
import '../widgets/logInForm.dart';
class LoginView extends GetView {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    var width = Config.screenWidth;
    var height = Config.screenHeight;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:linearColor,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60,),
              SizedBox( height: height!/4, child: SvgPicture.asset("assets/undraw_secure_login_pdn4.svg")),
              SizedBox(height: height/50,),
              Center(
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Adjust corner radius as desired
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                    height: height* 0.55,
                    width: width! * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors:linearColor,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: width,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox( width: width,child: const Text("Log In",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30,height: 0.9),)),
                              Text("Glad to have your back",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: widgetColor)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        const LoginForm(),
                        Container(width:width,alignment: Alignment.topRight,child: TextButton(onPressed: (){Get.toNamed(Routes.RESET_PASSWORD);}, child: Text("Forgot Password ?",style: TextStyle(fontSize: 12,color: widgetColor),))),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Don’t have an account ?",style: TextStyle(fontSize: 12),),
                            TextButton(onPressed: (){Get.offNamed(Routes.SIGNUP);}, child: Text("Sign Up",style: TextStyle(color: widgetColor),))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

