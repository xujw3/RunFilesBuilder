# Gemini Workspace

This document provides an overview of the `RunFilesBuilder` project, its structure, and how to contribute.

## Project Overview

`RunFilesBuilder` is a project that automates the building and packaging of various open-source software. It uses shell scripts to define the build process for each application and GitHub Actions to automate the execution of these scripts. The resulting artifacts are then available for download.

The primary goal of this project is to provide a centralized and automated way to build and distribute the latest versions of these tools.

## File Structure

The project is organized into the following key directories:

-   `.github/workflows/`: Contains GitHub Actions workflow files. Each file corresponds to a specific application or a set of applications to be built.
-   `info/`: Contains Markdown files with additional information about the applications being built.
-   `shell/`: Contains the core shell scripts that perform the actual building and packaging of the applications.

## Core Scripts and Workflows

### Shell Scripts (`shell/`)

The shell scripts in the `shell/` directory are the heart of the project. Each script is responsible for:

1.  **Fetching the source code:** Cloning the repository of the application to be built.
2.  **Compiling the code:** Running the necessary build commands.
3.  **Packaging the artifacts:** Creating archives (e.g., `.zip`, `.tar.gz`) of the compiled application.

Key scripts include:

-   `dae.sh`: Builds the `dae` application.
-   `homeproxy.sh`: Builds the `homeproxy` application.
-   `store.sh`: Builds the `store` application.
-   And others for different applications.

### GitHub Actions Workflows (`.github/workflows/`)

The GitHub Actions workflows automate the execution of the shell scripts. They are typically triggered by events like pushes to the repository or scheduled timers.

Key workflows include:

-   `dae.yml`: The workflow for building `dae`.
-   `homeproxy.yml`: The workflow for building `homeproxy`.
-   `main.yml`: A central workflow that seems to coordinate multiple builds.

## Key Technologies

-   **Shell Scripting (Bash):** Used for writing the build scripts.
-   **GitHub Actions:** Used for automation and CI/CD.
-   **Markdown:** Used for documentation.

## Development Workflow

### Adding a New Application

To add a new application to be built, you would typically follow these steps:

1.  **Create a new shell script:** In the `shell/` directory, create a new script (e.g., `newapp.sh`) that handles the building of the new application.
2.  **Create a new GitHub Actions workflow:** In the `.github/workflows/` directory, create a new YAML file (e.g., `newapp.yml`) that defines the workflow for building the new application. This workflow will call the shell script you created in the previous step.
3.  **(Optional) Add documentation:** Create a new Markdown file in the `info/` directory to provide information about the new application.

### Modifying an Existing Build

To modify an existing build, you would:

1.  **Edit the corresponding shell script:** Locate the shell script for the application you want to modify in the `shell/` directory and make the necessary changes.
2.  **Test the changes:** Run the script locally or push the changes to a test branch to trigger the GitHub Actions workflow.
