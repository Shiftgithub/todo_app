import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/widgets/todo_item.dart';
import 'package:todo_app/models/todo.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = Todo.todoList();
  List<Todo> _foundTodo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundTodo = todosList;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                _buildSearchBox(),
                Expanded(
                  child: _buildTodoList(),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildAddTodo(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: _runFilter,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            maxWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
        ),
      ),
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _foundTodo.length,
      itemBuilder: (context, index) {
        final todo = _foundTodo[index];
        return TodoItem(
          todo: todo,
          onTodoChanged: _handleTodoChange,
          onDeleteItem: _handleDeleteTodo,
        );
      },
    );
  }

  Widget _buildAddTodo() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 60,
            margin: EdgeInsets.only(
              bottom: 20,
              right: 20,
              left: 20,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _todoController,
              decoration: InputDecoration(
                hintText: 'Add a new todo item',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            bottom: 20,
            top: 20,
          ),
          child: ElevatedButton(
            child: Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              _handleAddTodo(_todoController.text);
            },
            style: ElevatedButton.styleFrom(
              primary: tdBlue,
              minimumSize: Size(60, 60),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleDeleteTodo(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _handleAddTodo(String toDo) {
    setState(() {
      todosList.add(Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo,
          isDone: false));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<Todo> results = [];

    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList.where((item) {
        final todoText = item.todoText?.toLowerCase() ?? '';
        return todoText.contains(enteredKeyword.toLowerCase());
      }).toList();
    }

    setState(() {
      _foundTodo = results;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/turan2.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}
