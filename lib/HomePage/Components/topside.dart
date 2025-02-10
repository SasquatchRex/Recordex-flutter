import 'package:flutter/material.dart';


// bool fullMenu = true;


class Topside extends StatefulWidget {
  final VoidCallback onToggleMenu;
  final VoidCallback toggleNotification;

  const Topside({required this.onToggleMenu,required this.toggleNotification});


  // const Topside({super.key});

  @override
  State<Topside> createState() => _TopsideState();
}

class _TopsideState extends State<Topside> {
  // final GlobalKey<_LeftSideState> leftSideKey = GlobalKey<_LeftSideState>();
  TextEditingController _searchController = TextEditingController();



  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.035),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: widget.onToggleMenu,
                        // print(fullMenu);

                      child: Icon(
                        Icons.menu,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(width: 25,),
                    Container(
                      width:  width*0.6,
                      // height: 10,
                      child: SearchBox(
                        controller: _searchController,
                        hintText: "Search",
                        onChanged: (query) {
                          // Handle search query changes
                          print("Search query: $query");
                        },
                        onClear: () {
                          setState(() {
                            _searchController.clear();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){},
                      child: Icon(
                          Icons.settings,
                        color: Colors.white70,

                      ),
                    ),

                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap: widget.toggleNotification,
                        child: Notification()
                    ),

                    SizedBox(width: 20,),
                    Profile(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Notification extends StatelessWidget {
  const Notification({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
                clipBehavior: Clip.none, // Allows the badge to extend outside the Stack
                children: [
                  Icon(
                    Icons.notifications_active,
                    color: Colors.white70,
                    size: 25, // Adjust size as needed
                  ),
                  Positioned(
                    top: -5, // Position above the icon
                    right: -5, // Position to the right of the icon
                    child: Container(
                      width: 20,
                      height: 20,
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle, // Ensures a circular badge
                      ),
                      child: Text(
                        "4",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              );
  }
}

class Profile extends StatelessWidget {
  const Profile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
              "assets/profile.png",
              scale: 1.8,
              fit: BoxFit.cover,
          )
      ),
    );
  }
}



class SearchBox extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChanged;
  final Function()? onClear;

  const SearchBox({
    Key? key,
    required this.controller,
    this.hintText = "Search...",
    this.onChanged,
    this.onClear,
  }) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.symmetric(horizontal: 12),

      decoration: BoxDecoration(
        // color: Colors.grey[200],
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.white38),
          SizedBox(width: 8),
          Expanded(// Ensures the TextField takes up the remaining space

            child: TextField(
              controller: widget.controller,
              cursorColor: Colors.white70,
              style: TextStyle(
                color: Colors.white70
              ),
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                hintText: widget.hintText,

                hintStyle: TextStyle(
                  color: Colors.white54,

                ),

                border: InputBorder.none,


              ),
            ),
          ),
          if (widget.controller.text.isNotEmpty)
            GestureDetector(
              onTap: widget.onClear,
              child: Icon(Icons.clear, color: Colors.white),
            ),
        ],
      ),
    );
  }
}


