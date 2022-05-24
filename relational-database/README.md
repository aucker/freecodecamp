## Relational Database:rocket:
I'm now learning PostgreSQL. There are some of my solutions. And I got a [certificate](https://www.freecodecamp.org/certification/aucker/relational-database-v8).

Through this project, I'm now **familiar with** `PostgreSQL`, `shell script`, and `git`.

* remove the first commit [refernce](https://stackoverflow.com/questions/10911317/how-to-remove-the-first-commit-in-git)
```shell
git update-ref -d HEAD
```
* delete commits from the branch[reference](https://stackoverflow.com/questions/1338728/delete-commits-from-a-branch-in-git)
```
git reset --hard HEAD~1
```
while `HEAD~1` means the commit before head
or use `git log` to find the <sha1-commit-id>, then 
```
git reset --hard <sha1-commit-id>
```

* In `Shell Script`, the `Function` must be declared before you call it. **MIND THE ORDER.** Oh god:(, just unlike the modern language like `Rust`:crab:.