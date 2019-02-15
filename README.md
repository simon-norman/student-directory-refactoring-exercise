# Refactoring student directory

The task is to refactor the student directory from a single file (no classes) into a set of classes, and generally refactor the code. 

The single file to be refactored can be found here: https://github.com/neoeno/student_directory_refactoring_exercise/tree/master/example_2/lib

## My approach

Whilst I didn't finish the exercise, I refactored a very large portion of it into a number of individual classes with tests. My approach was as follows:

1. Understand the app's functionality by running it in IRB

2. Creating an initial domain model of the app, without going into too much detail

3. Picked a simple class from the model to work on first, following the TDD approach for that class.

4. Once done, moving that class into the main app and testing it again in IRB. Once tests successful, removing any redundant code from main app.

5. Further develop domain model if necessary and continue.