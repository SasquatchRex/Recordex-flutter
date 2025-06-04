import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recordex/homepage.dart';
import '../../Processing/Provider/main_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ← MUST BE ADDED

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: null,
        body: Container(
          color: Colors.black,
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    Login_Widget(height: height,),
                    // Expanded(
                    //   flex: 4,
                    //   child: Container(
                    //     height: height,
                    //     color: Provider.of<AppColors>(context).appColors.background,
                    //       // color: Colors.red,
                    //     child: Column(
                    //           children: [
                    //             Text("hello")
                    //           ]
                    //         )
                    //
                    //   ),
                    // )
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  // child: Stack(
                  //   clipBehavior: Clip.hardEdge,
                  //   children: [
                  //     Positioned.fill(
                  //       child: SvgPicture.asset(
                  //         'assets/wave.svg',
                  //         fit: BoxFit.cover,
                  //       ),
                  //     ),
                  //     Column(
                  //         children: [
                  //           SizedBox(width: width,)
                  //         ]
                  //     )
                  //   ],),

                child: Container(
                  // clipBehavior: Clip.hardEdge,
                  alignment: Alignment.bottomCenter,
                  // width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    // color: Colors.red,
                    // color: Colors.red
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SvgPicture.asset(
                      'assets/wave.svg',
                      width: double.infinity,
                      fit: BoxFit.fitWidth,

                    ),
                  ) ,
                ),
              )
            ],
          ),
        )
      ),
    );
  }

}

class Login_Widget extends StatelessWidget {
  final height;
  const Login_Widget({
    super.key,
    required this.height
  });

  @override

  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        color: Colors.transparent,
        // height: 700.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Login to Recordex",
              style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.primaryText,
                fontSize: 28.sp,
                fontWeight: FontWeight.w600
              ),
            ),

            SizedBox(height: 0.02*height,),

            Container(
              margin: const EdgeInsets.only(top: 40, bottom: 10),
              child: Image.asset('assets/logo.png',scale: 4,),
            ),
            SizedBox(height: 40,),
            Container(
              margin:  EdgeInsets.all(10.0.r)
,
              width: 350.w,
              child: TextField(
                  controller: Provider.of<Login_Provider>(context,listen: false).username,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                    labelStyle:
                    const TextStyle(color: Colors.white60),
                  ),
                  style: const TextStyle(color: Colors.white)),
            ),
            Container(
              margin:  EdgeInsets.all(10.0.r)
,
              width: 350.w,
              child: TextField(
                  controller: Provider.of<Login_Provider>(context,listen: false).password,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.white60),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                    labelStyle:
                    const TextStyle(color: Colors.white60),
                  ),
                  obscureText: true,
                  style: const TextStyle(color: Colors.white)),
            ),

            Container(
              margin:  EdgeInsets.all(10.0.r)
,
              width: 300.w,
              height: 50.h,
              child: ElevatedButton(
                onPressed: ()async{
                  await Provider.of<Login_Provider>(context,listen: false).login(Provider.of<Login_Provider>(context,listen: false).username,Provider.of<Login_Provider>(context,listen: false).password);
                  if(Provider.of<Login_Provider>(context,listen: false).loggedin){
                    Provider.of<General>(context,listen: false).getToken();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Homepage()),
                          (Route<dynamic> route) => false,
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.greenAccent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                child:  Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            // Container(
            //   margin: const EdgeInsets.all(10.0.r)

            //   width: 300.w,
            //   height: 50.h,
            //   child: ElevatedButton(
            //
            //     onPressed: () {
            //
            //       // Add your button press logic here
            //     },
            //     style: ButtonStyle(
            //         backgroundColor:
            //         MaterialStateProperty.all<Color>(
            //             Colors.deepPurpleAccent),
            //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            //         RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(12),
            //         ),
            //       ),
            //     ),
            //     child: const Text('Sign In with Google',
            //         style: TextStyle(
            //             color: Colors.black, fontSize: 16.sp)),
            //   ),
            // ),

            Center(
              child: Padding(
                  padding:  EdgeInsets.all(16.0.r)
,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.pushAndRemoveUntil(
                      //   context,
                      //   // MaterialPageRoute(
                      //   //     builder: (context) =>
                      //   //     const SignUpView()),
                      //   //     (route) => false,
                      // );
                      // Add your button press logic here
                    },
                    child:  Text(
                      "Don't Already have an account? Contact admin",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.white54,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            ),
            if(Provider.of<Login_Provider>(context).error_msg !=null)
            AnimatedContainer(
              duration: Duration(milliseconds: 400),
              alignment: Alignment.center,

              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error,color: Colors.red,weight: 100,),
                  SizedBox(width: 10,),
                  Text(
                      "${Provider.of<Login_Provider>(context).error_msg}",
                    style: TextStyle(
                      color:  Provider.of<AppColors>(context).appColors.secondaryText
                    ),
                  )
                ],
              )
            ),
            if(Provider.of<Login_Provider>(context).loggedin ==true)
            Container(
              alignment: Alignment.center,

              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.safety_check,color: Colors.green,weight: 100,),
                  SizedBox(width: 10,),
                  Text(
                      "Successfully Logged in",
                    style: TextStyle(
                      color:  Provider.of<AppColors>(context).appColors.secondaryText
                    ),
                  )
                ],
              )
            )


          ],
        ),
      ),
    );
  }
}





