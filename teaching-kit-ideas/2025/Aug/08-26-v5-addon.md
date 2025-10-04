

## ✅ How to Check If Tools Are Installed

| Tool     | macOS Command Line                         | Windows Command Line / PowerShell            |
|----------|--------------------------------------------|----------------------------------------------|
| Python   | `python3 --version` (preferred) <br> `python --version` may point to Python 2.x | `python --version` (Python 3.x if installed correctly) |
| VS Code  | `code --version` (if PATH is set)          | `code --version` (after install with PATH option) |
| Git      | `git --version`                            | `git --version`                              |
| WSL      | ❌ Not applicable                           | `wsl --list` or `wsl --status`               |

> 💡 On macOS, `python3` is the standard alias for Python 3.x. `python` may still point to Python 2.x depending on the system. So `python3 --version` is safest.

---

## 🛠️ PATH Handling on macOS

- **Python**:  
  - If installed via the official installer, it usually sets up `python3` in `/usr/local/bin`, which is in PATH.
  - If installed via Homebrew: `brew install python` also sets up `python3` in PATH.

- **VS Code**:  
  - After dragging to Applications, you must manually enable the `code` command in PATH:
    - Open VS Code → `Cmd+Shift+P` → type “Shell Command: Install 'code' command in PATH” → hit Enter.

> 📎 You might want to add this VS Code shell command step to your install guide for macOS students.

---

## 🧪 Can You Run These Commands on macOS?

- ✅ `git --version` → works if Git is installed (often preinstalled).
- ✅ `python3 --version` → preferred check for Python 3.
- ✅ `python --version` → may show Python 2.x.
- ✅ `code --version` → works *only* if you’ve run the shell command above.

---

## 🎛️ VS Code Extensions Panel Shortcut

- On **macOS**, the shortcut is: `Cmd+Shift+X`  
- On **Windows**, it’s: `Ctrl+Shift+X`

> You could annotate this in your table as:  
> `Cmd+Shift+X (macOS)` / `Ctrl+Shift+X (Windows)`

---

## 🧭 VS Code + WSL Behavior

- If you launch VS Code from **Windows** and WSL is installed:
  - Opening a folder inside the WSL filesystem (e.g., `/home/david/project`) will trigger VS Code to open in **WSL mode** automatically.
  - You’ll see a green corner indicator: `WSL: Ubuntu` (or whatever distro you're using).

- ✅ Best Practice:
  - Create your project folder inside WSL first:
    ```bash
    mkdir -p ~/projects/mykit
    cd ~/projects/mykit
    ```
  - Then run:
    ```bash
    code .
    ```
    This ensures VS Code launches in WSL context, with correct paths and environment.



