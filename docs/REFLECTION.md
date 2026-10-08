# Reflection (C2)

**Student:** Gasana (20251SEN096)
**Course:** INSY 8311 – Database Development with PL/SQL

## 1. GOTO Statements

The `GOTO` statement moves control to a label such as `<<label_name>>`. In A1 and A2, I used it to jump to the code for each case. A label must be followed by an executable statement, so I used `NULL;` when needed.

## 2. Illegal GOTO

In A3, the program failed with error **PLS-00375** because the `GOTO` tried to jump into an `IF` block. A `GOTO` cannot jump into an `IF`, a loop or a sub-block, but it can jump out of them. I fixed the error by moving the label outside the `IF` block.

## 3. GOTO vs Structured Code

In A4, I rewrote A1 and A2 with `CASE` and `IF/ELSIF`. The output was the same, but the code was shorter and easier to read. For this reason, structured code is usually better than `GOTO`. I also wrote C1 with `IF/ELSIF` because it was clearer.

## 4. Functions

A function always returns one value. This makes it possible to use functions directly in SQL, as shown in B5. Functions also allow the same logic to be reused; for example, C1 reuses B1, B3 and B4.

## 5. Exception Handling

In B4, when a department does not exist, `NO_DATA_FOUND` is handled and the function returns `'Unknown'`. In C1, exceptions are handled so the function returns a clear message instead of an error.

## 6. Challenges

- Understanding which `GOTO` jumps are legal.
- Handling `NULL` values and missing data correctly.
- Fixing compilation errors while creating the functions.
