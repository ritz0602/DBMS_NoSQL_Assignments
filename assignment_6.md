### Q1. Determine the highest normal form of this relation scheme

The relation scheme student Performance (StudentName, CourseNo, EnrollmentNo, Grade) has the following functional dependencies:

- StudentName, courseNo → grade
- EnrollmentNo, courseNo → grade
- StudentName →EnrollmentNo
- EnrollmentNo →StudentName

### Solution:

- Looking at these dependencies, we can identify the following:

  **Candidate Keys: {StudentName, CourseNo} and {EnrollmentNo, CourseNo}**

  **Prime Attributes: {StudentName, EnrollmentNo, CourseNo}**

  **Non-Prime Attributes: {Grade}**

  To determine the highest normal form, we need to check for any violations of the normal form rules.

  **First Normal Form (1NF):**

  The relation scheme has a flat structure with atomic values.
  Each attribute contains only single values.
  There are no repeating groups or arrays.

  **Second Normal Form (2NF):**

  The relation scheme should satisfy 1NF.
  There should be no partial dependencies, meaning no non-prime attribute is functionally dependent on only a part of the primary key.
  In the given relation scheme, none of the functional dependencies violate the 2NF.

  **Third Normal Form (3NF):**

  The relation scheme should satisfy 2NF.
  There should be no transitive dependencies. We can say, for every non-trivial dependency: X -> Y,
  either X should be a super key or Y should be a prime attribute.

  **Dependency 1: StudentName, CourseNo → Grade**

  In the above dependency the LHS is a super key.

  **Dependency 2: EnrollmentNo, CourseNo → Grade**

  In the above dependency the LHS is a super key.

  **Dependency 3: StudentName → EnrollmentNo**

  In the above dependency the RHS prime attribute.

  **Dependency 4: EnrollmentNo → StudentName**

  In the above dependency the RHS is a prime attribute.

  Since there are no transitive dependencies or violations of the 3NF, we can conclude that the given relation scheme is already in the highest normal form, which is the **3rd Normal Form (3NF)**.

### Q2. Suppose you are given a relation R= (A, B, C, D, E ) with the following functional dependencies: {CE →D, D→B, C →A}

- a. Find all candidate keys.
- b. Identify the best normal form that R satisfies (1NF, 2NF, 3NF, or BCNF).
- c. If the relation is not in BCNF, decompose it until it becomes BCNF. At each step, identify a
  new relation, decompose and re-compute the keys and the normal forms they satisfy.

### Solution:

- a. Candidate Key: {CE}
- b. The relation is in **1NF** because the attributes are atomic, and the dependency, C → A does not follow rules of 2NF.
- c. The relation R can be broken into R1 = (AC), R2 = (BCDE)

  R1 = (AC): C → A

  The relation, R1 has keys as {C} and is in BCNF

  The relation R2 = (BCDE): CE → D, D → B, has keys as {CE} and is in 2NF.

  So, we have to further decompose R2.

  R2 is decomposed into:

  R21 = (BD): D → B, which has keys as {D}

  R22 = (CDE) which has keys as {CE}

  Both the above relations are in BCNF.

  Therefore, the relation R has to be decomposed into **R1 = (AC), R21 = (BD), R22 = (CDE)** to be in BCNF.

### Q3. You are given the following set F of functional dependencies for relation R(A, B, C, D, E, F): F = {ABC → D, ABD→E,CD→F,CDF →B,BF →D}

- a. Find all keys of R based on these functional dependencies.
- b. Is this relation in Boyce-Codd Normal Form? Is it 3NF? Explain your answers.

### Solution:

- a. In the given relation, the attributs A and C are not present in the RHS of any functional dependency, So these two will be present in all the candidate keys. So we try to combine different combinations of other attributes to AC to find all the candidate keys.

  We can see that the combinations ABC and ADC are candidate keys.

- b. The relation is **not in BCNF**, bacuase in no functional dependencies other than ABC → D, the LHS is a superkey.

  Also, it is **not in 3NF** as well bacause of the functional dependencies, ABD → E and CD → F, as in neither of them the LHS is a super key OR the RHS is a prime attribute (part of any candidate key).

### Q4. Write the advantages and disadvantages of normalization.

### Ans:

#### Advantages of Normalization:

1. **Data Integrity:** Normalization helps maintain data integrity by minimizing data redundancy and inconsistency. It ensures that each piece of data is stored only once, reducing the chances of inconsistencies or conflicting information.

2. **Efficient Storage:** Normalization reduces data duplication, leading to more efficient storage utilization. By eliminating redundant data, the overall database size decreases, resulting in optimized disk space usage.

3. **Improved Performance:** Normalization can improve query performance by reducing the number of joins required to retrieve data. Smaller tables with well-defined relationships can be accessed more efficiently, leading to faster query execution times.

4. **Flexibility and Adaptability:** Normalization makes the database more flexible and adaptable to changes. As new requirements arise, it becomes easier to modify and extend the database schema without impacting existing data or risking data inconsistencies.

#### Disadvantages of Normalization:

1. **Increased Complexity:** Normalization can lead to increased complexity in the database design. Breaking down a table into multiple smaller tables creates relationships that must be managed correctly. This complexity can make the database design and maintenance more challenging.

2. **Join Operations:** While normalization can improve query performance in some cases, it can also introduce the need for join operations. Joining multiple tables to retrieve data can be computationally expensive, especially for complex queries involving multiple joins.

3. **Reduced Read Performance:** While query performance may improve in some cases, read performance may suffer in others. Normalization often requires multiple joins to retrieve complete data, which can impact read performance, particularly for large and complex databases.

### Q5. Determine the decomposition.

- Consider the schema R = (S T U V) and the dependencies S → T, T → U, U → V, and V → S.
  Let R = (R1 and R2) be a decomposition such that R1 ∩ R2 ≠ ∅.

### Solution:

- R1∩R2 ≠ Ø means there is a standard attribute in R1 and R2.

  If we choose a decomposition where R1 = (S, T, U) and R2 = (U, V), we can say that decomposition is lossless because familiar attribute is U and LHS of each FDs are candidate key, therefore it's in 3NF.
