import 'package:flutter/material.dart';
import 'package:netflix_clone/views/widgets/trending_post_widget.dart';

class NewAndHotScreen extends StatelessWidget {
  const NewAndHotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('New & Hot'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.cast),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                height: 27,
                width: 27,
                child: Image.asset('assets/images/profile.jpg'),
              ),
            ),
            SizedBox(width: 20),
          ],
          bottom: TabBar(
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            dividerColor: Colors.transparent,
            unselectedLabelColor: Colors.white70,
            labelColor: Colors.black,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(
                text: '  🍿 Coming Soon  ',
              ),
              Tab(text: '  🔥 Everyone\'s Watching  ')
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 25, bottom: 5),
                    child: Text(
                      '🍿 Coming Soon',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TrendingPostWidget(
                    title: 'Vettaiyan: A Warrior\'s Journey Starts October 10',
                    imageUrl: 'assets/images/vettaiyan.png',
                    date: '10',
                    month: 'October',
                    description:
                        'Vettaiyan is a highly anticipated Tamil action drama starring Rajinikanth. Directed by T.J. Gnanavel, the film promises a powerful story featuring a stellar cast including Amitabh Bachchan, Rana Daggubati, Fahadh Faasil, and Manju Warrier. With its gripping narrative and high-octane action sequences, Vettaiyan is set to be a cinematic spectacle.',
                  ),
                  TrendingPostWidget(
                    title: 'A new chapter in the Captain America legacy.',
                    imageUrl: 'assets/images/captain_america.jpg',
                    date: '24',
                    month: 'February',
                    description:
                        'Sam Wilson soars into his new role as Captain America in this action-packed adventure. Faced with a global crisis and a newly elected President Thaddeus Ross, Sam must navigate a complex world while protecting what he believes in. Get ready for thrilling action, unexpected twists, and the continuation of the Captain America legacy.',
                  ),
                  TrendingPostWidget(
                    title:
                        'Lucky Baskhar will hit theaters on October 31, 2024.',
                    imageUrl: 'assets/images/lucky_baskhar.png',
                    date: '31',
                    month: 'October',
                    description:
                        'Dulquer Salmaan\'s highly anticipated Telugu film, Lucky Baskhar, is a suspense drama directed by Venky Atluri. The film features Meenakshi Chaudhary as the female lead. Initially slated for a September 7, 2024 release, the makers have now announced a new release date.',
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 25, bottom: 5),
                    child: Text(
                      '🔥 Everyone\'s Watching',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TrendingPostWidget(
                    title: 'Oppenheimer: The mind behind the bomb.',
                    imageUrl: 'assets/images/oppenheimer.jpg',
                    date: '20',
                    month: 'August',
                    description:
                        '"Oppenheimer" is a compelling historical drama by Christopher Nolan that explores the life of J. Robert Oppenheimer, the father of the atomic bomb. The film dives into the ethical and personal challenges he faced while leading the Manhattan Project, offering a powerful look at a pivotal moment in history.',
                  ),
                  TrendingPostWidget(
                    title:
                        'Deeper. Darker. Deadlier. 🦈 Get ready to dive into terror!',
                    imageUrl: 'assets/images/meg2.jpg',
                    date: '18',
                    month: 'August',
                    description:
                        'Jonas Taylor and his intrepid research team dive into the uncharted depths of the ocean, only to find themselves in a high-stakes battle for survival against colossal, prehistoric megalodons. With their mission compromised by ruthless mining operations, they\'ll need to outsmart and outswim these apex predators to make it back alive.',
                  ),
                  TrendingPostWidget(
                    title: ' A love story for the ages',
                    imageUrl: 'assets/images/titanic.jpg',
                    date: '17',
                    month: 'August',
                    description:
                        'Immerse yourself in a heart-wrenching love story set against the backdrop of tragedy. As social barriers collide with the icy waters of the Atlantic, Titanic explores themes of class, love, and survival.',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
