
# Nginx Logs Parser

## Features
- Parses Nginx logs into CSV format and uploads to Git with the following columns:
  - **IP Address**
  - **Requested URL**
  - **Response Code**

---

## Requirements
1. **Linux-based system**.
2. **Docker**, installed on your system.
3. **Nginx log file**, available for parsing (e.g., `nginx.log`).
4. **SSH key for GitHub** (for uploading results):
   - SSH key added to your GitHub account.
   - SSH agent must be running and the key loaded.

---

## Getting Started

### 1. Clone the repository
```bash
git clone git@github.com:BLASHCHUK-9/nginx-log-parser.git
cd nginx-log-parser
```

### 2. Build the Docker image
```bash
docker build -t nginx-log-parser .
```

---

## Running the Container

### Prepare the environment
1. Ensure the SSH agent is running and the SSH key is loaded:
   ```bash
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_rsa
   ```

2. Verify that the SSH key works:
   ```bash
   ssh -T git@github.com
   ```

### Run the container with options
#### **1. Upload results to GitHub**
```bash
docker run --rm     -v $SSH_AUTH_SOCK:/ssh-agent     -e SSH_AUTH_SOCK=/ssh-agent     -v /path/nginx.log:/app/nginx.log     nginx-log-parser
```
- The `parsed_logs.csv` file will be uploaded to your GitHub repository.

---

## Results
1. **Uploaded to GitHub:**
   - The CSV file is added to the GitHub repository linked with the script.

---

## Troubleshooting

1. **SSH key access error:**
   - Ensure the SSH key has the correct permissions:
     ```bash
     chmod 600 ~/.ssh/id_rsa
     ```

2. **GitHub cannot connect:**
   - Ensure the SSH key is added to your GitHub account.
   - Perform a test:
     ```bash
     ssh -T git@github.com
     ```

3. **`nginx.log` file not found:**
   - Check if the file exists at the specified path.

---
