import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'saved.dart';

class RandomList extends StatefulWidget{      //상태가 변하는 위젯
  @override

 // State<StatefulWidget> createState() => _RandomListState();
  State<StatefulWidget> createState() {

    return _RandomListState();
  }
}

class _RandomListState extends State<RandomList>{   //상태가 바뀔 떄 마다 빌드가 될 수 있도록
  final List<WordPair> _suggestions = <WordPair>[];   //리스트 지정 | 영어 단어를 List 형태로 WordPair 오브젝트로 지정
  final Set<WordPair> _saved = Set<WordPair>();       //동일한 값의 오브젝트가 set 안에 들어갈 수 없음



  @override
  Widget build(BuildContext context) {

    final randomWord = WordPair.random();   //상수 - 랜덤 단어를 계속 가져옴


    return Scaffold(
        appBar: AppBar(
          title : Text("naming app"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.list),
              onPressed: (){
                Navigator.of(context).push(     //네비게이터라는 오브젝트를 사용(콘텍스트를 가져옴)
                  MaterialPageRoute(builder: (context) => SavedList(saved: _saved))      //페이지 루트를 사용해서 세이브드로 이동
                );
              },
            )
          ],
        ),

        //IndexedWidgetBuilder - 하나의 칸을 생성 하는?, context - 현재 상황?상황 판단?(한국사람은 한국말, 영국사람은 영국말), index - 0,1,2....
        body: _buildList(),       //위젯 리턴 
      );
  }

  Widget _buildList(){      //위젯
    return ListView.builder(itemBuilder: (context, index){   //오브젝트를 생성하여 가져오는 ,itemBuilder 반드시 필요
           //0, 2, 4, 6, 8 == real item
           //1, 3, 5, 7, 9 == dividers(선)


           if(index.isOdd){   //index가 홀수이면 
             return Divider();
           }

           var realIndex = index ~/ 2;    //  ~/ - 몫

           if(realIndex >= _suggestions.length){
             _suggestions.addAll(generateWordPairs().take(10));
           }

          return _buildRow(_suggestions[realIndex]);
        });
  }

  
  Widget _buildRow(WordPair pair){

    final bool alreadySaved = _saved.contains(pair);    //_saved 안에 pair 라는 단어가 있으면 alreadySaved에 true 없으면 false

    return ListTile(
            title : Text(
              pair.asPascalCase,
              textScaleFactor: 1.5,
              ),
      trailing: Icon(
      alreadySaved? Icons.favorite : Icons.favorite_border,     //alreadySaved에 값이 있으면 하트(색) 값이 없으면 하트(테두리)
      color: Colors.pink,   //하트 테두리 핑크
       ),
       onTap: (){   //클릭 시 
        setState(() {     //StatefulWidget에 있는 state를 다시 재실행 해줌. (state가 변경이 되었다는 걸 알려줌)
        
         if(alreadySaved)   //ture
           _saved.remove(pair);

         else     //false
           _saved.add(pair);

        print(_saved.toString());      
        });
       },
    );
  }
}
