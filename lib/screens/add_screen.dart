import 'package:flutter/material.dart';
import 'package:task_master/models/todo_model.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _task = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final _addItemFormKey = GlobalKey<FormState>();
  Enum dropdownValue = categoryEnum.home;
  @override
  Widget build(BuildContext context) {
    var todoModel = context.watch<ToDoModel>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Task'),
          backgroundColor: todoModel.giveEnumGetColor(dropdownValue),
          elevation: 0,
          centerTitle: true,
        ),
        body: Form(
          key: _addItemFormKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24.0),
                      const Text('Task',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'Enter task here',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                        controller: _task,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 30.0),
                      const Text(
                        'Description',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        autofocus: true,
                        decoration: const InputDecoration(
                            hintText: 'Enter description here',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)))),
                        controller: _description,
                        maxLines: 4,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 24.0),
                    ],
                  ),
                  DropdownButton<Enum>(
                    value: dropdownValue,
                    items: categoryEnum.values
                        .map<DropdownMenuItem<Enum>>((Enum value) =>
                            DropdownMenuItem<Enum>(
                                child: Text(value.name), value: value))
                        .toList(),
                    onChanged: (Enum? newValue) =>
                        setState(() => dropdownValue = newValue!),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text(
                        'ADD TASK',
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              todoModel.giveEnumGetColor(dropdownValue)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 8))),
                      onPressed: () {
                        context.read<ToDoModel>().addToDo(
                              _task.text,
                              _description.text,
                              dropdownValue,
                            );
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
