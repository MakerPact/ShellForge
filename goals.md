# Project: "FolderMaker" - A PowerShell Project Scaffolding Tool

## Big Picture Goal

The primary objective of this project is to develop a "tool kit" of PowerShell scripts that automate the setup of new programming projects. A developer should be able to create a new directory, run a single command (e.g., `New-WebsiteProject`), and have a complete, conventional folder structure and set of starter files created for them instantly. This will streamline the initial phase of development, enforce consistency, and reduce repetitive setup tasks.

The long-term vision is to support a comprehensive library of project templates, starting with the 5 most common types and eventually expanding to the top 100.

## AI Prompt (Self-Correction & Guidance)

You are an expert AI assistant specializing in PowerShell scripting and software development best practices. Your task is to build the "FolderMaker" tool kit.

**Core Mandates:**
1.  **Idempotency:** Scripts should be safe to run multiple times in the same directory without causing errors or overwriting user-modified files (unless explicitly intended).
2.  **Modularity:** Design a core script or module to handle common tasks like Git initialization, which can be reused by all project-specific scripts.
3.  **Convention over Configuration:** The generated projects should follow widely accepted community conventions for each project type. Avoid unnecessary complexity or configuration options in the initial stages.
4.  **Clarity and Maintainability:** The PowerShell code you write must be clean, well-commented (explaining the *why*, not the *what*), and easy for others to understand and extend.
5.  **User Experience:** The scripts should provide clear output to the user, indicating what was created and if any errors occurred.

## Project Outline & Development Stages

This project will be developed in stages to ensure a steady and manageable workflow.

### Stage 0: Project Setup
-   [ ] Create a new `jj` bookmark for this feature development.
-   [X] Create this `goals.md` file to document the project plan.
-   [X] Create a `scripts` directory to house all PowerShell scripts.

### Stage 1: The First Five - Common Project Templates

We will start by creating scaffolding scripts for the five most common project types.

1.  **Simple Website:**
    *   **Command:** `New-SimpleWebsite.ps1`
    *   **Actions:**
        *   Initialize a Git repository (`git init`).
        *   Create `index.html` with basic HTML5 boilerplate.
        *   Create a `css` folder with a `style.css` file.
        *   Create a `js` folder with a `main.js` file.
        *   Create an `images` folder.
        *   Create a `.gitignore` file with common entries for web development (e.g., `node_modules`).

2.  **Node.js/Express Backend API:**
    *   **Command:** `New-NodeApi.ps1`
    *   **Actions:**
        *   Initialize a Git repository.
        *   Run `npm init -y` to create `package.json`.
        *   Install `express` and `dotenv`.
        *   Create a `src` directory.
        *   Create `src/server.js` with a minimal Express server setup.
        *   Create a `.env` file for environment variables.
        *   Create a `.gitignore` file for Node.js projects.

3.  **React Frontend Application:**
    *   **Command:** `New-ReactApp.ps1`
    *   **Actions:**
        *   This script will be a wrapper around the official `create-react-app` or `Vite` tool.
        *   It will prompt the user for the app name (or use the current folder name).
        *   Execute `npx create-react-app .` or `npx create-vite . --template react`.
        *   Ensure Git repository is initialized correctly.

4.  **Python Application:**
    *   **Command:** `New-PythonApp.ps1`
    *   **Actions:**
        *   Initialize a Git repository.
        *   Create a `main.py` file with a simple `if __name__ == "__main__":` block.
        *   Create a `requirements.txt` file.
        *   Create a virtual environment folder (e.g., `.venv`).
        *   Create a `.gitignore` file that ignores the virtual environment folder and `__pycache__`.

5.  **PowerShell Script Project:**
    *   **Command:** `New-PowerShellScript.ps1`
    *   **Actions:**
        *   Initialize a Git repository.
        *   Create a `<ProjectName>.psm1` module file.
        *   Create a `<ProjectName>.psd1` manifest file.
        *   Create a `tests` folder with a `<ProjectName>.Tests.ps1` file using Pester.
        *   Create a `.gitignore` file.

6.  **Arduino Project:**
    *   **Command:** `New-ArduinoProject.ps1`
    *   **Actions:**
        *   [X] Initialize a Git repository.
        *   [X] Create a main `.ino` file with a pre-populated `setup()` and documentation for a custom debug print feature.
        *   [X] Create a custom `DPrint` library (header and C++ files) that allows conditional serial printing.
        *   [X] Create dedicated folders for documentation, project datasheets, and images.
        *   [X] Create a `.gitignore` file with common Arduino and IDE ignores.
        *   [X] Create a basic `README.md` for GitHub deployment.

### Stage 2: Expansion
-   [ ] Identify the next 5 most common project types.
-   [ ] Repeat the process from Stage 1 for the new project types.

### Stage 3: Refinement & Core Engine
-   [ ] Develop a central PowerShell module (`FolderMaker.psm1`).
-   [ ] Refactor individual scripts to use functions from the core module (e.g., `Initialize-GitRepo`, `Create-FileWithContent`).
-   [ ] Add parameterization to scripts (e.g., specifying a project name).
