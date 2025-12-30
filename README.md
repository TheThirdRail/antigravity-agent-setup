# 🚀 MCP Docker Stack: The "For Dummies" Guide

## 🌟 What is this project? (The "Why")

Have you ever wished your AI assistant (like me, Antigravity) could actually *do* things instead of just talking about them? 

This project is a **"Universal Adapter"** for AI. It connects me to a massive toolbox of over 33 different "servers" that allow me to:
- **Search the web** (Brave, SearXNG, Google).
- **Read and write files** on your computer.
- **Manage your tasks** (Todoist, Linear).
- **Access databases** (PostgreSQL, MongoDB).
- **Check code for bugs** (Snyk, Semgrep).

### The Secret Sauce: Rigid Instructions
For you (the non-coder), the biggest benefit is that this project uses **strict, rigid instruction sets** (Workflows). Instead of me guessing what to do, I follow a "flight manual" for every task. This ensures I stay on track, don't make rookie mistakes, and deliver high-quality results every single time. 

---

## 🛠️ Step 1: Install Docker Desktop

Think of **Docker** as a "shipping container" system for software. It lets all these 33+ tools run on your computer without you having to install them one by one.

1.  **Download**: Go to [Docker Desktop](https://www.docker.com/products/docker-desktop/) and download the Windows version.
2.  **Install**: Run the installer. Just click "Next" or "OK" on everything.
3.  **Start**: Open Docker Desktop. If it asks you to log in, you can usually skip it. Just make sure the little whale icon in your taskbar stays green!

---

## 🔑 Step 2: Set Up Your "Keys" (Secrets)

Most of the tools (like GitHub or Search) need a "key" (an API key) to work. Think of these as passwords for the tools.

1.  Find the file named `example.env` in this folder.
2.  **Duplicate it** and rename the copy to exactly `.env`.
3.  Open `.env` in Notepad or any text editor.
4.  Fill in the keys you want to use. You don't need *all* of them—just the ones you care about (like GitHub or Search).
    - *Tip: The links to where you get these keys are right there inside the `example.env` file!*

---

## 🪄 Step 3: Run the Magic Script

Now we need to tell Docker what those keys are. We have a script for that!

1.  Find the file named `set-mcp-secrets.ps1`.
2.  **Right-click** it and select **"Run with PowerShell"**.
3.  A blue window will pop up, "sign" all your keys into the system, and then close. You're done!

---

## 🚢 Step 4: Start the Engines

1.  Open your terminal (search for "PowerShell" in your Start menu).
2.  Type this command and hit Enter:
    ```powershell
    docker compose up -d
    ```
3.  Docker will start downloading and running all your tools. This might take a few minutes the first time, but afterward, it starts instantly!

---

## 🛸 Step 5: Setting up the Antigravity App

To make me (Antigravity) work with this stack, you need to "load" my brain and my flight manuals into the Antigravity Windows App.

1.  **System Instructions**:
    - Go to the **System Prompt** folder in this project.
    - Find the file `system_instructions.xml`.
    - Open it, copy all the text, and paste it into the **"System Instructions"** or **"Custom Instructions"** box in your Antigravity App settings.
2.  **Workflows**:
    - In your Antigravity App, look for a **"Workflows"** tab or folder.
    - Copy all the files from the `System Prompt/Workflows` folder in this project into that App's workflow location.
    - *Note: These are the `.xml` files—they are the most important ones!*

---

## 📑 How to Use Workflows

Once I have my workflows loaded, you can trigger them by typing a slash command. Here is what each one is for:

- **`/architect`**: Use this when you have a **new idea**. I will help you design the plan before we write any code.
- **`/code`**: Use this when the plan is ready and you want me to **start building**. I'll focus on working fast with minimal talk.
- **`/analyze`**: Use this when **something is broken**. I'll put on my detective hat and find the bug.
- **`/tutor`**: Use this when you want to **learn**. I'll explain how things work in plain English.
- **`/research`**: Use this when you need me to **dig deep** for information on the web.
- **`/refactor`**: Use this when you want me to **clean up** old code to make it "professional."

---

## ✅ Final Checklist
- [x] Docker Desktop is running (Green whale).
- [x] `.env` file is created and filled out.
- [x] `set-mcp-secrets.ps1` script has been run.
- [x] `docker compose up -d` was run in PowerShell.
- [x] System Instructions and Workflows are pasted into the Antigravity App.

**Now you have a 10X Engineer at your fingertips! What should we build first?**
