# Collaborating on GitHub from RStudio

Companion to Lecture 5.4. Gentzkow and Shapiro (Section 8) recommend that each
research task have an owner, a deliverable, and a written record of decisions,
kept somewhere a coauthor can find it later. GitHub keeps that record:
**issues** define the task, **branches** hold the work in progress, and
**pull requests** let a coauthor review the work before it joins `main`.

## 1. Open an issue for the task

On GitHub: **Issues > New issue > Research task**. The template asks for:

- the deliverable,
- one owner (**Assignees**),
- inputs and dependencies,
- the conditions for completion,
- decisions and the reasons for them.

GitHub numbers each issue, for example `#3`. Mention the number in commit
messages ("Add growing degree days, closes #3") and GitHub links the commit to
the issue; `closes #3` closes the issue when the work merges into `main`.

## 2. Work on a branch

In the RStudio Git pane, select the **New Branch** button (two purple boxes),
name the branch after the task (`add-gdd`), and leave **Sync branch with
remote** checked. The menu at the right of the Git pane now shows the new
branch.

Commit as usual. **Push** sends the branch to GitHub and leaves `main` as it
was.

## 3. Open a pull request

GitHub shows a yellow banner, *add-gdd had recent pushes*. Select **Compare &
pull request**, describe what changed and why, link the issue, and request a
reviewer.

The reviewer reads the **Files changed** tab, comments on specific lines, and
either requests changes or approves. Further commits pushed to the branch
appear in the same pull request.

## 4. Merge and clean up

After approval, select **Merge pull request** on GitHub. Then in RStudio:

1. Switch to `main` with the branch menu.
2. **Pull** to bring in the merged work.
3. Delete the branch on GitHub (button on the merged pull request).

This repository's history includes one merged branch, `add-daily-panel`.
**History** in RStudio, or *Commits* on GitHub, shows where it split from
`main` and where it merged back.

## 5. Resolve a conflict

When two branches change the same lines, Git pauses the merge and marks the
file:

```text
<<<<<<< HEAD
heat_threshold_c <- 35
=======
heat_threshold_c <- 32
>>>>>>> add-gdd
```

1. Read both versions and the issue that motivated each one.
2. Edit the file to the agreed result and delete the three marker lines.
3. Run the code that depends on the change.
4. Stage the file and commit, recording the decision in the commit message.

The version to keep is the one that matches the agreed decision, whichever
branch it came from.

## Collaborators and forks

- **Shared repository:** the owner adds teammates under *Settings >
  Collaborators*, and everyone pushes branches to the same repository. Use
  this for a coauthored paper.
- **Fork:** each person works in a copy under their own account and opens pull
  requests back to the original. This course uses forks of the demo; see
  [setup-rstudio.md](setup-rstudio.md) for forks and templates.

## Exercise

1. In your fork of this repository, open an issue: *Add a weekly summary
   table*.
2. Create a branch, add the table to `code/06_outputs.R`, run `run_all.R`, and
   commit with `closes #` followed by your issue's number.
3. Push and open a pull request. GitHub proposes the original repository as
   the base; change **base repository** to your fork. Ask your partner to
   review it, then merge.
4. Your partner clones your fork and runs `run_all.R`. Note the first step
   where they need your help, and open an issue for it.
