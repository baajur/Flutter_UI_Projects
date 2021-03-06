import 'package:flutter/material.dart';
import 'package:music_app/components/cardPlayList.dart';
import 'package:music_app/components/cardSongs.dart';
import 'package:music_app/model/PlayListModel.dart';
import 'package:music_app/model/SongModel.dart';
import 'package:music_app/screens/Player.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController = ScrollController();
  double valueSlide = 130;
  String songName = "";
  String artist = "";
  String image = "";
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    songName = listSongs[0].song;
    artist = listSongs[0].artist;
    image = listSongs[0].urlImage;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
  print("songHome: $songName");
    return Scaffold(
      backgroundColor: Color(0xff1E1F31),
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _appBar(),
                    _mostPopular(),
                    _listagemPlayList(),
                    _newReleases(),
                  ],
                )),
            Positioned(bottom: 0, left: 0, right: 0, child: _bottomPlayer())
          ],
        ),
      ),
    );
  }

  Widget _newReleases() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 15, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "new releases",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.05,//20,
                    ),
              ),
              SizedBox(height: 3),
              Text(
                "3456 songs",
                style: TextStyle(color: Colors.white30, fontSize: width * 0.03),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: SizedBox(
            height: 90,
            child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: listSongs.length,//listaPlaylist.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        songName = listSongs[index].song;   
                        artist = listSongs[index].artist;  
                        image =  listSongs[index].urlImage;                   
                      });
                    },
                      child: CardSongs(
                        song: listSongs[index],
                        cor: songName == listSongs[index].song ? Colors.red : Color(0xff292A3E),
                      ),
                  );
                  
                }),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              children: <Widget>[
                Text(songName,style: TextStyle(color: Colors.white,fontSize: width * 0.04,),),
                Text(artist,style: TextStyle(color: Colors.white38,fontSize: width * 0.025,),)
              ],
            ),
          ),
        )

        
      ],
    );
  }

  Widget _listagemPlayList() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.37,//270,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listaPlaylist.length,
          itemBuilder: (context, index) {
            return CardPlayList(
              plm: listaPlaylist[index],
            );
          }),
    );
  }

  Widget _mostPopular() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 15, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "most",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.09,//35,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "popular",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.09,//35,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "960 playlists",
                style: TextStyle(color: Colors.white30, fontSize: 11),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _appBar() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.more_vert,
            color: Colors.white70,
          ),
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Hello, Yana",
                    style: TextStyle(
                        letterSpacing: 1, 
                        color: Colors.white, 
                        fontSize: width * 0.04,//13,
                      ),
                  ),
                  Text(
                    "New york",
                    style: TextStyle(
                      color: Colors.white24, 
                      fontSize: width * 0.025,//8,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 5),
                child: Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _bottomPlayer() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Player(
            songName: songName,
            playListName: artist,
            urlPhoto: image,
          )
          ));
      },
          child: Container(
        padding: EdgeInsets.only(left: width * 0.03, right: width * 0.03, top: width * 0.045, bottom: width * 0.07),
        decoration: BoxDecoration(
            color: Color(0xff292A3E),
            borderRadius: BorderRadius.only(topRight: Radius.circular(25))),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ClipOval(
                      child: Image.asset(
                        image =="" ?"assets/foto_1.jpg" : image,
                        fit: BoxFit.cover,
                        height: width * 0.12,
                        width: width * 0.12,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            songName == "" ?"let you" : songName,                            
                            style: TextStyle(color: Colors.white, fontSize: width * 0.04),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            artist == "" ? "idk" : artist,
                            style: TextStyle(color: Colors.white24, fontSize: width * 0.03),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.pause,
                      size: 25,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Icon(
                        Icons.fast_forward,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Text(
                  "01:30",
                  style: TextStyle(color: Colors.white38, fontSize: 8),
                ),
                Expanded(
                  child: Container(
                    height: 10,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 0.0)),
                      child: Slider(
                          activeColor: Colors.white,
                          inactiveColor: Color(0xff1E1F31),
                          min: 0,
                          max: 245,
                          value: valueSlide,
                          onChanged: (value) {
                            setState(() {
                              valueSlide = value;
                            });
                          }),
                    ),
                  ),
                ),
                Text(
                  "02:45",
                  style: TextStyle(color: Colors.white, fontSize: 8),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
