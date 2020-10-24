import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafsir/constants.dart';
import 'package:tafsir/navigation/bloc/active_page_bloc.dart';
import 'package:tafsir/search/bloc/search_bloc.dart';
import 'package:tafsir/search/model/search_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();

  String _phrase;
  bool _isInAayaat;
  bool _isInTranslation;
  bool _isInTafsir;

  @override
  void initState() {
    super.initState();

    final state = BlocProvider.of<SearchBloc>(context).state;
    _phrase = state.phrase;
    _isInAayaat = state.isInAayaat;
    _isInTranslation = state.isInTranslation;
    _isInTafsir = state.isInTafsir;

    controller.text = _phrase;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const checkboxPadding = 6.0;

    return Column(
      children: [
        _buildPhraseField(context),
        CheckboxListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: checkboxPadding),
          controlAffinity: ListTileControlAffinity.leading,
          title: Text('в аятах'),
          value: _isInAayaat,
          onChanged: (value) {
            setState(() {
              _isInAayaat = value;
            });
          },
        ),
        CheckboxListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: checkboxPadding),
          controlAffinity: ListTileControlAffinity.leading,
          title: Text('в переводе'),
          value: _isInTranslation,
          onChanged: (value) {
            setState(() {
              _isInTranslation = value;
            });
          },
        ),
        CheckboxListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: checkboxPadding),
          controlAffinity: ListTileControlAffinity.leading,
          title: Text('в тафсире'),
          value: _isInTafsir,
          onChanged: (value) {
            setState(() {
              _isInTafsir = value;
            });
          },
        ),
        Divider(height: 1),
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchSuccess)
                return _buildFoundItems(state, context);
              else if (state is SearchInProgress)
                return Center(child: CircularProgressIndicator());
              else
                return Container();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPhraseField(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: padding),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration.collapsed(
                hintText: 'Введите искомую фразу',
              ),
              onChanged: (value) => _phrase = value,
              onEditingComplete: _search,
            ),
          ),
          IconButton(
            padding: const EdgeInsets.all(0),
            icon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
            tooltip: 'Найти',
            onPressed: _search,
          ),
        ],
      ),
    );
  }

  Widget _buildFoundItems(SearchSuccess state, BuildContext context) {
    return ListView.builder(
      key: PageStorageKey('search-list'),
      itemCount: state.items.length,
      itemBuilder: (_, index) {
        final item = state.items.elementAt(index);
        return ListTile(
          title: Text(
            '${item.surah.title}, ${item.aayah.title}',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          onTap: () => _showAayah(context, item),
        );
      },
    );
  }

  void _showAayah(BuildContext context, SearchItem item) async {
    BlocProvider.of<ActivePageBloc>(context).add(
      ActivePageTextShown(
        item.surah,
        BlocProvider.of<ActivePageBloc>(context).state.textHistory,
        item.aayah.weight,
      ),
    );
  }

  void _search() {
    if (_phrase.isEmpty) return;

    BlocProvider.of<SearchBloc>(context).add(
      SearchActionTapped(
        _phrase.trim(),
        _isInAayaat,
        _isInTranslation,
        _isInTafsir,
      ),
    );
  }
}
