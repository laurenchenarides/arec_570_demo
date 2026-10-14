# Everyday Git in RStudio

Companion to Lecture 5.3. Complete [setup-rstudio.md](setup-rstudio.md) first.

## The Git pane

The **Git** tab (upper right) lists every file that differs from the last
commit. The status column shows what happened to each file:

| Status | Meaning |
|---|---|
| **M** | Modified since the last commit |
| **A** | Added: new file, staged for its first commit |
| **D** | Deleted |
| **R** | Renamed or moved |
| **?** | Untracked: a file Git has not yet recorded |

Buttons along the top: **Diff** and **Commit** open the review window; **Pull**
(blue down arrow) brings in changes from GitHub; **Push** (green up arrow)
sends your commits to GitHub; **History** (clock) lists past commits; the
branch menu on the right shows the current branch.

## The everyday loop

1. **Pull** before you start, so you build on the latest version.
2. Make one coherent change, such as fixing one variable definition or adding
   one script.
3. Select **Diff** and read each changed line (red lines were removed, green
   lines were added).
4. Check **Staged** for the files that belong to this change.
5. Write a commit message, then select **Commit**.
6. **Push** to copy your commits to GitHub, at least once per work session.

Each commit is a checkpoint you can return to. Commit when a step works, or
when you finish a step you would want to explain to a coauthor.

## Commit messages

Write the first line as an instruction that describes the commit, in about 50
characters, for example "Add daily weather retrieval." When the reason for the
change is not obvious, add a blank line and a short paragraph. This matters
most when a change alters the sample or the meaning of a variable.

| Vague | Specific |
|---|---|
| `updates` | `Code suppressed ACS estimates as missing` |
| `fixed bug` | `Keep FIPS codes as text to preserve leading zeros` |
| `final version` | `Restrict sample to the April-September growing season` |

The **History** button (or *Commits* on GitHub) shows more examples from this
repository.

## Keep files out of the repository

`.gitignore` lists files that Git leaves out of the Git pane. This project
excludes:

- `.Renviron`: API keys and other credentials
- `data/raw/` and `data/derived/`: large, restricted, or rebuildable data
- RStudio session files (`.Rproj.user`, `.Rhistory`, `.RData`)

`.gitignore` applies to files Git has not yet tracked. To stop tracking a file
that was already committed, run this in the **Terminal** tab and then commit:

```bash
git rm --cached path/to/file
```

If the file contained a password or key, revoke the key with the provider,
because earlier commits still contain it.

## Undo

| Situation | In RStudio |
|---|---|
| Discard uncommitted edits to a file | Select the file in **Diff**, then **Revert** |
| Unstage a file | Uncheck **Staged** |
| See an earlier version | **History**, select the commit, then **View file** |
| Reword the last commit before pushing | Check **Amend previous commit** in the Commit window |

## Open a stage of this project

A tag marks each lecture's version of this project. In the **Terminal**:

```bash
git tag                          # list the stages
git switch --detach 5.2-retrieve # open the Lecture 5.2 version (read only)
git switch main                  # return to the current version
```

## Terminal equivalents

Each RStudio button runs a Git command. The same commands work in any terminal
and in VS Code.

| RStudio | Terminal |
|---|---|
| Git pane status | `git status` |
| Diff | `git diff` |
| Staged checkbox | `git add file` |
| Commit | `git commit -m "message"` |
| History | `git log --oneline` |
| Pull / Push | `git pull` / `git push` |
