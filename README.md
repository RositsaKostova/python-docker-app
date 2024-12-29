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

---

# How to containerize an application and get it running in Kubernetes?

## Get the application code

### Use git to clone the repository to your local machine:

```
git clone: https://github.com/KaterinaZaharieva/DevOpsProject.git
```

### Change to the app directory:
```
cd DevOpsProject/src
```

## Run locally

### Manually run the installer and application using the following commands:

```
pip install -r requirements.txt
python app.py
```

This will start a development web server hosting your application, which you will be able to see by navigating to localhost:5000.
Because port 5000 is the default port for the development server, we didn’t need to specify it.

## Dockerfile

> **[Docker](https://docs.docker.com/)** provides the ability to package and run an application in a loosely isolated environment called a container.
> 
> The isolation and security lets you run many containers simultaneously on a given host.
> 
>  Containers are lightweight and contain everything needed to run the application, so you don't need to rely on what's installed on the host.
> 

Our **[Dockerfile](https://docs.docker.com/engine/reference/builder/)** is going to:

1. Get the official ubuntu latest image from Docker Hub.
2. Install python3 and python3-pip
3. Copy the current directory’s contents for the container to be able to use them for itself
4. Run the pip3 installer to pull the requirements into the image.
5. Inform Docker the container listens on port 5000.
6. Configure the starting command to use when the container starts.

## Create an image

### At your command line or shell, in the DevOpsProject directory, build the image with the following command:

```
docker build -f Dockerfile -t devops-project:latest .
```

### To verify the image was created, run the following command:

```
docker image ls
```

## Running in Docker
Before jumping into Kubernetes, let’s verify it works in Docker. 

### Run the following command to have Docker run the application in a container and map it to port 5001:

```
docker run -p 5001:5000 devops-project
```

Now navigate to localhost:5001, and you should see the “Hello! I am a Flask application running on {socket number}” message.

# Running in Kubernetes

>
> **[Kubernetes](https://kubernetes.io/)** , also known as K8s, is an open-source system for automating deployment, scaling, and management of containerized applications.
>

## You are finally ready to get the application running in Kubernetes. 

### First verify your kubectl is configured. At the command line, type the following:

```
kubectl version
```

### If you don’t see a reply with a Client and Server version, you’ll need to **[install](https://minikube.sigs.k8s.io/docs/start/)** and configure it.

```
minikube start
```

### Now you are working with Kubernetes! You can see the node by typing:

```
kubectl get nodes
```
# Deployment

> A **[Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)** provides declarative updates for Pods and ReplicaSets.
> 
> You describe a desired state in a Deployment, and the Deployment Controller
>
> changes the actual state to the desired state at a controlled rate. You can define Deployments to
> 
> create new ReplicaSets, or to remove existing Deployments and adopt all their resources with new Deployments.
> 

## deployment.yaml

1. A Deployment named "devops-project-deployment" is created, indicated by the .metadata.name field.
This name will become the basis for the ReplicaSets and Pods which are created later
2. The Deployment creates a ReplicaSet that creates two replicated Pods, indicated by the .spec.replicas field.
3. The .spec.selector field defines how the created ReplicaSet finds which Pods to manage. In this case, you select a label
that is defined in the Pod template (app: devops-project-app). 
4. The template field contains the following sub-fields:
   
> 4.1 The Pods are labeled " app: devops-project-app" the .metadata.labels field
>
> 4.2 The Pod template's specification, or .template.spec field, indicates that the Pods run one container,
"devops-project", which runs at version latest.
>
> 4.3 Create one container and name it "devops-project" using the .spec.template.spec.containers[0].name field

5. strategy.type—specifies which deployment strategy should be used. In this case we select RollingUpdate,
which means new versions are rolled out gradually to pods to avoid downtime.
6. spec.template.spec.containers—specifies which container image to run in each of the pods and ports to expose.
7. The spec.containers.resources field specifies:
   
> 7.1. limits—each container should not be allowed to consume more than 200Mi of memory.
>
> 7.2. requests—each container requires 100m of CPU resources and 200Mi of memory on the node.

8.The template.spec.containers.livenessProbe field defines what the kubelet should check to ensure that the pod is alive: 

> 8.1. httpGetspecifies that the kubelet should try a HTTP request on the root of the web server on port 5000.
>
> 8.2. periodSecondsspecifies how often the kubelet should perform a liveness probe.
>
> 8.3. initialDelaySecondsspecifies how long the kubelet should wait after the pod starts, before performing the first probe.

# Service

> In Kubernetes, a **[Service](https://kubernetes.io/docs/concepts/services-networking/service/)** is a method for exposing a network application that is running as one or more Pods in your cluster.
> 
> A key aim of Services in Kubernetes is that you don't need to modify your existing application to use an unfamiliar
> 
> service discovery mechanism.
> 
> You can run code in Pods, whether this is a code designed for a cloud-native world, or an older app you've containerized.
> 
> You use a Service to make that set of Pods available on the network so that clients can interact with it.
> 

## service.yaml
1. we have Pods that each listen on TCP port 5000
2. they are labelled as  app: devops-project-app

Applying this manifest creates a new Service named "devops-project-service" with the default ClusterIP service type.
The Service targets TCP port 5000 on any Pod with the "app: devops-project-app" label.

### Use kubectl to send the YAML file to Kubernetes by running the following commands:

```
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
```

### You can see the pods are running if you execute the following command:

```
kubectl get pods
```

### If the STATUS for the poods is "ErrImageNeverPull" you need to execute the following command:

```
eval $(minikube docker-env)
```

### Then have to rebuild your Docker image by running the following command:

```
docker build -f Dockerfile -t devops-project:latest .
```

To understand more click **[here](https://stackoverflow.com/questions/56392041/getting-errimageneverpull-in-pods)**.

### View the Deployment:

```
kubectl get deployments
```

### View the Service you created:
```
kubectl get services
```

On cloud providers that support load balancers, an external IP address would be provisioned to access the Service.
On minikube, the LoadBalancer type makes the Service accessible through the minikube service command.

### Run the following command:

```
minikube service devops-project-service
```

This opens up a browser window that serves your app and shows the app's response.

## Clean up

### Now you can clean up the resources you created in your cluster:

```
kubectl delete service devops-project-service
kubectl delete deployment devops-project-deployment
```

### Stop the Minikube cluster

```
minikube stop
```

### Optionally, delete the Minikube VM:

```
# Optional
minikube delete
```
If you want to use minikube again to learn more about Kubernetes, you don't need to delete it.

---

## Used apps

- [Flake8](https://flake8.pycqa.org/)
- [Black](https://black.readthedocs.io/)
- [EditorConfig](https://editorconfig.org/)
- [Flyway](https://flywaydb.org/)
- [SonarCloud](https://sonarcloud.io/)
- [Snyk](https://snyk.io/)
- [Trivy](https://aquasecurity.github.io/trivy/)

