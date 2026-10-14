# Supplement: the same workflow in VS Code

RStudio is the course default. VS Code is worth knowing because many
economists work in more than one language (R, Python, Stata, SQL, LaTeX) and
on remote servers. Git does not depend on the editor: a repository created in
RStudio opens unchanged in VS Code, and the commit history is identical.

[Positron](https://positron.posit.co/), Posit's newer editor, is built on the
same foundation as VS Code and has a similar Source Control view.

## Setup

1. Install VS Code: <https://code.visualstudio.com/>
2. In the Extensions view (`Ctrl+Shift+X`), install:
   - **R** (REditorSupport): run R code, view plots and data
   - **GitHub Pull Requests**: review and merge pull requests inside VS Code
3. In R, install the language server once: `install.packages("languageserver")`
4. VS Code uses the Git you already installed. The first push opens a browser
   window to sign in to GitHub.

## Open this project

- **Already cloned in RStudio:** *File > Open Folder* and choose the project folder.
- **Fresh copy:** Command Palette (`Ctrl+Shift+P`) > *Git: Clone*, then paste
  the repository URL.

Run the project from the integrated terminal (`` Ctrl+` ``) with
`Rscript run_all.R`, or open `run_all.R` and send lines to R with `Ctrl+Enter`.

## The everyday loop

Open **Source Control** (`Ctrl+Shift+G`, the branching icon on the left).

1. **Pull:** the *Sync Changes* button, or *...* menu > *Pull*.
2. Edit. Colored bars in the left margin of each file mark changed lines;
   click a bar to see the old version.
3. Click a file under **Changes** to see the diff side by side.
4. Select **+** next to a file to stage it.
5. Type the message in the box at the top and select **Commit**.
6. **Sync Changes** pushes your commits (and pulls others').

## Branches and pull requests

- The current branch is shown at the bottom left of the window. Click it to
  switch branches or select *Create new branch*.
- After pushing a branch, the GitHub Pull Requests extension offers
  *Create Pull Request*. Reviewers can comment on individual lines.
- When a merge conflicts, open the file and select **Resolve in Merge Editor**:
  your version, the incoming version, and the result appear side by side.

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

VS Code, Positron, and RStudio all support AI assistants. The workflow rules do
not change: read the diff before you commit, commit assistant-written code
under your own name only after you understand it, and never paste API keys or
restricted data into a prompt. The commit history records what changed, so you
can always explain how the code got there.

`.vscode/` (editor settings) is listed in `.gitignore`.
