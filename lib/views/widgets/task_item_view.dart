import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/providers/riverpod_providers/tasks_provider.dart';
import '../../../components/widgets.dart';
import '../../model/task_model.dart';
import '../../../utils/color_palette.dart';
import '../../../utils/font_sizes.dart';
import '../../../utils/util.dart';

class TaskItemView extends ConsumerStatefulWidget {
  final TaskModel taskModel;
  const TaskItemView({super.key, required this.taskModel});

  @override
  ConsumerState<TaskItemView> createState() => _TaskItemViewState();
}

class _TaskItemViewState extends ConsumerState<TaskItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
                value: widget.taskModel.completed,
                onChanged: (value) {
                  widget.taskModel.completed = !widget.taskModel.completed;
                  ref.read(taskProvider.notifier).completeTask(
                      widget.taskModel.id, widget.taskModel);
                  //
                }),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: buildText(
                              widget.taskModel.title,
                              kBlackColor,
                              textMedium,
                              FontWeight.w500,
                              TextAlign.start,
                              TextOverflow.clip)),
                      PopupMenuButton<int>(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: kWhiteColor,
                        elevation: 1,
                        onSelected: (value) {
                          switch (value) {
                            case 0:
                              {
                                context.push('/updateTask',
                                    extra: widget.taskModel);
                                break;
                              }
                            case 1:
                              {
                                break;
                              }
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<int>(
                              value: 0,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svgs/edit.svg',
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  buildText(
                                      'Edit task',
                                      kBlackColor,
                                      textMedium,
                                      FontWeight.normal,
                                      TextAlign.start,
                                      TextOverflow.clip)
                                ],
                              ),
                            ),
                            PopupMenuItem<int>(
                              value: 1,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svgs/delete.svg',
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  buildText(
                                      'Delete task',
                                      kRed,
                                      textMedium,
                                      FontWeight.normal,
                                      TextAlign.start,
                                      TextOverflow.clip)
                                ],
                              ),
                              onTap: () {
                                ref
                                    .read(taskProvider.notifier)
                                    .removeTask(widget.taskModel.id);
                              },
                            ),
                          ];
                        },
                        child:
                            SvgPicture.asset('assets/svgs/vertical_menu.svg'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  buildText(widget.taskModel.description, kGrey1, textSmall,
                      FontWeight.normal, TextAlign.start, TextOverflow.clip),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/calender.svg',
                            width: 12,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: buildText(
                                '${formatDate(dateTime: widget.taskModel.startDateTime.toString())} - ${formatDate(dateTime: widget.taskModel.stopDateTime.toString())}',
                                kBlackColor,
                                textTiny,
                                FontWeight.w400,
                                TextAlign.start,
                                TextOverflow.clip),
                          )
                        ],
                      )),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ));
  }
}
