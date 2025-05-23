import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../components/widgets.dart';
import '../../../utils/font_sizes.dart';
import '../../components/build_text_field.dart';
import '../../components/custom_app_bar.dart';
import '../../providers/riverpod_providers/tasks_provider.dart';
import '../../utils/color_palette.dart';
import '../widgets/task_item_view.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await ref.read(districtsProvider.notifier).districts(context);
      ref.read(taskProvider.notifier).fetchTasks(); // Load tasks on screen load
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider);
    var size = MediaQuery.of(context).size;
    final taskState = ref.watch(taskProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: ScaffoldMessenger(
        child: Scaffold(
          backgroundColor: kWhiteColor,
          appBar: CustomAppBar(
            title: 'Hi ${user!.user!.email}',
            showBackArrow: false,
            actionWidgets: [
              PopupMenuButton<int>(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 1,
                onSelected: (value) {
                  final taskNotifier = ref.read(taskProvider.notifier);

                  switch (value) {
                    case 0: // Sort by start date
                      taskNotifier.sortTasks(
                          sortBy: "startDate", ascending: true);
                      break;
                    case 1: // Sort by completion status
                      taskNotifier.sortTasks(
                          sortBy: "completed", ascending: false);
                      break;
                    case 2: // Sort by priority
                      taskNotifier.sortTasks(
                          sortBy: "priority", ascending: true);
                      break;
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<int>(
                      value: 2,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/task.svg',
                            width: 15,
                          ),
                          const SizedBox(width: 10),
                          buildText(
                              'Sort by priority',
                              kBlackColor,
                              textSmall,
                              FontWeight.normal,
                              TextAlign.start,
                              TextOverflow.clip),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/task_checked.svg',
                            width: 15,
                          ),
                          const SizedBox(width: 10),
                          buildText(
                              'Sort by completed',
                              kBlackColor,
                              textSmall,
                              FontWeight.normal,
                              TextAlign.start,
                              TextOverflow.clip),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 0,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/calender.svg',
                            width: 15,
                          ),
                          const SizedBox(width: 10),
                          buildText(
                              'Sort by start date',
                              kBlackColor,
                              textSmall,
                              FontWeight.normal,
                              TextAlign.start,
                              TextOverflow.clip),
                        ],
                      ),
                    ),
                  ];
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SvgPicture.asset('assets/svgs/filter.svg'),
                ),
              ),
            ],
          ),
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  BuildTextField(
                    hint: "Search recent task",
                    controller: searchController,
                    inputType: TextInputType.text,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: kGrey2,
                    ),
                    fillColor: kWhiteColor,
                    onChange: (value) {
                      ref.read(taskProvider.notifier).searchTasks(value);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  taskState.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: taskState.tasks.length,
                            itemBuilder: (context, index) {
                              return TaskItemView(
                                taskModel: taskState.tasks[index],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider(
                                color: kGrey3,
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(
              Icons.add_circle,
              color: kPrimaryColor,
            ),
            onPressed: () {
              context.push('/createTask');
            },
          ),
        ),
      ),
    );
  }
}
