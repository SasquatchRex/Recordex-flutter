import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:recordex/Create%20Expense/expense_rightside.dart';

import '../../Provider/main_provider.dart';
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
                  padding: const EdgeInsets.only(bottom: 20),
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

void showOverlay(BuildContext context) {
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
                width: 0.4 * width,
                height: 0.75 * height,
                padding: EdgeInsets.all(20),
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
                        "Are you sure you want to update Invoice Bill?",
                        style: TextStyle(
                          color: Provider.of<AppColors>(context).appColors.primaryText,
                          fontSize: 28,
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
                                fontSize: 22,
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
              fontSize: 16,
              color: Provider.of<SettingsProvider>(context).fileName == null ? Colors.grey : Provider.of<AppColors>(context).appColors.secondaryText,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 14),
          const Icon(Icons.photo, size: 48, color: Colors.redAccent),
          const SizedBox(height: 12),
          Text(
            Provider.of<SettingsProvider>(context).fileName ?? "No file selected",
            style: TextStyle(
              fontSize: 16,
              color: Provider.of<SettingsProvider>(context).fileName == null ? Colors.grey : Provider.of<AppColors>(context).appColors.secondaryText,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () async{
              await onpressed();
              showOverlay(context);
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
        ],
      ),
    );
  }
}

