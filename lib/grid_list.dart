import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradListDemo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new  GradListDemoState();
  }
}

typedef BannerTapCallback = void Function(Photo photo);
const double _kMinFlingVelocity = 800.0;

class GradListDemoState extends State<GradListDemo> {

  List<Photo> photos = <Photo>[
    Photo(
      assetName: 'https://avatar.csdn.net/D/4/0/3_julystroy.jpg',
      title: 'Chennai',
      caption: '3时01分',
      isvisable: 0.0
    ),
    Photo(
      assetName: 'https://avatar.csdn.net/D/4/0/3_julystroy2.jpg',
      title: 'Tanjore',
      caption: '24时60分',
       isvisable:0.0
    ),
    Photo(
      assetName: 'https://avatar.csdn.net/D/4/0/3_julystroy3.jpg',
      title: 'Tanjore',
      caption: 'Market',
        isvisable:0.0
    ),
    Photo(
      assetName: 'https://avatar.csdn.net/D/4/0/3_julystroy4.jpg',
      title: 'Tanjore',
      caption: '11点15分',
        isvisable:0.0
    ),
    Photo(
      assetName: 'https://avatar.csdn.net/D/4/0/3_julystroy5.jpg',
      title: 'Tanjore',
      caption: '9时21分',
        isvisable:0.0
    ),
    Photo(
      assetName: 'https://avatar.csdn.net/D/4/0/3_julystroy6.jpg',
      title: 'Pondicherry',
      caption: '00时00分',
        isvisable:0.0
    ),
    Photo(
      assetName: 'https://avatar.csdn.net/D/4/0/3_julystroy7.jpg',
      title: 'Chennai',
      caption: 'Scooters',
        isvisable:0.0
    ),
    Photo(
      assetName: 'https://avatar.csdn.net/D/4/0/3_julystroy8.jpg',
      title: 'Chettinad',
      caption: '8时30分',
        isvisable:0.0
    ),
    Photo(
      assetName: 'https://avatar.csdn.net/D/4/0/3_julystroy9.jpg',
      title: 'Chettinad',
      caption: '22时11分',
        isvisable:0.0
    ),
    Photo(
      assetName: 'https://avatar.csdn.net/D/4/0/3_julystroy10.jpg',
      title: 'Tanjore',
      caption: 'Market',
        isvisable:0.0
    ),
    Photo(
      assetName: 'https://avatar.csdn.net/D/4/0/3_julystroy11.jpg',
      title: 'Pondicherry',
      caption: 'Beach',
        isvisable:0.0
    ),
    Photo(
      assetName: 'https://avatar.csdn.net/D/4/0/3_julystroy12.jpg',
      title: 'Pondicherry',
      caption: 'Fisherman',
        isvisable:0.0
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return new Scaffold(
      backgroundColor: Color(0xfff3f4f5),
      appBar: AppBar(
        title: Text('grid'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SafeArea(
              top: false,
              bottom: false,
              child: GridView.count(
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 4.0,
                padding: const EdgeInsets.all(4.0),
                childAspectRatio: (orientation == Orientation.portrait) ? 1.0 : 1.3,
                children: photos.map<Widget>((Photo photo) {
                  return GridDemoItem(
                    photo: photo,
                    onBannerTap: (Photo photo) {
                      setState(() {
                        photo.title = 'hahahah';
                        print(photo.isvisable);
                        photo.isvisable = (photo.isvisable == 0.0) ? 0.3 : 0.0;
                        print(photo.isvisable);
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Photo {
  Photo({
    this.assetName,
    this.title,
    this.caption,
    this.isvisable
  });

  final String assetName;

   String title;
   String caption;
   double isvisable ;


  String get tag => assetName; // Assuming that all asset names are unique.

  bool get isValid => assetName != null && title != null && caption != null ;
}

class GridDemoItem extends StatelessWidget {
  GridDemoItem({
    Key key,
    @required this.photo,
    @required this.onBannerTap,
  }) : assert(photo != null && photo.isValid),
        assert(onBannerTap != null),
        super(key: key);

  final Photo photo;

  final BannerTapCallback onBannerTap; // User taps on the photo's header or footer.

  void showPhoto(BuildContext context) {
    Navigator.push(context, MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(photo.title),
            ),
            body: SizedBox.expand(
              child: Hero(
                tag: photo.tag,
                child: GridPhotoViewer(photo: photo),
              ),
            ),
          );
        }
    ));
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = GestureDetector(
      onTap: () { showPhoto(context); },
      child: Hero(
        key: Key(photo.assetName),
        tag: photo.tag,
        child: new CircleAvatar(
          backgroundImage: NetworkImage("https://avatar.csdn.net/D/4/0/3_julystroy.jpg"),
        ),
      ),
    );

        return new GestureDetector(
          onTap: (){
           onBannerTap(photo);
          },
          child: new Card(
                color: Colors.white,
                elevation: 3.0,
                child:new Stack(
                 children: <Widget>[
                   new Padding(
                   padding: EdgeInsets.fromLTRB(20, 16, 20, 14),
                   child:new Column(
                    children: <Widget>[
                      image,
                      new Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                      new Text(photo.title,style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w700) ),
                      new Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                      new Text(photo.caption,style: new TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.blue)),
                      new Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                      new Text("what is your problem ? fuck fuck fuck",style: new TextStyle(fontSize: 12,color: Colors.grey),textAlign: TextAlign.center,),
                    ],
                   ),
                  ),
                  new Center(
                    child: new ClipRect(
                      child: new BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Opacity(
                          opacity:  photo.isvisable == 0.0 ? 0.0 :0.3,
                          child: new Container(
                            decoration: new BoxDecoration(
//                  color: Colors.grey.shade200.withOpacity(0.5),
                              color: Colors.grey.shade200,
                            ),

                          ),
                        ),
                      ),
                    ),
                  ),
                   Offstage(
                     offstage: photo.isvisable == 0.0?true:false,
                     child: new Column(
                         mainAxisAlignment: MainAxisAlignment.end,//从底部显示
                         mainAxisSize: MainAxisSize.max,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         verticalDirection: VerticalDirection.down,//从下往上排列
                         // textDirection:,
                         textBaseline: TextBaseline.alphabetic,
                         children: <Widget>[

                           new GestureDetector(
                               onTap: (){onBannerTap(photo);},
                               child: new Container(
                                 height: 36.0,
                                 alignment: new Alignment(0.0, 0.0),
                                 color: Colors.red,
                                 margin: EdgeInsets.fromLTRB(1, 0, 1, 0),
                                 child:new Text("备注",style: TextStyle(color: Colors.white,fontSize: 12),textAlign:TextAlign.center ),
                               )
                           ),
                           new GestureDetector(
                               onTap: (){onBannerTap(photo);},
                               child: new Container(
                                 height: 36.0,
                                 alignment: new Alignment(0.0, 0.0),
                                 color: Colors.blue,
                                 margin: EdgeInsets.fromLTRB(1, 0, 1, 0),
                                 child:new Text("删除",style: TextStyle(color: Colors.white,fontSize: 12),textAlign:TextAlign.center ),
                               )
                           ),
                           new GestureDetector(
                               onTap: (){onBannerTap(photo);},
                               child: new Container(
                                 height: 36.0,
                                 alignment: new Alignment(0.0, 0.0),
                                 color:Color.fromARGB(179,178,178,1),
                                 margin: EdgeInsets.fromLTRB(1, 0, 1, 0),
                                 child:new Text("取消",style: TextStyle(color: Colors.white,fontSize: 12),textAlign:TextAlign.center ),
                               )
                           )
                         ],
                       )

                   ),
                ],
              ),




              ),
//              new Center(
//                child: new ClipRect(
//                  child: new BackdropFilter(
//                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
//                    child: Opacity(
//                      opacity: 0.5,
//                      child: new Container(
//                        decoration: new BoxDecoration(
////                  color: Colors.grey.shade200.withOpacity(0.5),
//                          color: Colors.grey.shade200,
//                        ),
//
//                      ),
//                    ),
//                  ),
//                ),
//              ),

        );
    }

}

class GridPhotoViewer extends StatefulWidget {
  const GridPhotoViewer({ Key key, this.photo }) : super(key: key);

  final Photo photo;

  @override
  _GridPhotoViewerState createState() => _GridPhotoViewerState();
}

class _GridPhotoViewerState extends State<GridPhotoViewer> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _flingAnimation;
  Offset _offset = Offset.zero;
  double _scale = 1.0;
  Offset _normalizedOffset;
  double _previousScale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)
      ..addListener(_handleFlingAnimation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // The maximum offset value is 0,0. If the size of this renderer's box is w,h
  // then the minimum offset value is w - _scale * w, h - _scale * h.
  Offset _clampOffset(Offset offset) {
    final Size size = context.size;
    final Offset minOffset = Offset(size.width, size.height) * (1.0 - _scale);
    return Offset(offset.dx.clamp(minOffset.dx, 0.0), offset.dy.clamp(minOffset.dy, 0.0));
  }

  void _handleFlingAnimation() {
    setState(() {
      _offset = _flingAnimation.value;
    });
  }

  void _handleOnScaleStart(ScaleStartDetails details) {
    setState(() {
      _previousScale = _scale;
      _normalizedOffset = (details.focalPoint - _offset) / _scale;
      // The fling animation stops if an input gesture starts.
      _controller.stop();
    });
  }

  void _handleOnScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = (_previousScale * details.scale).clamp(1.0, 4.0);
      // Ensure that image location under the focal point stays in the same place despite scaling.
      _offset = _clampOffset(details.focalPoint - _normalizedOffset * _scale);
    });
  }

  void _handleOnScaleEnd(ScaleEndDetails details) {
    final double magnitude = details.velocity.pixelsPerSecond.distance;
    if (magnitude < _kMinFlingVelocity)
      return;
    final Offset direction = details.velocity.pixelsPerSecond / magnitude;
    final double distance = (Offset.zero & context.size).shortestSide;
    _flingAnimation = _controller.drive(Tween<Offset>(
      begin: _offset,
      end: _clampOffset(_offset + direction * distance),
    ));
    _controller
      ..value = 0.0
      ..fling(velocity: magnitude / 1000.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: _handleOnScaleStart,
      onScaleUpdate: _handleOnScaleUpdate,
      onScaleEnd: _handleOnScaleEnd,
      child: ClipRect(
        child: Transform(
          transform: Matrix4.identity()
            ..translate(_offset.dx, _offset.dy)
            ..scale(_scale),
          child: Image.network(
            widget.photo.assetName,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}