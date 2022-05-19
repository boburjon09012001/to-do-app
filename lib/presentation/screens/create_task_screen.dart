import 'package:flutter/material.dart';


import '../../app_colors.dart';
import '../../database_helper.dart';
import '../../models/task.dart';
import '../../models/tasks.dart';

class CreateTaskPage extends StatefulWidget {
  Task? currentTask;

  CreateTaskPage({this.currentTask, Key? key}) : super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  @override
  late TimeOfDay time;
  late TimeOfDay time2;
  late TimeOfDay picket;
  late TimeOfDay picket2;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    time = TimeOfDay.now();
    time2 = TimeOfDay.now();

    if (widget.currentTask != null) {
      _nameController.text = widget.currentTask?.title ?? "...";
      _dateController.text = widget.currentTask?.startTime ?? "...";
    }
  }

  //select time
  Future<void> selectTime(BuildContext context) async {
    picket = (await showTimePicker(context: context, initialTime: time))!;
    if (picket != null) {
      setState(() {
        time = picket;
      });
    }
  }

  Future<void> selectTime2(BuildContext context) async {
    picket2 = (await showTimePicker(context: context, initialTime: time2))!;
    if (picket2 != null) {
      setState(() {
        time2 = picket2;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: const Color(0xff3A49F9),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff9C2CF3), Color(0xff3A49F9)],
                        begin: const FractionalOffset(1.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        tileMode: TileMode.clamp),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 64,
                            ),
                            Text(
                              widget.currentTask == null
                                  ? 'Create a Task'
                                  : 'Update a task',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            const SizedBox(
                              width: 64,
                            ),
                            const Icon(
                              Icons.search,
                              size: 32,
                              color: Colors.white,
                            )
                          ],
                        ),
                        form()
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Time(context),
                        divider(context),
                        const SizedBox(
                          height: 26,
                        ),
                        const Text(
                          "Description",
                          style: TextStyle(color: Color(0xffBFC8E8), fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Lorem ipsum dolor sit amet, "
                              "er adipiscing elit, sed dianummy "
                              "nibh euismod dolor sit amet, er adipiscing elit, "
                              "sed dianummy nibh euismod.",
                          style: TextStyle(
                              color: Color(0xff2E3A59), fontSize: 20, height: 1.2),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        divider(context),
                        const SizedBox(
                          height: 26,
                        ),
                        const Text(
                          "Category",
                          style: TextStyle(color: Color(0xffBFC8E8), fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        categories(context),
                        const SizedBox(
                          height: 30,
                        ),
                        createButton(),
                        SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget Time(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Row(
          children: [
            InkWell(
                onTap: () {
                  selectTime(context);
                  print(time);
                },
                child:const Text(
                  "Start Time",
                  style: TextStyle(fontSize: 20, color: Color(0xffBFC8E8)),
                )),
            const SizedBox(
              width: 70,
            ),
            InkWell(
              onTap: () {
                selectTime2(context);
                print(time2);
              },
              child: const Text("End Time",
                  style: TextStyle(fontSize: 20, color: Color(0xffBFC8E8))),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Text(
              "${time.hour}:${(time.minute < 10) ? '0${time.minute}' : '${time.minute}'}",
              style: const TextStyle(fontSize: 28, color: Color(0xff2E3A59)),
            ),
            const SizedBox(
              width: 70,
            ),
            Text(
              "${time2.hour}:${(time2.minute < 10) ? '0${time2.minute}' : '${time2.minute}'} ",
              style: const TextStyle(fontSize: 28, color: Color(0xff2E3A59)),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget divider(BuildContext context) {
    return const Divider(
      height: 3,
      color: Color(0xffBFC8E8),
    );
  }

  Widget categories(BuildContext context) {
    return Wrap(
        spacing: 10,
        runSpacing: 8,
        children: List.generate(CategoryTask.topics.length, (index) {
          var category = CategoryTask.topics[index];
          return ChoiceChip(
            padding: const EdgeInsets.all(16),
            selectedColor: AppColors.lightbottomGradient,
            disabledColor: AppColors.lightNoSelectColor,
            backgroundColor: AppColors.lightNoSelectColor,
            labelStyle: TextStyle(
                color: category.isSelected ? Colors.white : Colors.black),
            label: Text(category.title),
            selected: category.isSelected,
            onSelected: (value) {
              setState(() {
                category.isSelected = !category.isSelected;
              });
            },
          );
        }));
  }

  Widget createButton() {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff9C2CF3), Color(0xff3A49F9)],
                begin: const FractionalOffset(1.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                tileMode: TileMode.clamp),
            borderRadius: BorderRadius.all(Radius.circular(40))),
        child: TextButton(
          onPressed: () {
            widget.currentTask == null ? createTask() : updateTask();
          },
          child: Center(
            child: Text(
              widget.currentTask == null ? 'Create task' : 'Update task',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ));
  }

  Widget form() {
    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          style: const TextStyle(color: Colors.white, fontSize: 30),
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: "Name",
            fillColor: Colors.white,
            labelStyle:
            TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 3),
          ),
        ),
        SizedBox(
          height: 14,
        ),
        TextFormField(
          controller: _dateController,
          style: const TextStyle(color: Colors.white, fontSize: 30),
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: "Date",
            fillColor: Colors.white,
            labelStyle:
            TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 3),
          ),
        )
      ],
    );
  }

  void createTask() async {
    Task newTask = Task(
        _nameController.text, "description1", DateTime.now(), "07:47", "19:00");

    var res = await DatabaseHelper.intance.insert(newTask);
    print(res);

    Navigator.pop(context);
  }

  void updateTask() async {
    Task currentTask = Task.withId(
      widget.currentTask?.id,
      _nameController.text,
      "description1",
      DateTime.now(),
      _dateController.text,
      "19:00",
    );

    var res = await DatabaseHelper.intance.update(currentTask);
    print("Updated task : $res");
    Navigator.pop(context);
  }
}

// CRUD
// C - Create (yaratish) +
// R - Read (O'qish) +
// U - update (yangilash)
// D - Delete (o'chirish)