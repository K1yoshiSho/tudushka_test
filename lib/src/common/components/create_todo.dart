import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tudushka/src/common/components/app_button.dart';
import 'package:tudushka/src/common/components/bottomsheet_header.dart';
import 'package:tudushka/src/common/components/deadline_picker.dart';
import 'package:tudushka/src/common/components/drop_down.dart';
import 'package:tudushka/src/common/components/textfield_outlined.dart';
import 'package:tudushka/src/common/utils/utils.dart';
import 'package:tudushka/src/services/persistence/collections/todo.dart';
import 'package:tudushka/src/services/persistence/isar.dart';
import 'package:tudushka/src/theme/app_colors.dart';
import 'package:tudushka/src/theme/app_text_style.dart';

/// [CreateTodoSheet] -  the bottom sheet for create todo.
class CreateTodoSheet extends StatefulWidget {
  final Todo? todo;
  final bool onEdit;
  final String title;
  final Function() onEditFunction;
  const CreateTodoSheet(
      {Key? key, required this.todo, required this.onEdit, required this.title, required this.onEditFunction})
      : super(key: key);

  @override
  State<CreateTodoSheet> createState() => _CreateTodoSheetState();
}

class _CreateTodoSheetState extends State<CreateTodoSheet> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _categoryController;
  late TextEditingController _deadlineController;
  DateTime? _deadline;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.todo?.title);
    _descriptionController = TextEditingController(text: widget.todo?.description);
    _categoryController =
        TextEditingController(text: widget.todo != null ? getCategoryNameFromId(id: widget.todo!.category ?? 0) : "");
    _deadlineController = TextEditingController(
        text: (widget.todo != null && widget.todo?.deadline != null)
            ? DateFormat('dd.MM.yyyy HH:mm').format(widget.todo!.deadline!)
            : "");
    _deadline = widget.todo?.deadline;
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _deadlineController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Form(
        key: _formKey,
        child: Material(
          color: Colors.transparent,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.65,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: BottomSheetHeaderContainer(),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 10.0, 16.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        maxLines: 1,
                        style: AppTextStyle.bodyMedium600(context).copyWith(
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.cancel_outlined,
                          size: 20,
                          color: AppColors.gray600,
                        ),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(0.0)),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                          overlayColor: MaterialStateProperty.all<Color>(AppColors.splashColor),
                          shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Divider(
                        color: AppColors.gray200,
                        height: 1.0,
                        thickness: 2,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: OutlinedTextfield(
                          textController: _titleController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Пожалуйста, введите заголовок";
                            }
                            return null;
                          },
                          hintText: 'Заголовок',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: OutlinedTextfield(
                          textController: _descriptionController,
                          maxLines: 5,
                          hintText: 'Описание',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: CustomDropDown<String>(
                          options: const ['Важные', 'Срочные', 'Обычные'],
                          onChanged: (val) {
                            setState(() {
                              _categoryController.text = val ?? "";
                            });
                          },
                          disabled: false,
                          validator: (value) {
                            if (value == null) {
                              return "Пожалуйста, выберите категорию";
                            }
                            return null;
                          },
                          suffixIcon: (_categoryController.text.isNotEmpty)
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      _categoryController.text = "";
                                      FocusManager.instance.primaryFocus?.unfocus();
                                    });
                                  },
                                  child: const Icon(
                                    Icons.cancel_outlined,
                                    color: AppColors.gray600,
                                    size: 19,
                                  ),
                                )
                              : null,
                          dropDownValue: _categoryController.text,
                          disabledTextStyle: AppTextStyle.labelLarge400(context).copyWith(
                            color: AppColors.gray800,
                            fontSize: 14,
                          ),
                          height: 55,
                          textStyle: AppTextStyle.bodyMedium400(context).copyWith(
                            overflow: TextOverflow.ellipsis,
                          ),
                          hintText: "Выберите категорию",
                          icon: const Icon(
                            Icons.expand_more_rounded,
                            color: AppColors.gray800,
                            size: 18,
                          ),
                          elevation: 0,
                          borderColor: AppColors.gray200,
                          borderWidth: 1.5,
                          borderRadius: 12,
                          margin: const EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                          hidesUnderline: true,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            DeadlinePicker(
                              controller: _deadlineController,
                              ifSelected: (value) {
                                setState(() {
                                  _deadline = value;
                                  _deadlineController.text = DateFormat('dd.MM.yyyy HH:mm').format(DateTime(
                                    value.year,
                                    value.month,
                                    value.day,
                                    value.hour,
                                    value.minute,
                                  ));
                                });
                              },
                              ifSelectedNull: () {
                                setState(() {
                                  _deadline = null;
                                  _deadlineController.text = '';
                                });
                              },
                              onRemove: () {
                                setState(() {
                                  _deadline = null;
                                  _deadlineController.clear();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (widget.onEdit) {
                          Todo todoTemp = widget.todo!;
                          todoTemp.title = _titleController.text;
                          todoTemp.description = _descriptionController.text;
                          todoTemp.category = getCategoryFromString(category: _categoryController.text);
                          todoTemp.deadline = _deadline;

                          IsarService().editTodo(todo: todoTemp);
                          Navigator.pop(context);
                        } else {
                          IsarService()
                              .insertTodo(
                                  todo: Todo(
                            title: _titleController.text,
                            description: _descriptionController.text,
                            category: getCategoryFromString(category: _categoryController.text),
                            createdAt: DateTime.now(),
                            deadline: _deadline,
                          ))
                              .then((value) {
                            Navigator.pop(context);
                            widget.onEditFunction();
                          });
                        }
                      }
                    },
                    text: widget.onEdit ? 'Сохранить' : 'Создать',
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
