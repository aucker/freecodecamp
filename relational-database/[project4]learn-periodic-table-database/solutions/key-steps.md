## Some key steps in this project
* You should capitalize the first letter of all the `symbol` values in the `elements` table. Be careful to only capitalize the letter and not change any others
    * to captilize all the column, refer to [SQL: capitalize first letter only [duplicate]](https://stackoverflow.com/questions/15290754/sql-capitalize-first-letter-only)


* Remove the trailing zeros after the decimals from each row of the `atomic_mass`.
```sql
// first change the datatype: from numeric to decimal
ALTER TABLE properties ALTER COLUMN atomic_mass SET decimal;
// then use `::` to remove the trailing zeros
UPDATE properties SET atomic_mass=atomic_mass::real;
```