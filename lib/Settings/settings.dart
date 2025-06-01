import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // ← MUST BE ADDED
import '../../Processing/Provider/main_provider.dart';
import '../topside.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return  AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.linear,
      // width: widget.fullMenu
      //     ? 0.80 * MediaQuery.of(context).size.width
      //     : 0.89 * MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Provider.of<AppColors>(context).appColors.background,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0,bottom:20,right: 0,left: 20),
        // padding: const EdgeInsets.only(top: 20,bottom: 20),
        child: Stack(
          children: [
            Column(

              children: [
                Padding(
                  padding:  EdgeInsets.only(bottom: 20.h),
                  child: Topside(),
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            // width: widget.fullMenu? 0.6 * MediaQuery.of(context).size.width : 0.69* MediaQuery.of(context).size.width,
                            // color: Colors.red,
                              alignment: Alignment.topLeft,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    Wrap(
                                      spacing: 20, // Horizontal spacing
                                      runSpacing: 20, // Vertical spacing
                                      alignment: WrapAlignment.start,
                                      children: [
                                        PngUploadContainer(
                                          onpressed: () => Provider.of<SettingsProvider>(context,listen: false).pickPdf(),
                                          name: "Tax Invoice Bill",

                                        ),


                                       Container(
                                         width: 250.w,
                            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.grey.shade400, width: 1.5),
                              borderRadius: BorderRadius.circular(12),
                              color: Provider.of<AppColors>(context).appColors.primary,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Starting Invoice Number",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Provider.of<SettingsProvider>(context).fileName == null ? Colors.grey : Provider.of<AppColors>(context).appColors.secondaryText,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 14.h),
                                Container(
                                  width: 150,
                                    child: TextField(
                                      cursorColor: Provider.of<AppColors>(context).appColors.MenuActive,
                                      style: TextStyle(color: Provider.of<AppColors>(context).appColors.primaryText),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(5),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                          isDense: true,
                                          filled: true,
                                          fillColor: Provider.of<AppColors>(context).appColors.primary,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(color: Provider.of<AppColors>(context).appColors.primaryText), // Change focus border color here
                                          ),
                                          // Change focus border color here
                                          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                                          labelText: "YY-XXX",
                                          contentPadding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 20),
                                          alignLabelWithHint: true,
                                          labelStyle: TextStyle(
                                              color: Provider.of<AppColors>(context).appColors.secondaryText,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w400
                                          )
                                      ),
                                    )
                                ),
                                SizedBox(height: 16.h),
                                ElevatedButton.icon(
                                  onPressed: () async{
                                    final General_Provider = Provider.of<General>(context, listen: false);
                                    final InvoicePayment_Provider = Provider.of<InvoicePaymentShop>(context, listen: false);
                                    bool result = await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Invoice Created!'),
                                        content: Text('Do you want to print this Invoice?'),
                                        actions: [
                                          TextButton(onPressed: () => Navigator.pop(context, false), child: Text('No, I will do it later')),
                                          TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Yes')),
                                        ],
                                      ),
                                    );
                                    if(result && InvoicePayment_Provider.InvoiceNumber != null){
                                      General_Provider.printNetworkImage(InvoicePayment_Provider.InvoiceNumber!);
                                    }

                                  },
                                  icon:  Icon(Icons.save,
                                    color: Provider.of<AppColors>(context).appColors.primaryText,
                                  ),
                                  label:  Text(
                                    "Save",
                                    style: TextStyle(
                                        color: Provider.of<AppColors>(context).appColors.secondaryText
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: Provider.of<AppColors>(context).appColors.secondary
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  "Note: Enter 2 starting digits and 3 zeros",
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Provider.of<AppColors>(context).appColors.secondaryText
                                  ),
                                )
                              ],
                            ),
                          ),


                                        // Welcome(),
                                        // Trial(),
                                        // MonthlyRevenue(),
                                        // ActiveUsers(),
                                        // TotalUsers(),
                                        // ActiveUsers(),
                                        // TotalUsers(),

                                      ],
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ),
                        // EmployeeDash()
                      ],
                    ),
                  ),
                ),

              ],
            ),




          ],
        ),
      ),
      // child: Text("Hello"),
    );
  }

}

late OverlayEntry _overlayEntry;

void showOverlay(BuildContext context,Widget Function(double height) bodyBuilder) {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  final body = bodyBuilder(height);


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
                width: 0.4 * width,
                height: 0.75 * height,
                padding: EdgeInsets.all(20.r),
                color: Provider.of<AppColors>(context).appColors.primary,
                child: body,
          ),
        ),
        )
      ],
    ),
  );

  Overlay.of(context).insert(_overlayEntry);
}

void hideOverlay() {
  _overlayEntry.remove();
}

class FileUploadOverlay extends StatelessWidget {
  const FileUploadOverlay({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            "Are you sure you want to update Invoice Bill?",
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
              await Provider.of<SettingsProvider>(context,listen: false).sendRequest();
              if(Provider.of<SettingsProvider>(context,listen: false).responseCode == 200){
                hideOverlay();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Successfully Updated',
                      style: TextStyle(
                        color: Provider.of<AppColors>(context,listen: false).appColors.primaryText,
                      ),
                    ),
                    duration: Duration(seconds: 4),
                    backgroundColor: Provider.of<AppColors>(context,listen: false).appColors.success,

                  ),
                );
              }
              else{
                hideOverlay();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Update Failed. Contact Admin',
                      style: TextStyle(
                        color: Provider.of<AppColors>(context,listen: false).appColors.primaryText,
                      ),
                    ),
                    duration: Duration(seconds: 4),
                    backgroundColor: Provider.of<AppColors>(context,listen: false).appColors.fail,

                  ),
                );
              }
            },
              child: Text(
                  "Yes",
                style: TextStyle(
                    color: Provider.of<AppColors>(context).appColors.primaryText,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.center,
              ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),

            ),
          )
        ),
        if(Provider.of<SettingsProvider>(context,listen: false).bytes != null)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top:80.0,bottom: 50),
              child: SizedBox(
                height: 0.69*height,
                child: InteractiveViewer(
                  panEnabled: true, // Allow panning
                  scaleEnabled: true, // Allow zooming
                  minScale: 1.0,
                  maxScale: 4.0,

                  child: Image.memory(
                    Provider.of<SettingsProvider>(context,listen: false).bytes!,
                    height: 0.69 * height,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}






class PngUploadContainer extends StatelessWidget {
  final Future<void> Function() onpressed;


  final String name;
  const PngUploadContainer({
    required this.onpressed,
    required this.name,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.grey.shade400, width: 1.5),
        borderRadius: BorderRadius.circular(12),
        color: Provider.of<AppColors>(context).appColors.primary,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${name}",
            style: TextStyle(
              fontSize: 16.sp,
              color: Provider.of<SettingsProvider>(context).fileName == null ? Colors.grey : Provider.of<AppColors>(context).appColors.secondaryText,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
           SizedBox(height: 14.h),
          const Icon(Icons.photo, size: 48, color: Colors.redAccent),
           SizedBox(height: 12.h),
          Text(
            Provider.of<SettingsProvider>(context).fileName ?? "No file selected",
            style: TextStyle(
              fontSize: 16.sp,
              color: Provider.of<SettingsProvider>(context).fileName == null ? Colors.grey : Provider.of<AppColors>(context).appColors.secondaryText,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
           SizedBox(height: 16.h),
          ElevatedButton.icon(
            onPressed: () async{
              await onpressed();
              showOverlay(context,(height) => FileUploadOverlay(height: height));
              },
            icon:  Icon(Icons.upload_file,
            color: Provider.of<AppColors>(context).appColors.primaryText,
            ),
            label:  Text(
                "Upload PNG Bill",
              style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.secondaryText
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Provider.of<AppColors>(context).appColors.secondary
            ),
          ),
           SizedBox(height: 16.h),
          GestureDetector(
            onTap: ()=> Provider.of<SettingsProvider>(context,listen: false).openLink("https://pdf2png.com/"),
            child: Text(
                "Converter here!",
                style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.secondaryText,
                  fontSize: 16.sp
                ),
            ),
          )
        ],
      ),
    );
  }
}

