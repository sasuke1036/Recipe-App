import 'package:flutter/material.dart';
import 'package:receipe_app/screens/ingredient_screen.dart';

class RecipeResultScreen extends StatelessWidget {
  final String recipe;
  final String cuisine;

  RecipeResultScreen({Key? key, required this.recipe, required this.cuisine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recipe Result',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: const Color.fromARGB(185, 66, 235, 229),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/background3.png'), // Your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color:
                Colors.black.withOpacity(0.5), // Adjust the opacity as needed
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              // Determine if content exceeds screen height
              bool isContentExceedingHeight =
                  constraints.maxHeight < MediaQuery.of(context).size.height;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    children: [
                      Text(
                        recipe,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      if (!isContentExceedingHeight)
                        const SizedBox(
                            height: 100), // Add space for the scroll indicator
                      if (!isContentExceedingHeight)
                        const Column(
                          children: [
                            Icon(Icons.keyboard_arrow_down,
                                color: Colors.white),
                            Text(
                              'Scroll down for more',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      const SizedBox(height: 20), // Adjust as needed
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const IngredientScreen()),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: const Text('Start Fresh!!'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
