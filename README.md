
# Instructions for Setting Up and Running the Script

This repository contains a script for parsing Nginx logs, converting them into CSV format, and uploading the results to a GitHub repository.

## Requirements

1. **Linux OS**
2. **Root access** or access to the `nginx.log` file for processing
3. **Git** installed on the server
4. **SSH access** to your GitHub repository

## Steps to Set Up and Run the Script

1. **Clone or create a GitHub repository:**
   - Create a repository on GitHub (e.g., `nginx-log-parser`).
   - Copy the SSH URL of the repository (e.g., `git@github.com:<your-username>/<repo-name>.git`).
   - Add the URL to the script in the following section:
     ```bash
     # Function for saving files to Git
     store_csv_in_git() {
       cd "$REPO_DIR"

       if [[ ! -d .git ]]; then
         echo "Initializing Git repository..."
         git init
         git remote add origin git@github.com:<your-username>/<repo-name>.git
       fi
     }
     ```
   - This will initialize the repository if it hasn’t already been done.

2. **Set up SSH access:**
   - Generate an SSH key:
     ```bash
     ssh-keygen -t rsa -b 4096
     ```
   - Copy the public key to GitHub under **Settings → Deploy Keys → New SSH Key**:
     ```bash
     cat ~/.ssh/id_rsa.pub
     ```

3. **Prepare the script:**
   - Create the script `script.sh` in your server environment.
   - Make it executable:
     ```bash
     chmod +x script.sh
     ```

4. **Prepare the log file:**
   - Place the `nginx.log` file in the same directory as the script.
   - If the log file has a different name or location, update the script variable `NGINX_LOG` accordingly.

5. **Run the script:**
   ```bash
   ./script.sh
   ```
   - The script will:
     - Check for the existence of the log file.
     - Parse the logs into CSV format (`parsed_logs.csv`) with columns `IP`, `Requested URL`, and `Response Code`.
     - Commit and push the CSV file to the GitHub repository.

6. **Verify the output:**
   - After the script completes, check the repository to ensure that `parsed_logs.csv` has been uploaded successfully.

