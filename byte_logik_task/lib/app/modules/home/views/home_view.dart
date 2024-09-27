import 'package:byte_logik_task/app/data/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  String getGreeting() {
    final hour = DateTime.now().hour; // Get the current hour

    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Byte Logik',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://bytelogik.com/wp-content/uploads/2022/06/logo.png'))),
                accountName: Text(controller.userModel.value?.username ?? '',style: const TextStyle(color: Colors.black),),
                accountEmail: Text(controller.userModel.value?.email ?? '',style: const TextStyle(color: Colors.blue),))),
            const SizedBox(height: 1,),
            SvgPicture.asset("assets/undraw_hello_re_3evm.svg"),
            const SizedBox(height: 1,),
            ElevatedButton.icon(
              onPressed: controller.logout,
              label: const Text("Log Out"),
              icon: const Icon(Icons.logout),
            ),
            const SizedBox(height: 1,)
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${getGreeting()} , Ajay\n ',
                    style: const TextStyle(
                      height: 1,
                      fontSize: 20, // Font size
                      fontWeight: FontWeight.bold, // Bold text// Text color
                    ),
                  ),
                  const Text('WelCome to Byte Logic'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: Image.asset(
                'assets/img.png',
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
                child: StreamBuilder(
              stream: Get.find<UserService>().streamUser(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    "Counter: ${snapshot.data!.counterValue}",
                    style: const TextStyle(
                        fontSize: 34, fontWeight: FontWeight.bold),
                  );
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return const Text(
                  "Counter:",
                  style: const TextStyle(
                      fontSize: 34, fontWeight: FontWeight.bold),
                );
              },
            )),
            SvgPicture.asset("assets/world_is_mine.svg",height: 200,),
            SizedBox(height: 10,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.increment(), // Increment the counter
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
