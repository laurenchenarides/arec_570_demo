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
| **?** | Untracked: Git has never recorded this file |

Buttons along the top: **Diff** and **Commit** open the review window; **Pull**
(blue down arrow) brings in changes from GitHub; **Push** (green up arrow)
sends your commits to GitHub; **History** (clock) shows every past commit; the
branch menu on the right shows which branch you are on.

## The everyday loop

1. **Pull** before you start, so you build on the latest version.
2. Make one coherent change: fix one variable definition, add one script.
3. Select **Diff**. Read every changed line (red removed, green added).
4. Check **Staged** for the files that belong to this change, and only those.
5. Write a commit message, then select **Commit**.
6. **Push** when you want the commits on GitHub (at least once per session).

A commit is a checkpoint you can return to. Commit when something works or
when you finish a step you would want to explain.

## Commit messages

The first line says what the commit does, in about 50 characters, written as a
command: "Add daily weather retrieval," not "added stuff." Add a blank line
and a short paragraph when the reason is not obvious, especially when the
change affects the sample or the meaning of a variable.

| Weak | Better |
|---|---|
| `updates` | `Treat suppressed ACS estimates as missing, not zero` |
| `fixed bug` | `Keep FIPS codes as text so leading zeros survive` |
| `final version` | `Restrict sample to the April-September growing season` |

Browse this repository's history (**History** button, or *Commits* on GitHub)
for more examples.

## Keep things out of the repository

`.gitignore` lists files Git should never offer to stage. This project ignores:

- `.Renviron`: API keys and other credentials
- `data/raw/` and `data/derived/`: large, restricted, or rebuildable data
- RStudio's own session files (`.Rproj.user`, `.Rhistory`, `.RData`)

`.gitignore` only affects files Git has never tracked. If you committed a file
by mistake, stop tracking it in the **Terminal** tab, then commit:

```bash
git rm --cached path/to/file
```

If the file contained a password or key, revoke the key with the provider.
The old value remains in the history.

## Undo

| Situation | In RStudio |
|---|---|
| Discard uncommitted edits to a file | Select the file in **Diff**, then **Revert** |
| Unstage a file | Uncheck **Staged** |
| See an earlier version | **History**, select the commit, then **View file** |
| Fix the message of the last commit (not yet pushed) | Check **Amend previous commit** in the Commit window |

## Look at a stage of this project

Each lecture's version of this project is tagged. In the **Terminal**:

```bash
git tag                          # list the stages
git switch --detach 5.2-retrieve # look around (read only)
git switch main                  # come back
```

## Terminal equivalents

RStudio's buttons run ordinary Git commands. The same commands work in any
terminal and in VS Code.

| RStudio | Terminal |
|---|---|
| Git pane status | `git status` |
| Diff | `git diff` |
| Staged checkbox | `git add file` |
| Commit | `git commit -m "message"` |
| History | `git log --oneline` |
| Pull / Push | `git pull` / `git push` |
