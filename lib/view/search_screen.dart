import 'package:flutter_search_sample/common/importer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static const routeName = '/search_page';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _searchText = '';

  Future<List<Fruit>> _getSearchResult(keyword) async {
    FruitService fruitService = FruitService();
    List<Fruit> result = await fruitService.getFruitsByKeyword(keyword);
    return result;
  }

  TextFormField _buildTextFormField(
      BuildContext context, TextEditingController controller) {
    return TextFormField(
      //検索フィールドの表示
      controller: controller,
      cursorColor: Colors.grey.shade500,
      autofocus: true,
      onChanged: (text) {
        setState(() {
          _searchText = text;
        });
      },
      style: const TextStyle(fontSize: 18.0),
      decoration: _inputDecoration(context, controller),
    );
  }

  InputDecoration _inputDecoration(
      BuildContext context, TextEditingController controller) {
    return InputDecoration(
      fillColor: Colors.grey.shade300,
      icon: Icon(
        Icons.search,
        color: Theme.of(context).primaryColor,
      ),
      labelStyle: const TextStyle(
        color: Colors.blue,
      ),
      hintText: 'Enter a keyword',
      suffixIcon: IconButton(
        icon: const Icon(
          Icons.cancel,
          color: Colors.grey,
        ),
        onPressed: () {
          setState(() {
            controller.clear();
            _searchText = ''; //検索文字列のクリア
          });
        },
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 1.0)),
    );
  }

  Container _buildResultContainer(String text) {
    return Container(
        color: Colors.white,
        child: FutureBuilder<List<Fruit>>(
          future: _getSearchResult(text),
          builder: (BuildContext context, AsyncSnapshot<List<Fruit>> snapshot) {
            List<Widget> children = [];
            List<Fruit> fruits = [];
            if (snapshot.hasData) {
              fruits.addAll(snapshot.data!);
              children.add(Text(
                '${fruits.length} found',
                style: const TextStyle(fontSize: 16.0, color: Colors.grey),
              ));
              children.add(const SizedBox(
                height: 20.0,
              ));
              for (var item in fruits) {
                children.add(Text(
                  item.name,
                  style: const TextStyle(fontSize: 18.0),
                ));
              }
            } else if (snapshot.hasError) {
              children = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ];
            } else {
              children = const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                )
              ];
            }
            return Center(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                children: children,
              ),
            );
          },
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Search Sample'),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            _buildTextFormField(context, _controller),
            const SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: _buildResultContainer(_searchText),
            ),
          ],
        ),
      ),
    );
  }
}
