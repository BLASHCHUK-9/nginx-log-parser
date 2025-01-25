# Use Debian base image
FROM debian:bullseye

# Install required packages
RUN apt-get update && apt-get install -y \
    git \
    bash \
    gawk \
    ssh \
    && apt-get clean

# Set the working directory
WORKDIR /app

# Copy the script into the container
COPY log-pars.sh /app/log-pars.sh

# Make the script executable
RUN chmod +x /app/log-pars.sh

# Add GitHub to known hosts
RUN mkdir -p /root/.ssh && ssh-keyscan -H github.com >> /root/.ssh/known_hosts

# Configure Git user.name and user.email
RUN git config --global user.name "Auto Commit" && \
    git config --global user.email "auto-commit@example.com"

# Set the entrypoint
ENTRYPOINT ["/app/log-pars.sh"]
