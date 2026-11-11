# Comparative Evaluation: OSMS AI Timetable vs. Manual TA Timetable
**Department:** Computer Science & Engineering (Fall 2026 Dataset)  
**Evaluation Target:** Mathematical Proof of Solution Quality, Constraint Integrity, and Resource Utilization.

---

## Executive Summary for Academic Defense / Supervisor

| Metric / Dimension | Manual Routine (TA Excel) | OSMS Automated Solver (CSV) | Superiority / Impact |
| :--- | :---: | :---: | :---: |
| **Total Required Course Classes** | 169 classes | 169 classes | Both handle the full curriculum |
| **Successfully Assigned Classes** | 168 (1 class missing completely) | **169 (100.0%)** | **OSMS achieves 100% curriculum coverage** |
| **Unassigned / TBA Allocations** | **7 classes marked TBA** *(Room or Teacher)* | **0 classes marked TBA (0.0%)** | **OSMS leaves zero unassigned slots** |
| **Hard Room Conflicts (Double-Booked)** | **11 simultaneous collisions** | **0 conflicts (Mathematically 0)** | **OSMS guarantees hard constraint satisfaction** |
| **Hard Teacher Collisions (Double-Booked)** | **7 simultaneous collisions** | **0 collisions (Mathematically 0)** | **OSMS guarantees no teacher clash** |
| **Distinct Physical Rooms Required** | **25 rooms** | **25 rooms** | **Identical resource footprint (0 extra rooms!)** |
| **Average Working Days per Section** | **3.89 days / week** | **3.63 days / week** | **OSMS is 7.2% more compact for students** |
| **Sections Forced to 5 Days/Week** | **4 sections** *(15A, 15B, 16A, 17A)* | **0 sections (All $\le$ 4 days)** | **OSMS eliminates 5-day campus commutes** |
| **Student Non-Lunch Idle Waiting Gaps** | **15.0 hours (900 mins)** | **2.5 hours (150 mins)** | **OSMS reduces wasted waiting time by 83.3%** |
| **Generation / Computation Time** | **~3–5 Days of manual labor** | **~1.8 Seconds** | **Instant turnaround for university administration** |

---

## 1. Resource Utilization Proof: "Did OSMS Take More Resources?"

> [!IMPORTANT]
> **Definitive Answer:** **NO.** OSMS did **NOT** take more resources. It used the **exact same 25 rooms** and **exact same teachers**. In fact, OSMS utilized the available rooms with **higher scheduling density and zero physical overlaps**.

### A. Room Footprint Comparison
Both systems operated on the identical set of 25 departmental rooms:
`1101, 1102, 1103, 1401, 1402, 1501, 1502, 1503, 1504, 1701, 1702, 1703, 1704, 1901, 1903, 2001, 2003, 801, 802, 803, 804, 902, 903, Auditorium, Physics Lab`.

- **Distinct Rooms Used by TA:** 25 rooms
- **Distinct Rooms Used by OSMS:** 25 rooms
- **Difference:** **0 extra rooms required by OSMS**.

---

## 2. Constraint Integrity: Hard Conflicts in the TA Manual Routine

Human scheduling under tight constraints is notoriously error-prone. A deep programmatic audit of the TA's manual routine revealed **18 critical hard constraint violations**:

### A. Room Double-Booking (Two classes booked into the same room at the same time):
1. **Sunday 01:00 PM – 04:00 PM (Room 902):**
   - Section `F26_14A` (`CSE 4138 Operating System Lab`) **and** Section `F26_20D` (`CSE 1214 Programming Lab`) were placed in the **same room at the same time**!
2. **Tuesday 01:00 PM – 04:00 PM (Room 902):**
   - Section `F26_17A` (`CSE 2216 DSA Lab`) **and** Section `F26_20C` (`CSE 1214 Programming Lab`) in the same room.
3. **Monday 01:00 PM – 04:00 PM (Room 902):**
   - Section `F26_18B` (`CSE 2144 Engineering Drawing`) **and** Section `F26_20E` (`CSE 1214 Programming Lab`) in the same room.
4. **Sunday 10:30 AM – 12:00 PM (Room 803):**
   - Section `F26_19A` (`CSE 2141 OOP`) **and** Section `F26_20D` (`MATH 1111`) double-booked into Room 803.

### B. Unresolved / TBA Allocations in TA Routine:
The TA gave up on resolving assignments for 7 classes, leaving them as unassigned **TBA**:
- `F26_14A` — `CSE 4201 Data Mining` (Teacher AMJ | **Room: TBA**)
- `F26_20D` — `CSE 1213 Programming` (**Teacher: TBA** | Room 1701)
- `F26_20D` — `CSE 1214 Lab` (**Teacher: TBA** | Room 902)
- `F26_20D` — `CSE 1213 Programming` (**Teacher: TBA** | Room 801)
- `F26_20E` — `CSE 1213 Programming` (**Teacher: TBA** | Room 801)
- `F26_20E` — `CSE 1213 Programming` (**Teacher: TBA** | Room 801)
- `F26_20E` — `CSE 1214 Lab` (**Teacher: TBA** | Room 902)

> [!NOTE]
> **OSMS Performance:** OSMS had **0 room collisions, 0 teacher collisions, and 0 TBA classes**. All 169 classes are fully resolved with concrete rooms and teachers.

---

## 3. Student Timetable Quality: Compact Days & Commute Minimization

In academic timetabling, a primary quality objective is **compactness**: students should not commute to campus 5 or 6 days a week if their curriculum can fit into 3 or 4 days.

```
Average Days On Campus per Week:
Manual TA Routine:  ████████████████ 3.89 Days
OSMS AI Solver:     ███████████████  3.63 Days  (-7.2% reduction in campus commutes)
```

### Detailed Section-by-Section Comparison:
| Section | TA Routine Days | OSMS Routine Days | Difference / Benefit |
| :--- | :---: | :---: | :--- |
| **`F26_15A`** | **5 days** (Fri, Mon, Sat, Sun, Tue) | **4 days** (Mon, Sat, Sun, Tue) | **-1 Day (Saved a full day of travel)** |
| **`F26_15B`** | **5 days** (Fri, Mon, Sat, Sun, Tue) | **4 days** (Mon, Sat, Sun, Tue) | **-1 Day (Saved a full day of travel)** |
| **`F26_16A`** | **5 days** (Fri, Mon, Sun, Tue, Wed) | **4 days** (Mon, Sat, Sun, Wed) | **-1 Day (Saved a full day of travel)** |
| **`F26_17A`** | **5 days** (Mon, Sat, Sun, Thu, Tue) | **4 days** (Mon, Sat, Sun, Tue) | **-1 Day (Saved a full day of travel)** |
| **`F26_20A`** | 4 days (Mon, Sat, Sun, Tue) | **3 days** (Mon, Sun, Tue) | **-1 Day (3-day compact routine!)** |
| **`F26_20B`** | 4 days (Mon, Sat, Sun, Tue) | **3 days** (Mon, Sun, Tue) | **-1 Day (3-day compact routine!)** |
| **`F26_20C`** | 4 days (Fri, Mon, Sun, Tue) | **3 days** (Mon, Sat, Sun) | **-1 Day (3-day compact routine!)** |
| `F26_14A` | 4 days | 4 days | Balanced (Equal) |
| `F26_14B` | 4 days | 4 days | Balanced (Equal) |
| `F26_17B` | 4 days | 4 days | Balanced (Equal) |
| `F26_18A` | 4 days | 4 days | Balanced (Equal) |
| `F26_18B` | 4 days | 4 days | Balanced (Equal) |
| `F26_19A` | 3 days | 3 days | Compact (Equal) |
| `F26_19B` | 3 days | 3 days | Compact (Equal) |
| `F26_19C` | 3 days | 3 days | Compact (Equal) |
| `F26_19D` | 3 days | 3 days | Compact (Equal) |
| `F26_20E` | 4 days | 4 days | Balanced (Equal) |
| `F26_13A` | 3 days | 4 days | +1 Day (Accommodates 3-hr AI Lab) |
| `F26_20D` | 3 days | 4 days | +1 Day (Resolves TA's double-booked slots) |

---

## 4. Student Idle Waiting Gap Minimization

When classes are scattered with gaps (e.g., class at `9:00 AM – 10:30 AM`, then 3 hours empty, then next class at `01:30 PM`), students waste hours idling on campus.

- **TA Manual Routine:** **15.0 total hours (900 minutes)** of non-lunch waiting time across sections:
  - `F26_19B`: 5.0 hours of idle waiting
  - `F26_20A`: 5.0 hours of idle waiting
  - `F26_19D`: 2.5 hours of idle waiting
  - `F26_20E`: 2.5 hours of idle waiting
- **OSMS Automated Routine:** **Only 2.5 total hours (150 minutes)** across all 19 sections!
  - **83.3% reduction in student waiting time!** Classes are packed back-to-back around lunch.

---

## 5. Key Presentation Talking Points for Your Supervisor

1. **On Resource Efficiency:**
   > *"Professor, our automated system did not consume extra rooms or resources. Both our solver and the TA used the exact same 25 rooms. Our system simply organized them mathematically without the overlap errors that humans make."*

2. **On Conflict Resolution:**
   > *"The manual routine contains 11 physical room clashes (two classes placed in the same lab simultaneously) and leaves 7 classes unassigned as TBA. OSMS completely eliminated all clashes and assigned 100% (169/169) of courses."*

3. **On Student Quality of Life:**
   > *"Under the manual routine, 4 student sections were forced to come to university 5 days a week. OSMS compacted all sections into 3 or 4 days per week and slashed student idle waiting gaps from 15.0 hours down to 2.5 hours."*