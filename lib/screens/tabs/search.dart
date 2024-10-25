import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtén el color primario del tema actual
    return Scaffold(
      appBar: AppBar(
        title: const Text('Búsqueda'),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              clipBehavior: Clip.none,
              shape: const StadiumBorder(),
              scrolledUnderElevation: 0.0,
              titleSpacing: 0.0,
              backgroundColor: Colors.transparent,
              floating: true,
              title: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 16.0), // Margen horizontal
                child: SearchAnchor.bar(
                  suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    return List<Widget>.generate(
                      5,
                      (int index) {
                        return ListTile(
                          titleAlignment: ListTileTitleAlignment.center,
                          title: Text('Sugerencia $index'),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: 100.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 100.0,
                        child: Card(
                          child: Center(child: Text('Card $index')),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
