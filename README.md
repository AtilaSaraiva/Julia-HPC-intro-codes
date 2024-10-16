# Introductory Julia codes for SLURM

These codes should help you make use julia for SLURM jobs on the HPC cluster you have access to.

First of all replace the email token in the sbatch scripts with yours. You can use this command if you want:
```
find ./ -type f -exec sed -i -e 's/email@token/<youremail>/g' {} \;
```
replace `<youremail>` with your email.

Second of all replace the SLURM account token in the sbatch scripts with yours. Again, you can use the following command:
```
find ./ -type f -exec sed -i -e 's/account-token/<your-account>/g' {} \;
```

Also, make sure you load julia and precompile environment before submitting jobs.
