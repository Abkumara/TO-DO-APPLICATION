import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List newtask = [];
  TextEditingController taskAdd = TextEditingController();

  Future<void> addTask() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: TextFormField(
            controller: taskAdd,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        newtask.add(taskAdd.text);
                      });
                      print(newtask);
                      taskAdd.clear();
                      Navigator.pop(context);
                    },
                    child: const Text('Save')),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'))
              ],
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    taskAdd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: const Text('My Task List'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: addTask,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: newtask.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(newtask[index]),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                newtask.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('remove the task'),
                duration: Duration(seconds: 2),
              ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(newtask[index]),
                tileColor: Colors.blue[50],
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none),
              ),
            ),
          );
        },
      ),
    );
  }
}
