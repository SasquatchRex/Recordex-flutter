import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/main_provider.dart';
import 'topside.dart';

import 'Components/LineChart.dart';
import 'Components/BarChart.dart';
import 'Components/HalfCircleProgress.dart';
import 'Components/PercentageLine.dart';
import 'Components/ProfileDash.dart';

class RightSide extends StatefulWidget {
  final VoidCallback onToggleMenu;
  final VoidCallback toggleNotification;
  final bool fullMenu;
  final bool notification;

  const RightSide(
      {required this.onToggleMenu,
      required this.fullMenu,
      required this.notification,
      required this.toggleNotification});

  // const RightSide({super.key});

  @override
  State<RightSide> createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: widget.fullMenu
      //     ? 0.80 * MediaQuery.of(context).size.width
      //     : 0.89 * MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Provider.of<AppColors>(context).appColors.background,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Topside(
                    onToggleMenu: widget.onToggleMenu,
                    toggleNotification: widget.toggleNotification,
                  ),
                ),
                Expanded(
                  child: Container(
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
                              Welcome(),
                              ActiveUsers(),
                              TotalUsers(),
                              MonthlyRevenue(), // Will move to a new row if needed
                            ],
                          ),
                        ],
                      ),
                    )
                  ),
                ),

              ],
            ),
            if (widget.notification)
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
              )
          ],
        ),
      ),
      // child: Text("Hello"),
    );
  }
}


class Welcome extends StatelessWidget {
  const Welcome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: 600,
      height: 250,
      decoration: BoxDecoration(
        color: Provider.of<AppColors>(context).appColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 0, top: 15, bottom: 15),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        // alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Provider.of<AppColors>(context).appColors.ProfileDecoration,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Profile_Dash(),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome back,",
                            style: TextStyle(color: Provider.of<AppColors>(context).appColors.QuaternaryText),
                          ),
                          // SizedBox(height: 10,),
                          Text(
                            "Prithak Lamsal!",
                            style:
                            TextStyle(color: Provider.of<AppColors>(context).appColors.tertiaryText, fontSize: 28),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "\$65.4K",
                            style: TextStyle(
                                color: Provider.of<AppColors>(context).appColors.tertiaryText,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Today's Sale",
                            style: TextStyle(
                                color: Provider.of<AppColors>(context).appColors.tertiaryText,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          PercentageLine(
                            percentage: 64, // Fill 75% of the line
                            backgroundColor: Provider.of<AppColors>(context).appColors.QuaternaryText,
                            fillColor: Colors.green.shade400,
                            height: 6,
                            width: 100,
                          )
                        ],
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "74%",
                            style: TextStyle(
                                color: Provider.of<AppColors>(context).appColors.tertiaryText,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Growth Rate",
                            style: TextStyle(
                                color: Provider.of<AppColors>(context).appColors.tertiaryText,
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          PercentageLine(
                            percentage: 74, // Fill 75% of the line
                            backgroundColor: Provider.of<AppColors>(context).appColors.QuinaryText,
                            fillColor: Colors.red.shade400,
                            height: 6,
                            width: 100,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              Image.asset(
                "assets/photo.png",
                scale: 0.5,
              )
            ],
          ),
        ),
      ),
    );
  }
}



class ActiveUsers extends StatelessWidget {
  const ActiveUsers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        color: Provider.of<AppColors>(context).appColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              "42.5K",
              style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.tertiaryText,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Active Users",
              style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.tertiaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 30,
            ),
            HalfCircleProgress(
              percentage: 78, // Fill 75% of the half-circle
              backgroundColor: Provider.of<AppColors>(context).appColors.ActiveUsersBackground,
              progressColor: Provider.of<AppColors>(context).appColors.ActiveUsersProgress,
              strokeWidth: 12,
              size: 110,
            ),
            Container(
              width: 180,
              child: Text(
                "12.5K users increased from last month",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Provider.of<AppColors>(context).appColors.QuaternaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TotalUsers extends StatelessWidget {
  const TotalUsers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      Colors.lightGreenAccent,
      Colors.green,
    ];

    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        color: Provider.of<AppColors>(context).appColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              "42.5K",
              style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.tertiaryText,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Total Users",
              style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.tertiaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 100,
              width: 150,
              child: LineChartClass(gradientColors: gradientColors),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 180,
              child: Text(
                "12.5K users increased from last month",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Provider.of<AppColors>(context).appColors.QuaternaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }
}



class MonthlyRevenue extends StatelessWidget {
  const MonthlyRevenue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors = [
      Colors.lightGreenAccent,
      Colors.green,
    ];

    return Container(
      width: 420,
      height: 370,
      decoration: BoxDecoration(
        color: Provider.of<AppColors>(context).appColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              "Monthly Revenue",
              style: TextStyle(
                  color: Provider.of<AppColors>(context).appColors.tertiaryText,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 200,
              width: 350,
              child: BarChartWidget(),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 350,
              child: Text(
                "Average monthly sale",
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Provider.of<AppColors>(context).appColors.tertiaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "68.9%",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 34,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "3.45%",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_up,
                  color: Colors.green,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}








