import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class SavedList extends StatefulWidget {     //stless 에서 insert ~~~~~~ 선택 생성


SavedList({@required this.saved});

final Set<WordPair> saved;    //saved에 주소? reference 입력

  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(      //container로 사용 시 뒤로 못 가서 검은 화면만 나옴
      appBar: AppBar(
        title: Text("Saved"),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList(){
    return ListView.builder(itemCount: widget.saved.length*2, itemBuilder: (context, index){       //saved.length*2 
      if(index.isOdd)
        return Divider();     //1, 3, 5, 7...

      var realIndex = index ~/ 2;       // ~/ = 몫

      return _buildRow(widget.saved.toList()[realIndex]);    //0, 2, 4, 6, 8...
    });
  }

  Widget _buildRow(WordPair pair){
    return ListTile(
      title: Text(pair.asPascalCase, 
      textScaleFactor: 1.5,
      ),
      onTap: (){
        setState(() {
        widget.saved.remove(pair); 
        });
      },
    );
  }
}