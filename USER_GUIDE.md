# Medina User Guide

This document provides instructions on how to use the Medina email sending script.

## 1. Introduction

This project provides a set of scripts to send personalized emails using `msmtp`. It uses Jinja2 for templating and reads data from a CSV file.

## 2. Prerequisites

- Docker
- Python 3
- `j2-cli` (Jinja2 for command-line)

You can install `j2-cli` using pip:

```bash
pip install j2-cli
```

## 3. Configuration

1.  **Create a `config.ini` file:**

    Copy the `config.ini.template` file to `config.ini` and fill in your SMTP server details.

    ```bash
    cp config.ini.template config.ini
    ```

    The `config.ini` file has two sections: `default` and `gmail`. The `default` section is configured to use MailCatcher, a simple SMTP server for development. The `gmail` section is an example for using a Gmail account.

2.  **Create a `resources/data.csv` file:**

    This file contains the data for the emails. The `sendmails.sh` script reads this file to personalize the emails. The CSV file should have the following columns:

    `codemms,firstname,name,class,ranking,student_nb,average,recipient,file_path,filename,from,cc,genre,is_done`

## 4. Usage

### 4.1. Using Docker

The easiest way to use this project is with Docker.

1.  **Build the Docker image:**

    ```bash
    docker-compose build
    ```

2.  **Run the services:**

    ```bash
    docker-compose up
    ```

    This will start two services: `mailcatcher` and `msmtp`.

3.  **Send emails:**

    To send emails, execute the `sendmails.sh` script inside the `msmtp` container:

    ```bash
    docker-compose exec msmtp ./sendmails.sh <account> <base_path>
    ```

    -   `<account>`: The `msmtp` account to use (e.g., `default` or `gmail`).
    -   `<base_path>`: The base path for the attachment files.

### 4.2. Without Docker

If you are not using Docker, you need to have `msmtp` and `j2-cli` installed on your system.

1.  **Install `msmtp`:**

    -   **macOS:** `brew install msmtp`
    -   **Debian/Ubuntu:** `apt-get install msmtp`

2.  **Send emails:**

    ```bash
    ./sendmails.sh <account> <base_path>
    ```

## 5. Templates

The project uses Jinja2 for templating. You can find the templates in the root directory:

-   `message.txt.jinja2`: The main email template.
-   `message-sem2.txt.jinja2`: Template for the second semester.
-   `message-2024.txt.jinja2`: Template for the year 2024.

You can customize these templates to change the email content.

## 6. Scripts

-   `sendmails.sh`: The main script to send emails.
-   `sendmails-sem2.sh`: A script to send emails for the second semester.
-   `sendmails-2024.sh`: A script to send emails for the year 2024.

These scripts read the `resources/data.csv` file and use the templates to generate and send the emails.
