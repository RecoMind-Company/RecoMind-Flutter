import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/bloc/plan_comment_bloc.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/bloc/plan_comment_event.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/bloc/plan_comment_state.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/data/comments_model.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/data/comments_repo.dart';
// تأكد من صحة مسار عمل import لملف الـ UserRepository الخاص بك
import 'package:recomind/features/manager/dashboard/company%20plans/data/user.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';

void showChatDialog(BuildContext context, String planID) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) => BlocProvider(
      create: (context) => PlanCommentBloc(PlanCommentRepository())..add(FetchCommentsEvent(planID)),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: ChatDialogContent(planID: planID),
      ),
    ),
  );
}

class ChatDialogContent extends StatefulWidget {
  final String planID;
  const ChatDialogContent({Key? key, required this.planID}) : super(key: key);

  @override
  State<ChatDialogContent> createState() => _ChatDialogContentState();
}

class _ChatDialogContentState extends State<ChatDialogContent> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double dialogHeight = MediaQuery.of(context).size.height * 0.65;

    return Container(
      height: dialogHeight,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF060B1B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, color: Colors.white, size: 28),
            ),
          ),
          const Gap(10),

          Expanded(
            child: BlocBuilder<PlanCommentBloc, PlanCommentState>(
              builder: (context, state) {
                if (state is PlanCommentLoading) {
                  return const Center(
                    child: SwappedShrinkingLoading(size: 50, strokeWidth: 5),
                  );
                } else if (state is PlanCommentFailure) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (state is PlanCommentLoaded || state is PlanCommentSending) {
                  final comments = state is PlanCommentLoaded
                      ? state.comments
                      : (state as PlanCommentSending).currentComments;

                  if (comments.isEmpty) {
                    return const Center(
                      child: Text(
                        "No comments yet",
                        style: TextStyle(color: Color(0xFF56627C), fontSize: 14),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: comments.length,
                    separatorBuilder: (context, index) => const Gap(16),
                    itemBuilder: (context, index) {
                      final comment = comments[index];

                      // 💡 نمرر كائن الـ comment بالكامل للكارد الذكي للتعامل مع جلب بيانات المستخدم
                      return CommentMessageCard(
                        comment: comment,
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          const Gap(20),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF141A29),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF262E42), width: 1.5),
                  ),
                  child: TextField(
                    controller: _commentController,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Write a comment...",
                      hintStyle: TextStyle(color: Color(0xFF56627C)),
                    ),
                  ),
                ),
              ),
              const Gap(12),
              GestureDetector(
                onTap: () {
                  final String commentText = _commentController.text.trim();
                  if (commentText.isNotEmpty) {
                    context.read<PlanCommentBloc>().add(
                      SendCommentEvent(
                        planId: widget.planID,
                        request: AddCommentRequest(
                          userComment: commentText,
                        ),
                      ),
                    );
                    _commentController.clear();
                  }
                },
                child: const Icon(
                  Icons.send_rounded,
                  color: Color(0xFF67D8F8),
                  size: 28,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// 💡 كارد ذكي منفصل (StatefulWidget) لربط الـ UserRepository وجلب الاسم محلياً
// =========================================================================
class CommentMessageCard extends StatefulWidget {
  final PlanCommentModel comment;
  const CommentMessageCard({Key? key, required this.comment}) : super(key: key);

  @override
  State<CommentMessageCard> createState() => _CommentMessageCardState();
}

class _CommentMessageCardState extends State<CommentMessageCard> {
  final UserRepository _userRepository = UserRepository();
  String? _resolvedName;
  bool _isLoadingUser = false;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  void didUpdateWidget(covariant CommentMessageCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // إعادة الجلب إذا تغير الـ userId الخاص بالتعليق المفحوص
    if (oldWidget.comment.userId != widget.comment.userId) {
      _fetchUserData();
    }
  }

  Future<void> _fetchUserData() async {
    // إذا كان الاسم موجوداً مسبقاً في الموديل، نستخدمه مباشرة
    if (widget.comment.userName != null && widget.comment.userName!.isNotEmpty) {
      setState(() {
        _resolvedName = widget.comment.userName;
      });
      return;
    }

    final String? currentUserId = widget.comment.userId;
    if (currentUserId == null || currentUserId.isEmpty) {
      setState(() {
        _resolvedName = "Unknown User";
      });
      return;
    }

    setState(() {
      _isLoadingUser = true;
    });

    // استدعاء ريبو جلب بيانات المستخدم الفعلي
    final result = await _userRepository.getUser(userId: currentUserId);

    if (mounted) {
      result.fold(
            (failure) {
          // في حال فشل الـ API (مثل خطأ 404)، نقوم بتنظيف المعرف النصي ليعرض بشكل جمالي
          setState(() {
            _isLoadingUser = false;
            if (currentUserId.contains('-')) {
              final parts = currentUserId.split('-');
              _resolvedName = parts.length > 1 ? parts[1] : currentUserId;
            } else {
              _resolvedName = currentUserId;
            }
          });
        },
            (userModel) {
          setState(() {
            _isLoadingUser = false;
            // إسناد الاسم الراجع من الـ UserModel بنجاح
            _resolvedName = userModel.name ?? currentUserId;
            widget.comment.userName = _resolvedName; // حفظه في الكائن تجنباً لإعادة الاستدعاء
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String time = widget.comment.createdAt != null && widget.comment.createdAt!.length >= 16
        ? widget.comment.createdAt!.substring(11, 16)
        : "";

    final String displayName = _isLoadingUser ? "Loading name..." : (_resolvedName ?? "Unknown User");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF141A29),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(0xFF262E42),
                    child: Icon(Icons.person, color: Colors.white, size: 20),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayName,
                          style: TextStyle(
                            color: _isLoadingUser ? const Color(0xFF56627C) : Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontStyle: _isLoadingUser ? FontStyle.italic : FontStyle.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Gap(2),
                        Text(
                          time,
                          style: const TextStyle(
                            color: Color(0xFF8F9BB3),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(12),
              Text(
                widget.comment.userComment ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const Gap(12),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF141A29),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.reply, size: 14, color: Color(0xFF8F9BB3)),
                Gap(4),
                Text(
                  "Reply",
                  style: TextStyle(color: Color(0xFFE5E5E5), fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}