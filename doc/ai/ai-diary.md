# AI diary

## 2026-10-25

- **Asked:** Review `scripts/trimgalore.sh` and list the 5 most important problems
  or improvements (no changes to the script yet); save the review to a file.
- **Files:** Created `doc/ai/q11_review-opus.txt` and this diary.
- **Findings:** Top issues: no program version reported (breaks the CLAUDE.md convention),
  no argument-count check, no input file checks, awkward `_val_1.fq.gz` output names,
  no `#SBATCH` directives. Minor: FastQC output isn't in its own subdir.
  Left out: whether the container includes FastQC and whether Apptainer bind paths
  cover `../garrigos` (neither was checked).

- **Asked:** Add a check to `scripts/trimgalore.sh` that both input FASTQ files
  exist, exiting with an informative error if either is missing.
- **Files:** Changed `scripts/trimgalore.sh`; created `doc/ai/q13_input-check.txt`.
- **Findings:** Added two `[[ ! -f ... ]]` checks (one per R1/R2) right after the
  initial logging and before `mkdir -p "$outdir"`, each printing a clear message
  to stderr and exiting 1.
