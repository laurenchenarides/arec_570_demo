# Supplement: the same workflow in VS Code

RStudio is the course default. Many economists also work in Python, Stata,
SQL, or LaTeX, or on remote servers, and VS Code supports all of these in one
editor. Git stores its history inside the project folder, so a repository
created in RStudio opens in VS Code with the same commits, branches, and tags.

[Positron](https://positron.posit.co/), Posit's newer editor, is built on the
same foundation as VS Code and has a similar Source Control view.

## Setup

1. Install VS Code: <https://code.visualstudio.com/>
2. In the Extensions view (`Ctrl+Shift+X`), install:
   - **R** (REditorSupport): run R code, view plots and data
   - **GitHub Pull Requests**: review and merge pull requests inside VS Code
3. In R, install the language server once: `install.packages("languageserver")`
4. VS Code uses the Git installation from [setup-rstudio.md](setup-rstudio.md).
   The first push opens a browser window to sign in to GitHub.

## Open this project

- **Already cloned in RStudio:** *File > Open Folder* and choose the project folder.
- **New copy:** Command Palette (`Ctrl+Shift+P`) > *Git: Clone*, then paste
  the repository URL.

Run the project from the integrated terminal (`` Ctrl+` ``) with
`Rscript run_all.R`, or open `run_all.R` and send lines to R with `Ctrl+Enter`.

## The everyday loop

Open **Source Control** (`Ctrl+Shift+G`, the branching icon on the left).

1. **Pull:** the *Sync Changes* button, or the *...* menu > *Pull*.
2. Edit. Colored bars in the left margin of each file mark changed lines;
   click a bar to see the earlier version.
3. Click a file under **Changes** to see the diff side by side.
4. Select **+** next to a file to stage it.
5. Type the message in the box at the top and select **Commit**.
6. **Sync Changes** pushes your commits and pulls commits from collaborators.

## Branches and pull requests

- The status bar at the bottom left shows the current branch. Click it to
  switch branches or select *Create new branch*.
- After you push a branch, the GitHub Pull Requests extension offers
  *Create Pull Request*. Reviewers can comment on individual lines.
- When a merge conflicts, open the file and select **Resolve in Merge Editor**,
  which places your version, the incoming version, and the result side by side.

## RStudio, VS Code, and the terminal

| Task | RStudio | VS Code | Terminal |
|---|---|---|---|
| See changed files | Git pane | Source Control view | `git status` |
| Review a change | Diff | Click the file | `git diff` |
| Stage | Staged checkbox | **+** | `git add file` |
| Commit | Commit button | Commit button | `git commit -m "..."` |
| Send to GitHub | Push | Sync Changes | `git push` |
| New branch | Branch button | Branch name, bottom left | `git switch -c name` |
| History | History button | Timeline view, or the Git Graph extension | `git log --oneline` |

## AI coding assistants

VS Code, Positron, and RStudio all support AI assistants. The same workflow
applies to code an assistant writes: read the diff, run the code, and commit
it under your name once you can explain each line. Keep API keys and
restricted data out of prompts. The commit history records each change and
when it was made.

`.gitignore` lists `.vscode/` (editor settings) so personal settings stay out
of the repository.
