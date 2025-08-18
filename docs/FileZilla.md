# 🗂 FileZilla – FTP/SFTP Client Documentation

---

## 📌 1. Introduction

FileZilla is an **open-source FTP (File Transfer Protocol) and SFTP (Secure File Transfer Protocol) client**.
It allows you to transfer files between your **local machine** and a **remote server**.

In this role, you will use FileZilla to:

* Upload datasets/logs to remote servers
* Download processed data from servers
* Manage files between local and cloud infrastructure

---

## ⚙️ 2. Installation & Setup

### 🔽 Installation

* Download from: [https://filezilla-project.org](https://filezilla-project.org)
* Choose **FileZilla Client** (not Server).
* Install using default configuration.

### 🛠 Access Requirements

You will need the following (ask your **SRE / Infra team**):

* **Host**: `ftp.example.com` or `sftp.server.com` (IP/domain)
* **Port**: `21` (FTP) or `22` (SFTP – preferred)
* **Username**: your allocated server account
* **Password** or **SSH key**

---

## 📂 3. Connecting to a Server

### Method 1: Quickconnect

1. Enter Host, Username, Password, and Port in the Quickconnect bar.
2. Press **Enter** or click **Quickconnect**.

```bash
# Example
Host: sftp.server.com
Username: nurwan
Password: ********
Port: 22
```

### Method 2: Site Manager (Recommended)

1. Go to **File → Site Manager**.
2. Click **New Site**.
3. Configure connection:

```
Protocol: SFTP - SSH File Transfer Protocol
Host: sftp.server.com
Port: 22
Logon Type: Normal / Key File
User: nurwan
```

4. Save and connect.

✅ Best practice: Use **Site Manager** so credentials are saved securely.

---

## 🔄 4. File Operations

### Upload Files

* Drag from **Local Site (left panel)** → **Remote Site (right panel)**.

### Download Files

* Drag from **Remote Site** → **Local Site**.

### Resume Interrupted Transfers

* Right-click on the file in transfer queue → **Resume**.

### File Permissions

* Right-click → **File Permissions…**
* Adjust Unix/Linux permissions (e.g., `644` for files, `755` for directories).

```bash
# Typical permission values
-rw-r--r--   (644)   # Files readable by all, writable by owner
drwxr-xr-x   (755)   # Directories accessible by all, writable by owner
```

---

## 🛡️ 5. Best Practices (Security + Workflow)

* ✅ **Always use SFTP (port 22)** → encrypted and secure.
* ✅ Organize data in **structured folders** (e.g., `/data/raw/`, `/data/processed/`).
* ✅ Validate file integrity (check file size or checksums like `md5sum`).
* ✅ Use **key-based authentication** instead of password when possible.
* ✅ Never download or upload sensitive data to unapproved locations.
* ✅ Use **transfer queue** (bottom panel) to monitor jobs.

---

## 🐞 6. Troubleshooting

| Issue                     | Root Cause            | Solution                                           |
| ------------------------- | --------------------- | -------------------------------------------------- |
| **Connection timeout**    | VPN/firewall not open | Check VPN, ask SRE to whitelist IP                 |
| **Permission denied**     | User lacks rights     | Ask SRE to grant correct access                    |
| **Transfer fails midway** | Network instability   | Use **Resume** function                            |
| **Wrong file encoding**   | OS/locale mismatch    | Change: `Edit → Settings → Transfers → File Types` |

---

## 📖 7. Technical Fundamentals

### FTP vs SFTP

* **FTP (Port 21)** → Plain text, insecure
* **FTPS (Port 990)** → FTP with TLS/SSL encryption
* **SFTP (Port 22)** → Uses SSH, secure and recommended

### Directory Structure

* **Local site (left panel)** → Your computer
* **Remote site (right panel)** → Cloud/server storage
* Double-click = transfer

### Transfer Modes

* **Active Mode**: Client opens random port; server connects back
* **Passive Mode (default)**: Client initiates both connections (better for firewalls)

```bash
# Change in FileZilla
Edit → Settings → FTP → Transfer Mode → Passive
```

---

## 🔗 8. References

* [Official FileZilla Docs](https://wiki.filezilla-project.org/Documentation)
* [DigitalOcean – Using FileZilla](https://www.digitalocean.com/community/tutorials/how-to-use-filezilla-to-transfer-and-manage-files-securely-on-your-vps)
* [FTP vs SFTP Explained](https://www.ssh.com/academy/ssh/ftp-vs-sftp)

---

✅ This style gives you:

* **Step-by-step sections** (like notebook cells)
* **Command/code snippets**
* **Best practices** integrated
* **Deeper fundamentals** (protocols, modes, permissions)

---
