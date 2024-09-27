import 'package:byte_logik_task/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/utils.dart';
import '../controllers/auth_controller.dart';
import '../widgets/SignUpForm.dart';
class SignupView extends GetView {
  const SignupView({super.key});
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
              SizedBox( height: height!/4, child: SvgPicture.asset("assets/undraw_hey_email_liaa (1).svg")),
              SizedBox(height: height/50,),
              Center(
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Adjust corner radius as desired
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                    height: height* 0.60,
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
                              SizedBox( width: width,child: Text("Create Your Account",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25,height: 0.9),)),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        const SignUpForm(),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Already have an account ?",style: TextStyle(fontSize: 12),),
                            TextButton(onPressed: (){Get.offNamed(Routes.LOGIN);}, child: Text("Log in",style: TextStyle(color: widgetColor),))
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
