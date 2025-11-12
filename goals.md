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

### Stage 2: Expansion - Next 30 Common Project Templates

We will expand the toolkit to include scaffolding scripts for the next 30 most common project types.

1.  **Angular App:**
    *   **Command:** `New-AngularApp.ps1`
    *   **Actions:** [X] Wrapper around `npx @angular/cli new`.

2.  **Ember App:**
    *   **Command:** `New-EmberApp.ps1`
    *   **Actions:** [X] Wrapper around `npx ember-cli new`.

3.  **Next.js App:**
    *   **Command:** `New-NextJsApp.ps1`
    *   **Actions:** [X] Wrapper around `npx create-next-app`.

4.  **Nuxt.js App:**
    *   **Command:** `New-NuxtJsApp.ps1`
    *   **Actions:** [X] Wrapper around `npx create-nuxt-app`.

5.  **Gatsby App:**
    *   **Command:** `New-GatsbyApp.ps1`
    *   **Actions:** [X] Wrapper around `npx gatsby new`.

6.  **Svelte App:**
    *   **Command:** `New-SvelteApp.ps1`
    *   **Actions:** [X] Wrapper around `npx create-vite --template svelte`.

7.  **Vue.js App:**
    *   **Command:** `New-VueApp.ps1`
    *   **Actions:** [X] Wrapper around `npx create-vite --template vue`.

8.  **ASP.NET Core Web App:**
    *   **Command:** `New-AspNetCoreWebApp.ps1`
    *   **Actions:** [X] Wrapper around `dotnet new webapp`.

9.  **ASP.NET Core API:**
    *   **Command:** `New-AspNetCoreApi.ps1`
    *   **Actions:** [X] Wrapper around `dotnet new webapi`.

10. **Django App:**
    *   **Command:** `New-DjangoApp.ps1`
    *   **Actions:** [X] Initialize Git, create virtual environment, `django-admin startproject`, `manage.py`, `.gitignore`.

11. **Flask App:**
    *   **Command:** `New-FlaskApp.ps1`
    *   **Actions:** [X] Initialize Git, create virtual environment, `app.py`, `requirements.txt`, `.gitignore`.

12. **Ruby on Rails App:**
    *   **Command:** `New-RailsApp.ps1`
    *   **Actions:** [X] Wrapper around `rails new`.

13. **Laravel App:**
    *   **Command:** `New-LaravelApp.ps1`
    *   **Actions:** [X] Wrapper around `composer create-project laravel/laravel`.

14. **Docusaurus Site:**
    *   **Command:** `New-DocusaurusSite.ps1`
    *   **Actions:** [X] Wrapper around `npx create-docusaurus`.

15. **Eleventy Site:**
    *   **Command:** `New-EleventySite.ps1`
    *   **Actions:** [X] Initialize npm, install Eleventy, basic config, `src/index.md`, `src/_includes/layout.njk`, Git init, `.gitignore`.

16. **Hugo Site:**
    *   **Command:** `New-HugoSite.ps1`
    *   **Actions:** [X] Wrapper around `hugo new site`.

17. **Jekyll Site:**
    *   **Command:** `New-JekyllSite.ps1`
    *   **Actions:** [X] Wrapper around `jekyll new`.

18. **MkDocs Site:**
    *   **Command:** `New-MkDocsSite.ps1`
    *   **Actions:** [X] Initialize Git, create virtual environment, install MkDocs, `mkdocs new`, `mkdocs.yml`, `.gitignore`.

19. **Flutter App:**
    *   **Command:** `New-FlutterApp.ps1`
    *   **Actions:** [X] Wrapper around `flutter create`.

20. **Xamarin App:**
    *   **Command:** `New-XamarinApp.ps1`
    *   **Actions:** [X] Wrapper around `dotnet new xamarin`.

21. **Electron App:**
    *   **Command:** `New-ElectronApp.ps1`
    *   **Actions:** [X] Initialize npm, install Electron, `main.js`, `index.html`, `package.json` scripts, Git init, `.gitignore`.

22. **React Native App:**
    *   **Command:** `New-ReactNativeApp.ps1`
    *   **Actions:** [X] Wrapper around `npx react-native init`.

23. **Go CLI App:**
    *   **Command:** `New-GoCliApp.ps1`
    *   **Actions:** [X] Initialize Git, `main.go`, `go.mod`, `.gitignore`. (Note: This is essentially the same as "Go Project" but with a CLI focus)

24. **Rust CLI App:**
    *   **Command:** `New-RustCliApp.ps1`
    *   **Actions:** [X] Wrapper around `cargo new --bin`. (Note: This is essentially the same as "Rust Project" but with a CLI focus)

25. **Java Spring Boot App:**
    *   **Command:** `New-SpringBootApp.ps1`
    *   **Actions:** [X] Wrapper around `curl start.spring.io`.

26. **C# Console App:**
    *   **Command:** `New-CsharpConsoleApp.ps1`
    *   **Actions:** [X] Wrapper around `dotnet new console`.

27. **PHP CLI App:**
    *   **Command:** `New-PhpCliApp.ps1`
    *   **Actions:** [X] Initialize Git, `composer.json`, `src/cli.php`, `.gitignore`.

28. **Kubernetes Manifests:**
    *   **Command:** `New-KubernetesManifests.ps1`
    *   **Actions:** [X] Create `deployments/`, `services/`, `ingresses/` directories with example YAML files, Git init, `.gitignore`.

29. **Terraform Project:**
    *   **Command:** `New-TerraformProject.ps1`
    *   **Actions:** [X] Create `main.tf`, `variables.tf`, `outputs.tf` with basic structure, Git init, `.gitignore`.

30. **Docker Compose Project:**
    *   **Command:** `New-DockerComposeProject.ps1`
    *   **Actions:** [X] Create `docker-compose.yml` with example services, Git init, `.gitignore`.

### Stage 3: Refinement & Core Engine

### Stage 3: Refinement & Core Engine
-   [ ] Develop a central PowerShell module (`FolderMaker.psm1`).
-   [ ] Refactor individual scripts to use functions from the core module (e.g., `Initialize-GitRepo`, `Create-FileWithContent`).
-   [ ] Add parameterization to scripts (e.g., specifying a project name).
