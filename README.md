### Documentation

# DevOpsProject

## Purpose of document

The purpose of this file is to serve as documentation for DevOpsProject—an updated CI/CD pipeline for automation and quality assurance.

## Format of document

The format of this file, in order to explain what each job and step do in the `DevOpsProject.yaml`, is similar to this example:

```yaml
DevOpsProject.yaml:
    JOB1:
        - step1:
            - requirements (e.g., secrets needed, accounts setup)
            - step summary
        - step2:
            - requirements
            - step summary
    JOB2:
        - step1: ...
        - step2: ...
        ...
```

## DevOpsProject.yaml and what it does (step-by-step description)

### 1. GitLeaksCheck
#### Description
Scans the repository for sensitive information (e.g., API keys, passwords, tokens) using Gitleaks to prevent accidental leaks.

#### Steps:
- **Step 1: Checkout code**
    - **Requirements**: None
    - **Summary**: Pulls the latest code from the repository.

- **Step 2: Gitleaks check**
    - **Requirements**: None
    - **Summary**: Runs the `gitleaks/gitleaks-action@v2` action to scan the codebase and git history for potential leaks.

---

### 2. BlackFormatting
#### Description
Formats and validates Python code to adhere to PEP 8 standards using the Black tool.

#### Steps:
- **Step 1: Checkout code**
    - **Requirements**: None
    - **Summary**: Retrieves the repository for local use.

- **Step 2: Install Black**
    - **Requirements**: None
    - **Summary**: Installs Black using pip.

- **Step 3: Check formatting**
    - **Requirements**: Black installed
    - **Summary**: Validates Python files for proper formatting.

- **Step 4: Apply formatting**
    - **Requirements**: Black installed
    - **Summary**: Automatically applies formatting fixes for Python code if discrepancies are found.

---

### 3. MarkdownFileCheck
#### Description
Validates Markdown files to ensure all links are valid and operational.

#### Steps:
- **Step 1: Checkout Repository**
    - **Requirements**: None
    - **Summary**: Pulls the repository files to the runner.

- **Step 2: Markdown Link Validation**
    - **Requirements**: None
    - **Summary**: Executes `ruzickap/action-my-markdown-link-checker@v1.1.2` to check all links in Markdown files for validity.

---

### 4. EditorConfigLint
#### Description
Ensures that files in the repository comply with the .editorconfig standards.

#### Steps:
- **Step 1: Checkout Repository**
    - **Requirements**: None
    - **Summary**: Downloads the repository to the runner.

- **Step 2: Install EditorConfig Checker**
    - **Requirements**: Python installed
    - **Summary**: Installs `editorconfig-checker` to validate file configurations.

- **Step 3: EditorConfig Check**
    - **Requirements**: .editorconfig file in the repository
    - **Summary**: Runs `editorconfig-checker` to validate files against the defined configuration.

---

### 5. UnitTest
#### Description
Executes unit tests to ensure code correctness and reliability.

#### Steps:
- **Step 1: Prepare repo**
    - **Requirements**: None
    - **Summary**: Retrieves the repository code.

- **Step 2: Set up Python**
    - **Requirements**: None
    - **Summary**: Configures Python environment using `actions/setup-python@v3`.

- **Step 3: Install requirements**
    - **Requirements**: A valid `requirements.txt` file in `src` directory
    - **Summary**: Installs dependencies needed for testing.

- **Step 4: Run tests**
    - **Requirements**: Python dependencies installed
    - **Summary**: Executes unit tests using Python's `unittest` module.

---

### 6. DatabaseMigrations
#### Description
Tests database migrations using Flyway for PostgreSQL.

#### Steps:
- **Step 1: Setup PostgreSQL service**
    - **Requirements**: Docker installed
    - **Summary**: Starts a PostgreSQL container with predefined environment variables.

- **Step 2: Execute Flyway migrations**
    - **Requirements**: SQL migration scripts
    - **Summary**: Runs Flyway to apply migrations to the PostgreSQL database.

---

### 7. SonarCloudTest
#### Description
Analyzes code quality and detects vulnerabilities using SonarCloud.

#### Steps:
- **Step 1: Checkout code**
    - **Requirements**: None
    - **Summary**: Retrieves the repository.

- **Step 2: SonarCloud Scan**
    - **Requirements**: `SONAR_TOKEN` secret
    - **Summary**: Runs SonarCloud analysis for code quality, security, and maintainability.

---

### 8. DependencyCheck
#### Description
Manages and verifies Python project dependencies using `pip-tools`.

#### Steps:
- **Step 1: Install pip-tools**
    - **Requirements**: Python installed
    - **Summary**: Installs `pip-tools` for dependency management.

- **Step 2: Generate and install dependencies**
    - **Requirements**: A valid `requirements.in` file
    - **Summary**: Compiles and installs dependencies.

---

### 9. SecScan2
#### Description
Performs security scans on Python code using ShiftLeftSecurity tools.

#### Steps:
- **Step 1: Checkout code**
    - **Requirements**: None
    - **Summary**: Retrieves the code for scanning.

- **Step 2: Perform Scan**
    - **Requirements**: `ShiftLeftSecurity/scan-action` setup
    - **Summary**: Scans for vulnerabilities in Python code.

---

### 10. ImagePush
#### Description
Builds, scans, and publishes Docker images to DockerHub.

#### Steps:
- **Step 1: Checkout code**
    - **Requirements**: None
    - **Summary**: Pulls the code repository.

- **Step 2: Docker Login**
    - **Requirements**: `DOCKER_USERNAME` and `DOCKER_PASSWORD` secrets
    - **Summary**: Authenticates to DockerHub.

- **Step 3: Build Docker image**
    - **Requirements**: A valid Dockerfile
    - **Summary**: Creates a Docker image for the application.

- **Step 4: Push Image to DockerHub**
    - **Requirements**: Docker image built
    - **Summary**: Publishes the Docker image.

## Used apps

- [Flake8](https://flake8.pycqa.org/)
- [Black](https://black.readthedocs.io/)
- [EditorConfig](https://editorconfig.org/)
- [Flyway](https://flywaydb.org/)
- [SonarCloud](https://sonarcloud.io/)
- [Snyk](https://snyk.io/)
- [Trivy](https://aquasecurity.github.io/trivy/)
- [Codacy](https://www.codacy.com/)



