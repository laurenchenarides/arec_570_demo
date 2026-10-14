# Collaborating on GitHub from RStudio

Companion to Lecture 5.4. Gentzkow and Shapiro (Section 8) argue that research
tasks need an owner, a deliverable, and a record of decisions, and that email
is a poor place to keep them. GitHub provides that record: **issues** define
the task, **branches** isolate the work, and **pull requests** review it
before it reaches `main`.

## 1. Open an issue for the task

On GitHub: **Issues > New issue > Research task**. The template asks for:

- the deliverable,
- one owner (**Assignees**),
- inputs and dependencies,
- what "done" means,
- a place for decisions and the reasons for them.

Each issue gets a number, such as `#3`. Mention it in commit messages
("Add growing degree days, closes #3") and GitHub links the two; `closes #3`
closes the issue when the work merges into `main`.

## 2. Work on a branch

In the RStudio Git pane, select the **New Branch** button (two purple boxes),
name the branch after the task (`add-gdd`), and keep **Sync branch with
remote** checked. You are now on the new branch; the menu at the right of the
Git pane shows it.

Commit as usual. **Push** sends the branch to GitHub; `main` is unchanged.

## 3. Open a pull request

GitHub shows a yellow banner, *add-gdd had recent pushes*. Select **Compare &
pull request**, describe what changed and why, link the issue, and request a
reviewer.

A reviewer reads the **Files changed** tab, comments on specific lines, and
either requests changes or approves. Further commits pushed to the branch
appear in the same pull request.

## 4. Merge and clean up

After approval, select **Merge pull request** on GitHub. Then in RStudio:

1. Switch to `main` with the branch menu.
2. **Pull** to bring in the merged work.
3. Delete the old branch on GitHub (button on the merged pull request).

This repository's history includes one merged branch, `add-daily-panel`. Look
at it in **History**, or on GitHub under *Commits*.

## 5. When changes conflict

If two branches change the same lines, Git stops and marks the file:

```text
<<<<<<< HEAD
heat_threshold_c <- 35
=======
heat_threshold_c <- 32
>>>>>>> add-gdd
```

1. Read both versions and understand why each was made. Check the issue.
2. Edit the file to the agreed result and delete the three marker lines.
3. Run the code that depends on it.
4. Stage the file and commit. The commit message should record the decision.

Do not choose a version only because it is newer.

## Collaborators and forks

- **Shared repository:** the owner adds teammates under *Settings >
  Collaborators*. Everyone pushes branches to the same repository.
- **Fork:** you work in your own copy and open pull requests back to the
  original. Use this for this course's demo.

## Exercise

1. In your fork of this repository, open an issue: *Add a weekly summary
   table*.
2. Create a branch, add the table to `code/06_outputs.R`, run `run_all.R`, and
   commit with `closes #1` (use your issue's number).
3. Push, open a pull request **within your fork**, ask your partner to review
   it, and merge.
4. Your partner clones your fork and runs `run_all.R`. Note the first point
   where they need your help, and open an issue for it.
