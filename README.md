```{=html}
```

# GA4 answers - Chandrima Das

------------------------------------------------------------------------

## Part A: Your project dir and Git repo

### 1: Create subdirs, and copy `CLAUDE.md` and a FastQC report

<!-- No command/output needed. -->

### 2: Initialize a Git repository, and commit your first files

<!-- No command/output needed here -- we check the repo directly. -->

------------------------------------------------------------------------

## Part B: A TrimGalore script --- without genAI

<!-- Reminder: no genAI in this Part! -->

### 3: A TrimGalore container, its help info, and three options

*Answer*: The container link (URI) is:[community.wave.seqera.io/library/trim-galore:2.3.0--2b255ff43100a747](oras://community.wave.seqera.io/library/trim-galore:2.3.0--dfb1fd48e19a6cf3)

Code to run `trim_galore --help` with the container:

``` bash
apptainer exec oras://community.wave.seqera.io/library/trim-galore:2.3.0--a56e49e832976df4 \
    trim_galore --help
```

<!-- You don't need to paste the TrimGalore help output -->

*Answer*: The option to indicate that the reads are paired-end: `--paired`

*Answer*: The option to set the output dir: `-o` or `--output_dir`

*Answer*: The option to run FastQC on the trimmed FASTQ files: `--fastqc`

### 4: Default thresholds

*Answer*: A) The default base quality score threshold: `20`

*Answer*: B) The default read length threshold: `20bp`

### touch scripts/trimgalore.sh5: Write the `trimgalore.sh` script

<!-- No need to paste the script: we'll look at scripts/trimgalore.sh directly. -->

### 6: Run the script for sample `S63`, and check the output files

Code to run the script:

``` bash
bash scripts/trimgalore.sh \
    ../garrigos/fastq/S63_R1.fastq.gz \
    ../garrigos/fastq/S63_R2.fastq.gz \
    results/trimgalore
```

<!-- You don't need to paste the TrimGalore logging output -->

Code to list the output files:

``` bash
ls results/trimgalore
```

The output of the command was:

```         
[carbohydrate21@p0220 GA4]$ ls results/trimgalore
S63_R1.fastq.gz_trimming_report.json  S63_R1_val_1_fastqc.html  S63_R1_val_1.fq.gz                    S63_R2.fastq.gz_trimming_report.txt  S63_R2_val_2_fastqc.zip
S63_R1.fastq.gz_trimming_report.txt   S63_R1_val_1_fastqc.zip   S63_R2.fastq.gz_trimming_report.json  S63_R2_val_2_fastqc.html             S63_R2_val_2.fq.gz
```

*Answer*: What each type of output file contains: The `.fq.gz` files contain the trimmed R1 and R2 sequencing reads. The `_trimming_report.txt` files contain human-readable summaries of the trimming results, while the `.json` files contain the trimming results in a structured format. The `_fastqc.html` files are the FastQC reports for viewing the quality of the trimmed reads, and the `_fastqc.zip` files contain the underlying FastQC result files.

<!-- If your script failed at first: describe the problem and your fix here. -->

### 7: Trimming results

*Answer*: Which adapter sequence TrimGalore looked for, and how it decided on this: Which adapter sequence TrimGalore looked for, and how it decided on this: TrimGalore looked for the Illumina adapter sequence `AGATCGGAAGAGC`. I did not specify an adapter, so TrimGalore auto-detected the adapter type from the reads. It detected the Illumina adapter, while the second-best match, Nextera, had no hits.

*Answer*: Percentage of reads with adapters in R1 and R2: `13.0%` in R1 and `10.1%` in R2.

*Answer*: In R1 and R2, were more bases removed by quality trimming or by adapter trimming?

More bases were removed by quality trimming in both files. In R1, 1,274,150 bases were removed by quality trimming compared with about 85,527 bases by adapter trimming. In R2, 1,283,793 bases were removed by quality trimming compared with about 60,540 bases by adapter trimming.

*Answer*: Percentage of read pairs that were removed: `7.4%`

### 8: Poly-G trimming

*Answer*: Did TrimGalore do poly-G trimming, and did you have to tell it to?

Yes. TrimGalore performed poly-G trimming automatically. I did not have to specify the `--poly_g` option because TrimGalore detected the poly-G pattern in the reads and enabled trimming on its own.

*Answer*: What TrimGalore concludes about the sequencing technology:

TrimGalore concluded that the reads are consistent with two-color Illumina sequencing chemistry, such as NovaSeq or NextSeq, because it detected poly-G tails characteristic of this type of sequencing.

*Answer*: Was more poly-G trimming done in R1 or R2? (Optional: any idea why?)

More poly-G trimming was done in R2. In R1, 11,919 reads (2.4%) had poly-G trimming, removing 90,248 bases. In R2, 43,397 reads (8.7%) were trimmed, removing 1,187,383 bases. One possible reason is that R2 reads often show poorer quality toward the end of the read, which could make the two-color sequencing artifact more apparent in R2.

### 9: Compare the FastQC reports before and after trimming

*Answer*: At least two differences between the reports, and whether things look better in terms of pass/warn/fail status:

After trimming, the quality toward the ends of the reads improved and the adapter content was reduced. The sequence length distribution also changed because trimming produced reads of different lengths instead of mostly the original read length. Overall, the trimmed reads look better in terms of FastQC pass/warn/fail status, although the sequence length distribution can still show a warning because the reads now have variable lengths after trimming.

*Answer*: Were the short reads with only `N`s removed? If so, was that due to the length threshold, or something else?

The short `N`-only reads appear to have been removed. This was not due to an N-content filter, because the TrimGalore report showed that 0 reads were removed for having too many `N` bases. Instead, the reads were trimmed and then became shorter than the 20-bp minimum length threshold, causing them to be removed.

*Answer*: Something you didn't expect or are confused about:git add scripts/trimgalore.sh git commit -m "Add TrimGalore script"

I did not expect the sequence length distribution to still show a warning after trimming. I initially thought trimming would make all of the FastQC results improve, but I realized that trimming makes the reads different lengths, so this warning does not necessarily mean the data quality became worse.

------------------------------------------------------------------------

## Part C: Bring in genAI

<!-- Export the conversations for questions 10, 11, 13, and 14 to `doc/ai`. -->

### 10: Sonnet reviews your script

*Answer*: Your prompt:

*Answer*: Claude's suggestions, and for each, whether you agree, disagree, or don't understand it, and why:

*Answer*: Was anything wrong, or in conflict with the course's practices? Did Claude refer to your `CLAUDE.md` conventions?

*Answer*: The estimated cost of this conversation (from `/usage`):

### 11: Opus reviews your script

*Answer*: The estimated cost of this conversation (from `/usage`):

*Answer*: Which suggestions did only one of the two models make?

*Answer*: Did either model claim something that you know is wrong?

*Answer*: Did either model check its claims, for example by running commands?

*Answer*: Did Opus's review change your mind about any of your answers to question 10?

*Answer*: How did the costs compare? Which review would you trust more, and why? Was the difference worth the difference in cost?

### 12: Run the script with a non-existent file

``` bash
# Your command:
```

The output of the command was:

```         
```

*Answer*: What happens, and at which point does the script stop?

### 13: Claude adds a check to your script

*Answer*: Your prompt:

``` bash
# Your command to test the updated script:
```

The output of the command was:

```         
```

*Answer*: Does it behave the way Claude claimed it would?

*Answer*: Given what you saw in question 12, how useful is this check?

### 14: Claude writes a loop

*Answer*: Your prompt:

The loop that Claude wrote:

``` bash
# Paste Claude's loop here
```

*Answer*: Does it run the script once per sample?

*Answer*: Does it get the correct R2 file for each R1 file?

*Answer*: Does it only run for the 7 `S6` samples?

*Answer*: Did you change the loop? If so, what did you change and why?

### 15: Test and run the loop

The loop with `echo`, to test it:

``` bash
# Your loop:
```

The output of the loop was:

```         
```

<!-- You don't need to paste the output of the loop that ran TrimGalore -->

``` bash
# Your command(s) to check the output files:
```

The output of the command(s) was:

```         
```

*Answer*: Are all 7 samples represented?

### 16: A summary command

*Answer*: Your prompt:

``` bash
# The command you got from Claude:
```

The output of the command was:

```         
```

*Answer*: Did the output look right? If not, what did you do?

*Answer*: Does the value for `S63` match your answer to question 7?

*Answer*: In your own words, how does the command work?

### 17: Document your genAI use

<!-- No command/output needed here -- we check your `doc/ai` dir in the repo directly. -->

### 18: Update your `CLAUDE.md`

*Answer*: What you added to `CLAUDE.md`, and why:

*Answer*: Did Claude follow the new instruction?

### 19: Reflection

*Answer*:

------------------------------------------------------------------------

## Part D: Publish your repo on GitHub

### 20: Create a GitHub repository, push, and create an Issue

<!-- No command/output needed here -- we check your GitHub repo directly. -->