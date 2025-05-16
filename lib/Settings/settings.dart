import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

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
                                        PdfUploadContainer(),
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
            if (Provider.of<General>(context).notification)
              Positioned(
                right: 0,
                top: 80,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  width: 300,
                  height: 400,
                  decoration: BoxDecoration(
                    color: Provider.of<AppColors>(context).appColors.primary,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Column(
                      children: [
                        Text(
                          "Notifications",
                          style: TextStyle(
                              color: Provider.of<AppColors>(context).appColors.tertiaryText,
                              fontSize: 20
                          ),

                        ),
                        SizedBox(height: 10,),
                        for(int i=1;i<=5;i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: GestureDetector(
                              onTap: () {
                                print("Option 1");
                              },
                              child: Container(
                                  color: Provider.of<AppColors>(context).appColors.secondary,
                                  width: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Heading 1",
                                          style: TextStyle(
                                            color: Provider.of<AppColors>(context).appColors.NotificationHeader,
                                          ),
                                        ),
                                        SizedBox(height: 2,),
                                        Text(
                                          "This is the description for heading 1",
                                          style: TextStyle(
                                              color: Provider.of<AppColors>(context).appColors.NotificationBody,
                                              fontSize: 12
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),



          ],
        ),
      ),
      // child: Text("Hello"),
    );;
  }
}



class PdfUploadContainer extends StatefulWidget {
  const PdfUploadContainer({super.key});

  @override
  State<PdfUploadContainer> createState() => _PdfUploadContainerState();
}

class _PdfUploadContainerState extends State<PdfUploadContainer> {
  String? fileName;

  Future<void> pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.grey.shade400, width: 1.5),
        borderRadius: BorderRadius.circular(12),
        color: Provider.of<AppColors>(context).appColors.secondary,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.picture_as_pdf, size: 48, color: Colors.redAccent),
          const SizedBox(height: 12),
          Text(
            fileName ?? "No file selected",
            style: TextStyle(
              fontSize: 16,
              color: fileName == null ? Colors.grey : Provider.of<AppColors>(context).appColors.secondaryText,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: pickPdf,
            icon:  Icon(Icons.upload_file,
            color: Provider.of<AppColors>(context).appColors.primaryText,
            ),
            label:  Text(
                "Upload PDF Bill",
              style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.secondaryText
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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

