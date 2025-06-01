import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ← MUST BE ADDED
import '../../Processing/Provider/main_provider.dart';
import '../topside.dart';

class Employees extends StatefulWidget {
  const Employees({super.key});

  @override
  State<Employees> createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {

  void initState() {
    super.initState();

    // This is where you call your provider method
    Future.microtask(()async {
      await Provider.of<EmployeesProvider>(context, listen: false).getEmployee();
    });
  }

  @override
  Widget build(BuildContext context) {

    return  LayoutBuilder(
      builder: (context,constraints) {
        final width = constraints.maxWidth;


        return Column(

          children: [
            Expanded(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                curve: Curves.linear,
                padding: EdgeInsets.only(right: 50.w),
                child: Container(
                  // width: widget.fullMenu? 0.6 * MediaQuery.of(context).size.width : 0.69* MediaQuery.of(context).size.width,
                  // color: Colors.red,
                    alignment: Alignment.topLeft,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Manage Employees",
                                style: TextStyle(
                                    fontSize: 24.sp, color: Provider.of<AppColors>(context).appColors.primaryText, fontWeight: FontWeight.w600),
                              ),
                              ElevatedButton(
                                  onPressed:()=> Provider.of<EmployeesProvider>(context,listen: false).toggle_employee_space(),
                                  child: Text(
                                    !Provider.of<EmployeesProvider>(context,).add_employee_space?"Add Employee" : "Close",
                                    style: TextStyle(
                                        // color: Provider.of<AppColors>(context).appColors.primaryText,
                                      color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(!Provider.of<EmployeesProvider>(context,).add_employee_space?Colors.green:Colors.red),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5), // roundness
                                      side: BorderSide(color:!Provider.of<EmployeesProvider>(context,).add_employee_space? Colors.green : Colors.red, width: 2.w), // border
                                    ),
                                  ),

                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 40.h,),
                          Wrap(
                            spacing: 15, // horizontal spacing
                            runSpacing: 15,
                            children: Provider.of<EmployeesProvider>(context,listen: false).decoded_response
                                .map<Widget>((employee) => GestureDetector(
                              onTap: ()async {
                                // print(item);
                                await Provider.of<EmployeesProvider>(context,listen: false).getEmployeelogs(employee['id']);
                                showOverlay(context,employee);
                              },
                              child: Container(
                                width: 200.w,
                                // height: 70.h,
                                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Provider.of<AppColors>(context).appColors.primary,
                                  borderRadius: BorderRadius.circular(10),
                                  // border: Border.all(color: item['Remaining Quantity'] < 5 ? Colors.red :item['Remaining Quantity'] < 10? Colors.orange: Colors.green),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: item['Remaining Quantity'] < 5 ? Colors.red :item['Remaining Quantity'] < 10? Colors.orange: Colors.green, // shadow color
                                  //     spreadRadius: 2,  // how wide the shadow spreads
                                  //     blurRadius: 15,    // how blurry the shadow is
                                  //     offset: Offset(0, 2), // position of shadow: x (right), y (down)
                                  //   ),
                                  // ],
                                ),
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircleAvatar(
                                      foregroundColor:Colors.white,
                                      backgroundColor:Colors.grey,
                                      radius: 50,
                                      child: Icon(
                                        Icons.person,
                                        size: 90.r,
                                      ),
                                    ),
                                    SizedBox(height: 12.h,),
                                    Text(
                                        "${employee["name"]}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Provider.of<AppColors>(context).appColors.primaryText,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15.sp
                                      ),
                                    ),
                                    Text(
                                        "${employee["position"]}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Provider.of<AppColors>(context).appColors.secondaryText,
                                        fontWeight: FontWeight.w700,
                                          fontSize: 13.sp
                                      ),
                                    ),
                                    Text(
                                        "Salary : Rs. ${employee["monthlySalary"]}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Provider.of<AppColors>(context).appColors.secondaryText,
                                        fontWeight: FontWeight.w600,
                                          fontSize: 13.sp
                                      ),
                                    ),
                                    Text(
                                        "${employee["contact"]}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Provider.of<AppColors>(context).appColors.QuaternaryText,
                                          fontSize: 13.sp
                                      ),
                                    ),
                                    // SizedBox(height: 10.h,),

                                    // SizedBox(height: 10.h,),

                                  ],
                                ),
                              ),
                            ))
                                .toList(),
                          )

                        ],
                      ),
                    )
                ),
              ),
            ),
            if(Provider.of<EmployeesProvider>(context,).add_employee_space == true)
              SizedBox(height: 30.h,),
            if(Provider.of<EmployeesProvider>(context,).add_employee_space == true)
              Container(
              // height: 200.h,
              margin: EdgeInsets.only(right: 50),
              padding: EdgeInsets.all( 30),
              color: Provider.of<AppColors>(context).appColors.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 200.w,
                    child: CircleAvatar(
                      foregroundColor:Colors.white,
                      backgroundColor:Colors.grey,
                      radius: 55,
                      child: Icon(
                        Icons.person,
                        size: 75,
                      ),

                    ),
                  ),
                  SizedBox(width: 30.w,),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 350.w,
                            // color: Colors.white,
                            child: TextField(
                              controller: Provider.of<EmployeesProvider>(context,).name,
                              style: TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText),
                              cursorColor:Provider.of<AppColors>(context).appColors.primaryText ,
                              decoration: InputDecoration(
                                fillColor: Provider.of<AppColors>(context).appColors.secondary ,
                                labelText: 'Name',
                                labelStyle: TextStyle(color: Provider.of<AppColors>(context).appColors.secondaryText),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Provider.of<AppColors>(context).appColors.primary), // Change focus border color here
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black), // Change focus border color here
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          Container(
                            width: 350,
                            // color: Colors.white,
                            child: TextField(
                              controller: Provider.of<EmployeesProvider>(context,).position,
                              style: TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText),
                              cursorColor:Provider.of<AppColors>(context).appColors.primaryText ,

                              decoration: InputDecoration(
                                fillColor: Provider.of<AppColors>(context).appColors.secondary ,
                                labelText: 'Position',
                                labelStyle: TextStyle(color: Provider.of<AppColors>(context).appColors.secondaryText),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Provider.of<AppColors>(context).appColors.primary), // Change focus border color here
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black), // Change focus border color here
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                  Expanded(
                      child: Column(
                      children: [
                        Container(
                          width: 250,
                          // color: Colors.white,
                          child: TextField(
                            controller: Provider.of<EmployeesProvider>(context,).salary,
                            inputFormatters:[
                              LengthLimitingTextInputFormatter(9), // max 5 digits
                              FilteringTextInputFormatter.digitsOnly, // only digits

                            ],
                            cursorColor:Provider.of<AppColors>(context).appColors.primaryText ,

                            style: TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText),
                            decoration: InputDecoration(
                              fillColor: Provider.of<AppColors>(context).appColors.secondary ,
                              labelText: 'Monthly Salary',
                              labelStyle: TextStyle(color: Provider.of<AppColors>(context).appColors.secondaryText),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Provider.of<AppColors>(context).appColors.primary), // Change focus border color here
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black), // Change focus border color here
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Container(
                          width: 250,
                          // color: Colors.white,
                          child: TextField(
                            controller: Provider.of<EmployeesProvider>(context,).contact,
                            inputFormatters:[
                              LengthLimitingTextInputFormatter(10), // max 5 digits
                              FilteringTextInputFormatter.digitsOnly, // only digits

                            ],
                            cursorColor:Provider.of<AppColors>(context).appColors.primaryText ,

                            style: TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText),
                            decoration: InputDecoration(
                              fillColor: Provider.of<AppColors>(context).appColors.secondary ,
                              labelText: 'Contact Number',
                              labelStyle: TextStyle(color: Provider.of<AppColors>(context).appColors.secondaryText),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Provider.of<AppColors>(context).appColors.primary), // Change focus border color here
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black), // Change focus border color here
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                  ElevatedButton(
                    onPressed:()async{
                      await Provider.of<EmployeesProvider>(context,listen: false).addEmployee();
                      await Provider.of<EmployeesProvider>(context,listen: false).getEmployee();

                      },
                    child: Text(
                      "Save",
                      style: TextStyle(
                        // color: Provider.of<AppColors>(context).appColors.primaryText,
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600
                      ),
                      textAlign: TextAlign.center,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5), // roundness
                          side: BorderSide(color: Colors.green, width: 2), // border
                        ),
                      ),

                    ),
                  ),



                ],
              ),
            )
          ],
        );
      }
    );
  }

}

late OverlayEntry _overlayEntry;

void showOverlay(BuildContext context,Map employee) {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  _overlayEntry = OverlayEntry(
    builder: (context) => Stack(
      children: [
        GestureDetector(
          onTap: hideOverlay,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.3), // Optional darken layer
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
        Center(
          child: Material(
            // Needed to make it look like a normal widget
            elevation: 4.0,
            color: Colors.transparent,
            shape: RoundedRectangleBorder(),
            child: Container(
                width: 0.75 * width,
                height: 0.75 * height,
                padding: EdgeInsets.all(20.r)
,
                color: Provider.of<AppColors>(context).appColors.primary,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: hideOverlay,
                        icon: Icon(Icons.close, color: Colors.red),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        // left: 0,
                        child: Text(
                          "Employee Details",
                          style: TextStyle(
                              color: Provider.of<AppColors>(context).appColors.primaryText,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w600
                          ),
                        )
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: ElevatedButton(
                          onPressed:()async{
                          //   await Provider.of<EmployeesProvider>(context,listen: false).sendRequest();
                          //   if(Provider.of<EmployeesProvider>(context,listen: false).responseCode == 200){
                          //     hideOverlay();
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(
                          //         content: Text(
                          //           'Successfully Updated',
                          //           style: TextStyle(
                          //             color: Provider.of<AppColors>(context,listen: false).appColors.primaryText,
                          //           ),
                          //         ),
                          //         duration: Duration(seconds: 4),
                          //         backgroundColor: Provider.of<AppColors>(context,listen: false).appColors.success,
                          //
                          //       ),
                          //     );
                          //   }
                          //   else{
                          //     hideOverlay();
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(
                          //         content: Text(
                          //           'Update Failed. Contact Admin',
                          //           style: TextStyle(
                          //             color: Provider.of<AppColors>(context,listen: false).appColors.primaryText,
                          //           ),
                          //         ),
                          //         duration: Duration(seconds: 4),
                          //         backgroundColor: Provider.of<AppColors>(context,listen: false).appColors.fail,
                          //
                          //       ),
                          //     );
                          //   }
                          },

                          child: Text(
                            "Save",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600
                            ),
                            textAlign: TextAlign.center,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.green),
                            // padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 4,horizontal: 8)),
                          ),
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60.0,horizontal: 10),
                      child: Row(
                        children: [
                          SingleChildScrollView(

                            child: Container(
                              color: Provider.of<AppColors>(context).appColors.secondary,
                              width: 0.3*width,
                              height: 0.6*height,
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              foregroundColor:Colors.white,
                                              backgroundColor:Colors.grey,
                                              radius: 50.r,
                                              child: Icon(
                                                Icons.person,
                                                size: 90.r,
                                              ),
                                            ),
                                            SizedBox(height: 10.h,),
                                            Text(
                                              "${employee['name']}",
                                              style: TextStyle(
                                                  color: Provider.of<AppColors>(context).appColors.primaryText,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20.sp
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      color: Provider.of<AppColors>(context).appColors.primary,
                                      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 15.h),
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              "Edit Employee's Details",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Provider.of<AppColors>(context).appColors.primaryText,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20.sp
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20.h,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 200.w,
                                                alignment: Alignment.topLeft,
                                                // color: Colors.white,
                                                child: TextField(
                                                  controller: Provider.of<EmployeesProvider>(context,).amount,
                                                  inputFormatters:[
                                                    LengthLimitingTextInputFormatter(10), // max 5 digits
                                                    FilteringTextInputFormatter.digitsOnly, // only digits

                                                  ],
                                                  cursorColor:Provider.of<AppColors>(context).appColors.primaryText ,

                                                  style: TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText),
                                                  decoration: InputDecoration(
                                                    fillColor: Provider.of<AppColors>(context).appColors.secondary ,
                                                    labelText: 'Post',
                                                    labelStyle: TextStyle(color: Provider.of<AppColors>(context).appColors.secondaryText),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Provider.of<AppColors>(context).appColors.primary), // Change focus border color here
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.black), // Change focus border color here
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // SizedBox(width: 20,),
                                              Container(
                                                width: 200.w,
                                                alignment: Alignment.topLeft,
                                                // color: Colors.white,
                                                child: TextField(
                                                  controller: Provider.of<EmployeesProvider>(context,).amount,
                                                  inputFormatters:[
                                                    LengthLimitingTextInputFormatter(10), // max 5 digits
                                                    FilteringTextInputFormatter.digitsOnly, // only digits

                                                  ],
                                                  cursorColor:Provider.of<AppColors>(context).appColors.primaryText ,

                                                  style: TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText),
                                                  decoration: InputDecoration(
                                                    fillColor: Provider.of<AppColors>(context).appColors.secondary ,
                                                    labelText: 'Contact No',
                                                    labelStyle: TextStyle(color: Provider.of<AppColors>(context).appColors.secondaryText),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Provider.of<AppColors>(context).appColors.primary), // Change focus border color here
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(color: Colors.black), // Change focus border color here
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Container(height: 250,),
                                    Container(
                                      color: Provider.of<AppColors>(context).appColors.primary,
                                      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 15.h),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Text(
                                                "Salary Payment",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Provider.of<AppColors>(context).appColors.primaryText,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20.sp
                                                ),
                                            ),
                                          ),
                                          SizedBox(height: 20.h,),
                                          Container(
                                            width: 250.w,
                                            alignment: Alignment.topLeft,
                                            // color: Colors.white,
                                            child: TextField(
                                              controller: Provider.of<EmployeesProvider>(context,).amount,
                                              inputFormatters:[
                                                LengthLimitingTextInputFormatter(10), // max 5 digits
                                                FilteringTextInputFormatter.digitsOnly, // only digits

                                              ],
                                              cursorColor:Provider.of<AppColors>(context).appColors.primaryText ,

                                              style: TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText),
                                              decoration: InputDecoration(
                                                fillColor: Provider.of<AppColors>(context).appColors.secondary ,
                                                labelText: 'Amount',
                                                labelStyle: TextStyle(color: Provider.of<AppColors>(context).appColors.secondaryText),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Provider.of<AppColors>(context).appColors.primary), // Change focus border color here
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.black), // Change focus border color here
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10.h,),
                                          Container(
                                            width: 250.w,
                                            // color: Colors.white,
                                            child: TextField(
                                              controller: Provider.of<EmployeesProvider>(context,).reason,
                                              cursorColor:Provider.of<AppColors>(context).appColors.primaryText ,

                                              style: TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText),
                                              decoration: InputDecoration(
                                                fillColor: Provider.of<AppColors>(context).appColors.secondary ,
                                                labelText: 'Reason',
                                                labelStyle: TextStyle(color: Provider.of<AppColors>(context).appColors.secondaryText),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Provider.of<AppColors>(context).appColors.primary), // Change focus border color here
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.black), // Change focus border color here
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20.h,),
                                          Container(
                                            width: 250.w,
                                            // color: Colors.white,
                                            child: TextField(
                                              controller: Provider.of<EmployeesProvider>(context,).dateController,
                                              cursorColor:Provider.of<AppColors>(context).appColors.primaryText ,
                                              inputFormatters: [LengthLimitingTextInputFormatter(10), DateInputFormatter()],
                                              style: TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText),
                                              decoration: InputDecoration(
                                                fillColor: Provider.of<AppColors>(context).appColors.secondary ,
                                                labelText: 'Date of Transaction (YYYY-MM-DD)',
                                                labelStyle: TextStyle(color: Provider.of<AppColors>(context).appColors.secondaryText),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Provider.of<AppColors>(context).appColors.primary), // Change focus border color here
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.black), // Change focus border color here
                                                ),
                                              ),
                                            ),
                                          ),

                                          SizedBox(height: 20.h,),
                                          if(Provider.of<EmployeesProvider>(context,).reason.text != "" && Provider.of<EmployeesProvider>(context,).amount.text != "")
                                          Align(
                                            alignment: Alignment.center,
                                            child: ElevatedButton(
                                              onPressed:()async{
                                                await Provider.of<EmployeesProvider>(context,listen: false).postLog(employee['id']);
                                                await Provider.of<EmployeesProvider>(context,listen: false).getEmployeelogs(employee['id']);
                                              },
                                              child: Text(
                                                "Add Log",
                                                style: TextStyle(
                                                  // color: Provider.of<AppColors>(context).appColors.primaryText,
                                                    color: Colors.white,
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.w600,

                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(Colors.red),
                                                alignment: Alignment.center,
                                                padding: MaterialStateProperty.all(
                                                  EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                                ),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5),
                                                    side: BorderSide(color: Colors.red, width: 2),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20.h,),

                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    // color: Provider.of<AppColors>(context).appColors.secondary,
                                    padding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
                                    margin: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                                    height: 30.h,
                                    // width: 0.5*width,
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex:1,
                                            child: Text(
                                              "S.N.",
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  color: Provider.of<AppColors>(context).appColors.primaryText
                                              ),
                                            )
                                        ),
                                        Expanded(
                                            flex:5,
                                            child: Text(
                                              "Reason",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  color: Provider.of<AppColors>(context).appColors.primaryText
                                              ),
                                            )
                                        ),
                                        Expanded(
                                            flex:2,
                                            child: Text(
                                              "Amount",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  color: Provider.of<AppColors>(context).appColors.primaryText
                                              ),
                                            )
                                        ),
                                        Expanded(
                                            flex:2,
                                            child: Text(
                                              "Date",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  color: Provider.of<AppColors>(context).appColors.primaryText
                                              ),
                                            )
                                        ),

                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.h,),
                                  SingleChildScrollView(
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: Provider.of<EmployeesProvider>(context,listen:false).decoded_response_logs.length,
                                      itemBuilder: (context,index){
                                        dynamic log = Provider.of<EmployeesProvider>(context,listen:false).decoded_response_logs[index] ;
                                        return Container(
                                          color: Provider.of<AppColors>(context).appColors.secondary,
                                          padding: EdgeInsets.symmetric(vertical: 4,horizontal: 10),
                                          margin: EdgeInsets.symmetric(vertical: 2,horizontal: 5),
                                          // height: 30,
                                          // width: 0.5*width,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex:1,
                                                  child: Text(
                                                    "${index+1}",
                                                    style: TextStyle(
                                                        fontSize: 18.sp,
                                                        color: Provider.of<AppColors>(context).appColors.secondaryText
                                                    ),
                                                  )
                                              ),
                                              Expanded(
                                                  flex:5,
                                                  child: Text(
                                                    "${log['reason']}",
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 18.sp,
                                                        color: Provider.of<AppColors>(context).appColors.secondaryText
                                                    ),
                                                  )
                                              ),
                                              Expanded(
                                                  flex:2,
                                                  child: Text(
                                                    "${log['amount']}",
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 18.sp,
                                                        color: Provider.of<AppColors>(context).appColors.secondaryText
                                                    ),
                                                  )
                                              ),
                                              Expanded(
                                                  flex:2,
                                                  child: Text(
                                                    "${log['date']}",
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 18.sp,
                                                        color: Provider.of<AppColors>(context).appColors.secondaryText
                                                    ),
                                                  )
                                              ),

                                            ],
                                          ),
                                        );
                                      },

                                    ),
                                  ),
                                ],
                              )
                          ),

                        ],
                      ),
                    )


                  ],
                )),
          ),
        ),
      ],
    ),
  );

  Overlay.of(context).insert(_overlayEntry);
}



void hideOverlay() {
  _overlayEntry.remove();
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll('-', '');
    var buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i == 3 || i == 5) && i != text.length - 1) buffer.write('-');
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}