# Steps

The file 'run_analysis.R` execute 5 steps to clean up the data.

* First, I read all the files, rename the cols and make a merge with training_set and test_set.
* Second, I picked up only the columns with the mean and standard deviation measures.
* Third, I merged the result with the activities names.
* Fourth, I corrected the name of the columns.
* Finally, I calculated the average of the columns and generated the tidy data.

# Variables

* `activity_labels`, `features`, `test_label`, `test_set`, `test_subject`, `training_set`, `training_label` and `training_subject` contain the data from the downloaded files.
* `final_set`, `final_set_without_activityType` contain the merge of previous datasets to further analysis.
* `tidy_set` contains a clean up data.
