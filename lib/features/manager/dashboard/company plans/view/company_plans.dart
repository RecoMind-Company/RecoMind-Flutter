import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:recomind/core/network/api_error.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/data/dashboard_model.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/data/dashboard_repo.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/view/add_plan.dart';
import 'package:recomind/features/manager/dashboard/company%20plans/view/plan_detail.dart';
import 'package:recomind/shared/widgets/Gradient_Circular_Loading.dart';


class CompanyPlans extends StatefulWidget {
  CompanyPlans({super.key, required this.selectedFilterIndex});
  late int selectedFilterIndex;

  @override
  State<CompanyPlans> createState() => _CompanyPlansState();
}

class _CompanyPlansState extends State<CompanyPlans> {
  final PlanRepository _repository = PlanRepository();
  final TextEditingController _searchController = TextEditingController();

  List<ActualPlanModel> _allPlans = [];
  List<ActualPlanModel> _filteredPlans = [];
  bool _isLoading = true;
  String _errorMessage = '';

  int get _countAll => _allPlans.length;
  int get _countActionRequired => _allPlans.where((p) => p.status.toLowerCase() == 'action_required' || p.status.toLowerCase() == 'action required').length;
  int get _countActive => _allPlans.where((p) => p.status.toLowerCase() == 'active').length;
  int get _countPending => _allPlans.where((p) => p.status.toLowerCase() == 'pending' || p.status.toLowerCase() == 'draft').length;
  int get _countCompleted => _allPlans.where((p) => p.status.toLowerCase() == 'completed').length;

  @override
  void initState() {
    super.initState();
    _loadPlans();
  }

  Future<void> _loadPlans() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      final responseItems = await _repository.fetchCompanyPlans();
      _allPlans = responseItems
          .where((item) => item.isSuccess && item.value != null)
          .map((item) => item.value!)
          .toList();
      _filterPlans();
    } catch (error) {
      setState(() {
        _isLoading = false;
        if (error is ApiError) {
          _errorMessage = error.message;
        } else {
          _errorMessage = error.toString();
        }
      });
    }
  }

  void _filterPlans() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPlans = _allPlans.where((plan) {
        bool matchesSearch = plan.goal.toLowerCase().contains(query);
        bool matchesStatus = true;

        if (widget.selectedFilterIndex == 0) matchesStatus = true;
        if (widget.selectedFilterIndex == 1) matchesStatus = (plan.status.toLowerCase() == 'action_required' || plan.status.toLowerCase() == 'action required');
        if (widget.selectedFilterIndex == 2) matchesStatus = (plan.status.toLowerCase() == 'active');
        if (widget.selectedFilterIndex == 3) matchesStatus = (plan.status.toLowerCase() == 'pending' || plan.status.toLowerCase() == 'draft');
        if (widget.selectedFilterIndex == 4) matchesStatus = (plan.status.toLowerCase() == 'completed');

        return matchesSearch && matchesStatus;
      }).toList();
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Search Bar
              Material(
                borderRadius: BorderRadius.circular(23),
                elevation: 6,
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: const Color(0xFF111625),
                    borderRadius: BorderRadius.circular(23),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Color(0xFF535D6E), size: 20),
                      const Gap(10),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (val) => _filterPlans(),
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          decoration: const InputDecoration(
                            hintText: 'Enter Plan Name',
                            hintStyle: TextStyle(color: Color(0xFF535D6E), fontSize: 14, fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(20),

              /// Filter Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip(0, Icons.grid_view_rounded, 'All', '$_countAll', const Color(0xFF67D8F8)),
                    const Gap(10),
                    _buildFilterChip(1, Icons.warning_amber_rounded, 'Action Required', '$_countActionRequired', const Color(0xFFE05353)),
                    const Gap(10),
                    _buildFilterChip(2, Icons.hourglass_empty_rounded, 'Active', '$_countActive', const Color(0xFF67D8F8)),
                    const Gap(10),
                    _buildMoreChip(),
                  ],
                ),
              ),
              const Gap(24),

              /// Plans List
              if (_isLoading)
                const Center(child: Padding(padding: EdgeInsets.all(20), child: SwappedShrinkingLoading(size: 50,strokeWidth: 5,)))
              else if (_errorMessage.isNotEmpty)
                Center(child: Padding(padding: EdgeInsets.all(20), child: Text(_errorMessage, style: const TextStyle(color: Colors.red))))
              else if (_filteredPlans.isEmpty)
                  const Center(child: Padding(padding: EdgeInsets.all(20), child: Text('No Plans Found', style: TextStyle(color: Color(0xFF8E9AA6)))))
                else
                  ..._filteredPlans.map((plan) {
                    Color statusColor = const Color(0xFF67D8F8);
                    Color statusBgColor = const Color(0xFF142438);
                    bool hasAlert = false;

                    if (plan.status.toLowerCase() == 'action_required' || plan.status.toLowerCase() == 'action required') {
                      statusColor = const Color(0xFFE05353);
                      statusBgColor = const Color(0xFF2C1921);
                      hasAlert = true;
                    } else if (plan.status.toLowerCase() == 'draft' || plan.status.toLowerCase() == 'pending') {
                      statusColor = const Color(0xFFD4E313);
                      statusBgColor = const Color(0xFF242514);
                    } else if (plan.status.toLowerCase() == 'completed') {
                      statusColor = const Color(0xFF3CD182);
                      statusBgColor = const Color(0xFF132A1E);
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildPlanCard(
                        moduleId: plan.modules.isNotEmpty ? plan.modules[0].id : '',
                        planId: plan.id,
                        planName: plan.goal,
                        statusLabel: plan.status,
                        statusColor: statusColor,
                        statusBgColor: statusBgColor,
                        progress: 0.05,
                        progressText: plan.duration != '0' ? '${plan.duration} Days' : '0%',
                        progressBarColor: statusColor,
                        hasAlert: hasAlert,
                        alertText: hasAlert ? 'Action required on this plan' : null,
                      ),
                    );
                  }),
              const Gap(85),
            ],
          ),
        ),
        Positioned(
          right: 20,
          bottom: 20,
          child: SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddPlan()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF67D8F8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 18),
                elevation: 4,
              ),
              icon: const Icon(Icons.add_circle_outline, color: Color(0xFF060B1B), size: 20),
              label: const Text(
                'Add Plan',
                style: TextStyle(
                  color: Color(0xFF060B1B),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Filter Chip Builder
  Widget _buildFilterChip(int index, IconData icon, String label, String count, Color activeColor) {
    bool isSelected = widget.selectedFilterIndex == index;

    Color bgColor = const Color(0xFF111625);
    Color borderCol = const Color(0xFF1E2538);
    Color textColor = const Color(0xFF8E9AA6);
    Color iconColor = const Color(0xFF535D6E);

    if (isSelected) {
      textColor = Colors.white;
      if (index == 1) {
        bgColor = const Color(0xFF2C1921);
        borderCol = const Color(0xFFE05353);
        iconColor = const Color(0xFFE05353);
      } else {
        bgColor = const Color(0xFF142438);
        borderCol = const Color(0xFF67D8F8);
        iconColor = const Color(0xFF67D8F8);
      }
    } else {
      if (index == 1) {
        bgColor = const Color(0xFF2F2029);
        borderCol = const Color(0xFF5A2A30);
        textColor = const Color(0xFF9E7E83);
        iconColor = const Color(0xFF7D434A);
      }
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.selectedFilterIndex = index;
          _filterPlans();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: borderCol,
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 18),
            const Gap(8),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
            const Gap(10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2538),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                count,
                style: const TextStyle(
                  color: Color(0xFF8E9AA6),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// More Chip
  Widget _buildMoreChip() {
    return GestureDetector(
      onTap: () => _showMoreBottomSheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF111625),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFF1E2538), width: 1.2),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.menu, color: Color(0xFF8E9AA6), size: 16),
            Gap(6),
            Text(
              'More',
              style: TextStyle(
                color: Color(0xFF8E9AA6),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Bottom Sheet Menu
  void _showMoreBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF090E1D),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 34),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Gap(12),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white, size: 26),
                ),
              ),
              const Gap(10),
              _buildBottomSheetItem(
                index: 3,
                icon: Icons.access_time_filled_rounded,
                iconColor: const Color(0xFFD4E313),
                label: 'Pending',
                count: '$_countPending',
                showDivider: true,
              ),
              _buildBottomSheetItem(
                index: 4,
                icon: Icons.check_circle_outline_rounded,
                iconColor: const Color(0xFF3CD182),
                label: 'Completed',
                count: '$_countCompleted',
                showDivider: true,
              ),
              _buildBottomSheetItem(
                index: 1,
                icon: Icons.warning_amber_rounded,
                iconColor: const Color(0xFFE05353),
                label: 'Action Required',
                count: '$_countActionRequired',
                showDivider: false,
              ),
              const Gap(100)
            ],
          ),
        );
      },
    );
  }

  /// Bottom Sheet Item Builder
  Widget _buildBottomSheetItem({
    required int index,
    required IconData icon,
    required Color iconColor,
    required String label,
    required String count,
    required bool showDivider,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            setState(() {
              widget.selectedFilterIndex = index;
              _filterPlans();
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 22),
                const Gap(12),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2538),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    count,
                    style: const TextStyle(
                      color: Color(0xFF8E9AA6),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          const Divider(
            color: Color(0xFF1E2538),
            height: 1,
            thickness: 1,
          ),
      ],
    );
  }

  /// Plan Card Builder
  Widget _buildPlanCard({
    required String moduleId,
    required String planId,
    required String planName,
    required String statusLabel,
    required Color statusColor,
    required Color statusBgColor,
    required double progress,
    required String progressText,
    required Color progressBarColor,
    required bool hasAlert,
    String? alertText,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PlanDetailsScreen(
                  planId: planId,
                  planName: planName,
                  status: statusLabel,
                ),
          ),
        );
        print(planId);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF141A2B),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    planName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Gap(10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Gap(6),
                      Text(
                        statusLabel,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Progress',
                  style: TextStyle(
                    color: Color(0xFFCCCCCC),
                    fontSize: 16,
                  ),
                ),
                Text(
                  progressText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Gap(10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: const Color(0xFF1E2538),
                valueColor: AlwaysStoppedAnimation<Color>(progressBarColor),
                minHeight: 16,
                borderRadius: const BorderRadius.only(topRight: Radius.circular(16), bottomRight: Radius.circular(16)),
              ),
            ),
            const Gap(16),
            if (hasAlert && alertText != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF212636),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.circle, color: Color(0xFFE05353), size: 12),
                    const Gap(10),
                    Text(
                      alertText,
                      style: const TextStyle(
                        color: Color(0xFFD2D6DC),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
            else
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildTag(Icons.campaign_outlined, 'Marketing'),
                    const Gap(8),
                    _buildTag(Icons.monetization_on_outlined, 'Sales'),
                    const Gap(8),
                    _buildHRTag(),
                    const Gap(8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A2132),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Text(
                        '+3',
                        style: TextStyle(
                          color: Color(0xFF8E9AA6),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Tag Builder
  Widget _buildTag(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2132),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF8E9AA6), size: 16),
          const Gap(6),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF8E9AA6),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  /// HR Tag Builder
  Widget _buildHRTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2132),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'HR',
            style: TextStyle(
              color: Color(0xFF8E9AA6),
              fontSize: 13,
            ),
          ),
          const Gap(4),
          Stack(
            alignment: Alignment.bottomRight,
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 3, bottom: 2),
                child: Icon(Icons.person_outline_rounded, color: Color(0xFF8E9AA6), size: 15),
              ),
              Icon(Icons.search, color: Color(0xFF8E9AA6), size: 10),
            ],
          ),
        ],
      ),
    );
  }
}