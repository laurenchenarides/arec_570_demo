# Setting up Git and GitHub in RStudio

Complete Parts One and Two before Lecture 5.3. Part Three is for your own
research project.

## Part One: Install and introduce yourself to Git

1. Install Git: <https://github.com/git-guides/install-git>. On Windows, accept
   the installer defaults. Restart RStudio afterward.

   ![Install Git](images/01_git.png)

2. Create a GitHub account: <https://github.com/signup>. Use an address you will
   keep after graduation, and add your university address as a second email.
   Students can request free GitHub Pro through
   [GitHub Education](https://education.github.com/).

   ![Create a GitHub account](images/02_account.png)

3. Tell Git who you are. In the RStudio **Console**:

   ```r
   install.packages(c("usethis", "gitcreds"))
   usethis::use_git_config(
     user.name  = "Your Name",
     user.email = "the-email-on-your-github-account@example.edu"
   )
   ```

4. Let RStudio push to GitHub. GitHub requires a personal access token (PAT)
   rather than your password:

   ```r
   usethis::create_github_token()   # opens GitHub; keep the default scopes
   gitcreds::gitcreds_set()         # paste the token when prompted
   ```

   The token is stored by your operating system's credential manager, not in
   any project file. Treat it like a password.

5. Confirm the setup:

   ```r
   usethis::git_sitrep()
   ```

## Part Two: Get a copy of this demo project in RStudio

1. On GitHub, open <https://github.com/laurenchenarides/arec_570_demo> and
   select **Fork** (top right). This creates your own copy that you can push to.
2. On your fork, select the green **Code** button and copy the HTTPS URL.
3. In RStudio: **File > New Project > Version Control > Git**. Paste the URL,
   choose where the folder should live, and select **Create Project**.

   Keep Git projects in a regular folder such as `C:/Users/you/GitProjects`.
   Cloud-synced folders (OneDrive, Dropbox) can conflict with Git's own files.

4. RStudio opens the project and shows a **Git** tab in the upper-right pane.

   ![The Git tab in RStudio](images/03_git_tab.png)

5. Run `source("run_all.R")` (or open `api_examples.R` at the 5.2 stage).

## Part Three: Put an existing project under version control

Use this for your own research project, which already exists as a folder.

1. Open the project in RStudio (create an `.Rproj` with **File > New Project >
   Existing Directory** if needed).
2. Run `usethis::use_git()` and answer the prompts to make an initial commit.
   (Equivalently: **Tools > Version Control > Project Setup > Git**.)
3. Before the first commit, add credentials, confidential data, and large files
   to `.gitignore`. See [git-in-rstudio.md](git-in-rstudio.md).
4. Run `usethis::use_github(private = TRUE)` to create a private GitHub
   repository and push. Restricted or licensed data should never be pushed,
   even to a private repository.

The manual route, which the screenshots below follow, does the same thing:

- Create an empty repository on GitHub without a README.

  ![Create a new repository](images/04_new_repo.png)

- Copy the commands under "…or push an existing repository from the command
  line."

  ![Copy the push commands](images/05_command_line.png)

- Paste them into the RStudio **Terminal** tab (next to the Console) and press
  Enter.

  ![Paste into the Terminal](images/06_terminal_window.png)

- Refresh the GitHub page. The files now appear online.

  ![Refresh GitHub](images/07_chrome_refresh.png)

## Part Four: Add and push a README

1. **File > New File > Markdown File** (not R Markdown). Save it as `README.md`.

   ![New Markdown file](images/08_markdown.png)

2. In the Git tab, check **Staged** next to the file, select **Commit**, write a
   message, and select **Commit**.

   ![Commit the README](images/09_commit_readme.png)

3. Select **Push** (green up arrow) to send the commit to GitHub.

   ![Push to GitHub](images/10_push.png)

## References

- Battiston and Gars, 2021. *Git for Research in Economics*.
  <https://leap.unibocconi.eu/sites/default/files/media/attach/LEAPgit_handout.pdf>
- Bryan, J. *Happy Git and GitHub for the useR*. <https://happygitwithr.com/>
- Riffomonas Project, 2021. *Connecting an existing RStudio project to Git and
  GitHub*. <https://youtu.be/bUoN85QvC10>
- Sostero, 2018. *Git better: Collaborative project management using Git and
  GitHub*. <https://matteosostero.com/files/slides_git.pdf>
