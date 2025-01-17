import 'package:flutter/material.dart';

class MagicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0, // Adjust this value if needed
            left: 0,
            right: 0,
            child: SizedBox(
              height: 300, // Set the height of the image
              width: MediaQuery.of(context)
                  .size
                  .width, // Set the width of the image
              child: Image.asset(
                'assets/images/taco_salad.jpg', // Replace with your asset path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content with overlapping container
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.4,
                pinned: true,
                stretch: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.favorite_border, color: Colors.black),
                    onPressed: () {
                      // Add favorite functionality here
                    },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: Colors.transparent, // Keeps AppBar transparent
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // Overlapping container
                    Container(
                      transform:
                          Matrix4.translationValues(0, -50, 0), // Move upward
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Healthy Taco Salad",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.access_time,
                                  size: 18, color: Colors.grey),
                              SizedBox(width: 5),
                              Text(
                                "15 Min",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            "This Healthy Taco Salad is the universal delight of taco night",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          SizedBox(height: 5),
                          GestureDetector(
                            onTap: () {
                              // Handle View More action
                            },
                            child: Text(
                              "View More",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildNutritionInfo(
                                      "65g carbs", Icons.restaurant),
                                  _buildNutritionInfo(
                                      "27g proteins", Icons.fitness_center),
                                ],
                              ),
                              SizedBox(height: 10), // Spacing between the rows
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildNutritionInfo(
                                      "120 Kcal", Icons.local_fire_department),
                                  _buildNutritionInfo(
                                      "91g fats", Icons.fastfood),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionInfo(String text, IconData icon) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.start, // Align the icon and text to the left
      children: [
        Icon(icon, color: Colors.black), // Icon on the left
        const SizedBox(width: 4), // Space between the icon and text
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Sofia Pro',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
