#!/bin/bash

# Filename for the log
NGINX_LOG="nginx.log"
REPO_DIR="nginx_logs_repo"

# Check if the log file exists
if [[ ! -f "$NGINX_LOG" ]]; then
  echo "Error: Log file '$NGINX_LOG' not found. Please provide the log file in the same directory."
  exit 1
fi

# Create a directory for the results
mkdir -p "$REPO_DIR"

# Function for converting logs to CSV
parse_logs_to_csv() {
  echo "Parsing logs to CSV..."

  # Form the header of the CSV file
  echo "IP,Requested URL,Response Code" > "$REPO_DIR/parsed_logs.csv"

  # Parsing logs and adding them to CSV
  awk '{print $1","$7","$9}' "$NGINX_LOG" >> "$REPO_DIR/parsed_logs.csv"
}

# Function to save files to Git
store_csv_in_git() {
  cd "$REPO_DIR"

  if [[ ! -d .git ]]; then
    echo "Initializing Git repository..."
    git init
    git remote add origin git@github.com:BLASHCHUK-9/nginx-log-parser.git
  fi

  git add .
  git commit -m "Updated nginx logs in CSV format"
  git branch -M main
  git pull origin main --rebase || echo "Error: Could not pull remote changes."
  git push -u origin main || echo "Error: Could not push to remote repository. Check if the repository exists and SSH access is configured."
  cd -
}

# Calling functions
parse_logs_to_csv
store_csv_in_git

echo "Script completed successfully."
