# Karma Dog Training Operations Efficiency Dashboard

## Project Overview

This project analyzes operational efficiency for a dog training business using SQL and Tableau to evaluate trainer workload, cancellation trends, service demand, revenue concentration, and training quality outcomes.

The goal was to identify operational bottlenecks, reduce trainer dependency, improve scheduling efficiency, and uncover revenue optimization opportunities.

---

## Business Problem

As service volume scales, leadership needs visibility into trainer performance, client retention patterns, and operational inefficiencies.

This dashboard was built to answer key business questions:

- Which trainers are carrying the highest workload?
- Which trainers have the highest cancellation risk?
- Which services generate the most demand and revenue?
- Does higher trainer workload correlate with increased cancellations?
- Which trainers maintain strong outcome quality under heavier workloads?
- Which referral sources generate the highest repeat client value?

---

## Tools Used

- SQL (SQLite)
- Tableau
- Excel

---

## SQL Analysis

Before building the dashboard, SQL was used to explore operational performance, validate business hypotheses, and identify patterns across trainers, services, and client behavior.

Analysis included:

- Trainer workload, revenue, cancellations, and satisfaction metrics
- Location utilization and revenue efficiency
- Peak booking day trends
- Service type demand and performance
- Client retention by referral source
- Hypothesis testing on trainer workload and outcome quality

All SQL queries and result screenshots are included in this repository.

---

## Dashboard KPIs

- **Total Revenue:** $734,600
- **Total Sessions:** 2,500
- **Cancellation Rate:** 15.5%
- **Average Outcome Score:** 7.36

---

## Dashboard Components

### 1. Trainer Workload & Revenue Contribution
Analyzes workload distribution across trainers to identify high-volume dependency and operational imbalance.

### 2. Cancellation Rate by Trainer
Highlights trainers with elevated cancellation rates to surface operational risk.

### 3. Service Demand & Revenue Contribution
Measures service demand concentration and identifies the strongest revenue-generating offerings.

### 4. Trainer Workload vs Cancellation Risk
A multi-variable scatter plot testing whether increased workload correlates with higher cancellation risk, layered with revenue contribution and outcome quality.

---

## Key Insights

- Sarah Mitchell handled the highest trainer workload, creating strong operational dependency.
- Olivia Reed showed the highest cancellation rate, representing the largest trainer-level operational risk.
- Private Training generated the highest service demand and strongest revenue concentration.
- High-volume trainers did not consistently maintain the strongest outcome scores.
- Workload imbalance appears to contribute to elevated cancellation risk across several trainers.
- Referral-based clients demonstrated exceptionally high repeat engagement and lifetime value.

---

## Business Recommendations

- Rebalance trainer allocation to reduce over-reliance on top-performing trainers.
- Investigate high-cancellation trainers for scheduling inefficiencies, client mismatches, or process gaps.
- Expand Private Training capacity to support the highest-performing revenue stream.
- Use top-performing trainers as internal benchmarks for coaching and process standardization.
- Monitor workload-to-quality ratios regularly to improve long-term client retention and operational efficiency.

---

## Live Dashboard

View the live Tableau dashboard here:

[Karma Dog Training Operations Efficiency Dashboard](https://public.tableau.com/app/profile/rebecca.scharf/viz/KarmaDogTrainingOperationsEfficiencyDashboard/KarmaDogTrainingOperationsEfficiencyDashboard?publish=yes)

---

## Dashboard Preview

![Dashboard Overview](screenshots/dashboard_overview.png)
