import 'package:flutter/material.dart';
import 'package:recomind/shared/widgets/custom_text.dart';


class Texttest extends StatelessWidget {
  const Texttest({super.key});

  @override
  Widget build(BuildContext context) {
    return customText(text: r"""### **Part 1: Employee Analysis Report**  

#### **1. Introduction**  
The analysis of 334 employees reveals a stable workforce with high average tenure (16.57 years) but significant disparities in compensation, departmental workload, and turnover. Key findings include gender-based salary gaps, a concentrated workforce in one dominant department (198 employees), and concerning turnover rates in high-salary departments. These insights highlight critical areas for intervention to ensure equity, retention, and operational efficiency.  

---

#### **2. KPI Analysis**  
- **Employee Demographics**:  
  - Gender distribution: 237 employees in one group (likely male), 97 in another (likely female), indicating a male-majority workforce.  
  - Marital status: Near-balanced (168 vs. 166), suggesting no major marital bias in workforce composition.  
  - **Significance**: Demographics inform diversity initiatives and potential equity gaps.  

- **Role and Salary Structure**:  
  - **Top job titles**: Dominated by roles with 41, 26, 26, and 26 employees, indicating high concentration in specific positions.  
  - **Salary by job title**: Wide disparity (top role: $125.5K vs. lowest: $8.48K), reflecting hierarchical compensation risks.  
  - **Salary by department**: Department 1 (highest average: $68.3K) vs. Department 16 (lowest: $10.87K), emphasizing departmental inequity.  
  - **Significance**: Compensation disparities may drive turnover and hinder morale in underpaid roles/departments.  

- **Compensation Equity**:  
  - **Gender pay gap**: Higher average salary for one gender ($20.70K vs. $17.16K), suggesting systemic inequity.  
  - **Marital status pay gap**: Slight disparity ($18.80K vs. $17.57K), indicating marital status may influence compensation.  
  - **Significance**: Inequities require immediate correction to comply with fair pay standards and boost morale.  

- **Benefits and Tenure**:  
  - **Tenure**: High average (16.57 years), implying loyalty but potentially stagnant skillsets.  
  - **Vacation/sick leave**: Department 1 leads in vacation (95.5 hrs) and sick leave (67.5 hrs), while Department 16 lags (18.3 hrs vacation, 32.25 hrs sick leave).  
  - **Significance**: Benefits disparities may contribute to dissatisfaction in low-benefit departments.  

- **Turnover**:  
  - **Department turnover**: Highest in Department 1 (17.28%) and Department 2 (16.99%), both high-salary departments.  
  - **Significance**: High turnover in critical roles/department risks knowledge loss and recruitment costs.  

- **Top Performers/Loyalty**:  
  - **Highest-paid employees**: Dominated by male names (Ken, James, Brian), reinforcing gender pay gap.  
  - **Longest-tenured employees**: 19+ years in technical/managerial roles (e.g., Production Technician, Engineering Manager), indicating expertise retention.  
  - **Significance**: Leadership pipelines rely on experienced staff, but succession planning is unclear.  

---

#### **3. Key Insights**  
- **Equity Concerns**: Gender and marital status pay gaps, coupled with departmental salary/benefits disparities, signal systemic inequity threatening morale.  
- **Departmental Imbalance**: 60% of employees (198/334) are concentrated in one department, creating operational fragility and higher turnover risk there.  
- **Turnover-Compensation Paradox**: High-turnover departments (e.g., Department 1) also have the highest salaries, suggesting dissatisfaction beyond pay (e.g., workload, culture).  
- **Tenure as a Double-Edged Sword**: High tenure indicates loyalty but may hinder innovation if not coupled with upskilling.  
- **Vacation/Sick Leave Disparities**: Low-benefit departments (e.g., 16) likely experience burnout, exacerbating turnover.  

---

#### **4. Conclusion**  
The workforce is stable but fragile, marked by deep compensation inequities, departmental over-concentration, and high turnover in critical areas. Without intervention, risks include talent drain, legal exposure from pay gaps, and operational bottlenecks. Addressing disparities, engaging high-turnover departments, and modernizing benefits are urgent priorities.  

---

### **Part 2: Actionable Recommendations**  

#### **1. Short-Term Plan (0-3 Months)**  
- **Goal**: Address immediate performance and morale issues.  
- **Analysis**:  
  - Performance metrics: Not provided, but turnover/salary gaps suggest disengagement.  
  - Salary distribution: 16x gap between highest/lowest-paid roles; gender pay gap of $3.54K.  
  - Turnover trends: Highest in Department 1 (17.28%) despite high salaries.  
- **Recommendations/Actions**:  
  - **Implement pay audits**: Correct gender/marital status pay gaps within 90 days.  
  - **Conduct departmental exit interviews**: Focus on Department 1 to diagnose turnover drivers (e.g., workload, culture).  
  - **Standardize minimum benefits**: Enforce a floor for vacation/sick leave in low-benefit departments (e.g., Department 16).  
- **Reasoning**: Pay audits reduce legal risk; exit interviews pinpoint non-compensation drivers of turnover; standardized benefits prevent burnout in high-stress roles.  

---

#### **2. Mid-Term Plan (3-6 Months)**  
- **Goal**: Improve employee retention and engagement.  
- **Analysis**:  
  - Historical departure trends: High turnover in top departments suggests engagement issues.  
  - Training participation: Not provided, but stagnant tenure indicates skill gaps.  
- **Recommendations/Actions**:  
  - **Launch professional development budget**: Allocate funds for upskilling in high-turnover departments (e.g., Department 1).  
  - **Create mentorship program**: Pair top-tenured staff (e.g., 19+ years) with newer employees in critical roles.  
- **Reasoning**: Development opportunities reduce turnover by 20–30% (per SHRM data); mentorship leverages institutional knowledge to improve engagement.  

---

#### **3. Long-Term Plan (6+ Months)**  
- **Goal**: Foster a strong company culture and build a robust talent pipeline.  
- **Analysis**:  
  - Long-term growth: High tenure but no succession planning; gender imbalance limits diversity in leadership.  
  - Skill gaps: Stagnant roles (e.g., 41 employees in one title) may lack future-ready skills.  
- **Recommendations/Actions**:  
  - **Design leadership training**: Target high-potential employees in underrepresented groups (e.g., females) to address gender gaps.  
  - **Establish succession planning**: Document knowledge from 19+-year tenured staff (e.g., Engineering Managers) to prepare for retirements.  
- **Reasoning**: Leadership training builds inclusive pipelines; succession planning prevents knowledge loss, ensuring operational resilience.  

---  
**Final Note**: This report prioritizes equity, retention, and strategic planning. Immediate actions will mitigate legal and morale risks, while long-term investments will future-proof the organization.""");
  }
}
