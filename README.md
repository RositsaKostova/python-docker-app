# Classwork Assignment 1

You are given a Python application and a client has requested your help to run it in a Docker container and automate the process of building the Docker image.

## Start up

Install necessary dependencies

```bash
pip3 install -r src/requirements.txt
```
Start the application

```bash
python3 src/app.py
```

## Tasks

### Style 
- Create a new **public** repository and use this one as a template.
- Add a license
- Add an .editorconfig
- Add a branching strategy (Contributors guide)
- Check code style & lint with `flake8`
- Check .editorconfig with `editorconfig-checker`
- Check makrdown files ([markdownlint-cli](https://www.npmjs.com/package/cli-markdown))

### Security testing
- Run unit tests (`python3 -m unittest src/app_test.py`)
- Scan the application code with SonarCloud and Snyk as part of the existing workflow
- Check for hardcoded secrets ([gitleaks](https://github.com/gitleaks/gitleaks))
- Run checks in parallel
- Implement job dependency
- Implement a new GitHub workflow with SonarCloud at Merge Request

### Database migrations
- Check for database migrations

### Containerization
- Containerize the Python application in the `src/` directory. Create a Dockerfile and use ubuntu as a base image
- Validate locally that the container is working
- Create a GitHub Actions workflow that builds the Docker image
- Scan the built Docker image with Trivy as part of the existing workflow
- Publish the image to your personal DockerHub account

### Additional practice
- Create a docker compose file to locally test database migrations

### Bonus
- Optimize the size of the Docker image. Use a more minimal base image.



### Documentation
# DevOpsProject

## Purpose of document

The purpose of this file is to serve as a documentation for DevOpsProject - Course work for FMI, year3. Made for the Modern DevOps Practices course.

## Format of document

The format of this file, in order to explain what each job and step do in the DevOpsProject.yaml, is similar to this example:

	DevOpsProject.yaml:
	
		JOB1:
			- step1:
				- requirements(like repo secrets to be added to repo for app or account needed prior to step execution)
				- step summary	
			- step2:
				- requirements before step execution
				- step summary
		JOB2:
			-step1: ...
			-step2: ...
			....
		...

## DevOpsProject.yaml and what it does(step-by-step description)

DevOpsProject.yaml:
	
    Flake8:
		- step1: Checkout code
			- requirements before step execution : none
			- step summary: the first step for any job is to have completed the checkout code process, using the available git-hub action(available in the Git-Hub market place)

		- step2: Install flake8
			- requirements before step execution: none
			- step summary: installs the flake8 app

            - step3: Check code with flake8
                - requirements before step execution: to have installed the flake8 app at a previous step in the current job
		      - step summary: flake8 checks our Python codebase for errors, styling issues and complexity, given a filepath (such as the one in our workflow); flake8 check the 'app_test.py' in the 'src' directory file for the aforementioned issues. If the check finds issues, the step and job fail

    Editor-Conf-Check:
		- step1: Checkout code
			- requirements before step execution : none
			- step summary: checks-out the code

		- step2: Install Editor-Conf-Checker
		    - requirements before step execution : none
			- step summary: installs the Editor-Conf-Checker app

            - step3: Editor-Conf Check
                - requirements before step execution : have the Editor-Conf-Checker installed; have an exiting .editorconfig file in your reposity with preferred file configuration.
			- step summary: Checks the files in the repository according to the .editorconfig file. If the check finds issues, the step and job fail

    MarkdownFilesCheck:
	        - step1: Checkout code
		    	- requirements before step execution : none
			- step summary: checks-out the code
    
		- step2: Markdown File Link Check
			- requirements before step execution : none
			- step summary: Executes the 'ruzickap/action-my-markdown-link-checker@v1.1.2' available in the git-hub action marketplace; the check aims to see if any broken or invalid links are present, the step and job fail, giving a description of the links that are broken/invalid. If the check finds issues, the step and job fail

    UnitTest:
	    - needs: for this job to begin the one(s) selected in the 'needs' row, they have to have finished successfully. 
    
		- step1: Prepare repo
			- requirements before step execution : none
			- step summary: checks-out the code
  
		- step2: Set up Python
			- requirements before step execution : none
			- step summary: Sets up python using the 'actions/setup-python@v1' available in the GitHub Marketplace.

	        - step3: Install requirements
			     - requirements before step execution : set-up python; have an existing requirements.txt with requirements for dependancies to install before next step
			     - step summary: uses python install dependencies using a filepath such as the one is our workflow (src/requirements.txt).

	        - step4: Test
			     - requirements before step execution : set-up python; installed dependancies;
			     - step summary: uses python to unittest a file throught its file path; in our example that file is app_test.py. If the test finds issues, the step and job fail
 
    GitLeaksCheck:
	    - needs: for this job to begin the one(s) selected in the 'needs' row, they have to have finished successfully. 
    
		- step1: Checkout code
			- requirements before step execution : none
			- step summary: checks-out the code
  
		- step2: Gitleaks check
		  - requirements before step execution : none
		  - step summary: uses the 'gitleaks/gitleaks-action@v2' action and the secret our GITHUB_TOKEN, which scans in order to find potential security vulnerabilities in our git repositories, files, and directories. If the check finds security leaks, the step and job fail.

    DB-Migration-Test:
	    - needs: for this job to begin the one(s) selected in the 'needs' row, they have to have finished successfully. 
    
		- step1: 
			 - requirements before step execution : none
		     - services: sets up postgres service with image:postgres with env variables of the db(database), username and password, and with the options below
			 - step summary: checks-out the code with git-hub action; executes the joshuaavalon/flyway-action@v3.0.0 to a given postgres db, which checks for any db migrations that have been added or been requested
  
    CodeCov:
	    - needs: for this job to begin the one(s) selected in the 'needs' row, they have to have finished successfully. 
    
		- step1: Checkout code
			- requirements before step execution : none
			- step summary: checks-out the code

	        - step2: Set up Python
			- requirements before step execution : none
			- step summary: Sets up python using the 'actions/setup-python@master' available in the GitHub Marketplace. Sets-up specifically python-version: 3.7 (could be another version, chosen by the writer of the workflow)

	        - step3: Check code coverage
			- requirements before step execution : have python set-up from previous step in the current job; have added the CODECOV_TOKEN secret in the repositories secrets (Repo->Settings->Secrets and Variables->Add secret); have an account in CodeCov website in order to generate the Codecov token)
			- step summary: Uses to check for code coverage files using the 'codecov/codecov-action@v3' action; If any are found, they are checked, if none are found, step finishes. If any issues are found, the step and job fail

    SnykTest:
	    - needs: for this job to begin the one(s) selected in the 'needs' row, they have to have finished successfully. 
    
		- step1: Checkout code
			- requirements before step execution : none
			- step summary: checks-out the code

	        - step2: Run Snyk Security Check
			- requirements before step execution : have added the SNYK_TOKEN secret in the repositories secrets; have an account in Snyk website in order to generate the SNYK_TOKEN)
			- step summary: Installs the needed requirements described in command format in the src/requirements.txt; Installs snyk app; uses SNYK_TOKEN to authenticate user; snyk tests for security vulnerabilities in /src. If the check finds security issues, the step and job fail

    SonarCloudTest:
	    - needs: for this job to begin the one(s) selected in the 'needs' row, they have to have finished successfully. 
    
		- step1: Checkout code
			- requirements before step execution : none
			- step summary: checks-out the code

	        - step2: SonarCloud Scan
			- requirements before step execution : have added the SONAR_TOKEN secret in the repositories secrets; have an account in SonarCloud website in order to follow the sites instructions on how to generate the SONAR_TOKEN); sonar-project.properties files(also generated from the SonarCloud site)
			- step summary: Uses the 'sonarsource/sonarcloud-github-action@master' with env the GITHUB_TOKEN and the SONAR_TOKEN to complete the scan. If the check finds issues, the step and job fail	 
  
    SecScan2:
	    - needs: for this job to begin the one(s) selected in the 'needs' row, they have to have finished successfully. 
    
		- step1: Checkout code
			- requirements before step execution : none
			- step summary: checks-out the code

	        - step2: Perform Scan
			- requirements before step execution : none
			- step summary: performs a security scan on all files, written with PYTHON code in the current working repo directory,using the 'ShiftLeftSecurity/scan-action@master'.If the check finds security issues, the step and job fail	

    Codacy-Analysis-CLI:
	    - needs: for this job to begin the one(s) selected in the 'needs' row, they have to have finished successfully. 
    
		- step1: Checkout code
			- requirements before step execution : none
			- step summary: checks-out the code

	        - step2: Run Codacy Analysis CLI
			- requirements before step execution : none
			- step summary: the 'codacy/codacy-analysis-cli-action@master' action analyzes each commit or pull request by running all supported static code analysis tools for the languages found in the repository, prints the analysis results on the console, which is visible on the GitHub Action's workflow panel. It also Fails the workflow if it finds at least one issue in the code.   

    Build_Push:
	    - needs: for this job to begin the one(s) selected in the 'needs' row, they have to have finished successfully. 
    
		- step1: Checkout code
			- requirements before step execution : none
			- step summary: checks-out the code

	        - step2: Docker Login
			- requirements before step execution : have an existing Docker account; have the account's login data(email and password to docker.io) saved as repo secrets - DOCKER_USERNAME, DOCKER_PASSWORD
			- step summary: logins to Docker with the saved login secrets	

		- step3: Build an image
			- requirements before step execution : have a valid Dockerfile in the repository
			- step summary: creates the Docker image with the name "my_first_app"(the image name is customizable)
		
		- step4: AquaSec Trivy
			- requirements before step execution : have a built Docker image
			- step summary: uses aquasecurity/trivy-action@0.13.1 to scan the image for vulnarabilities. If it finds any CRITICAL ones, it fails the job.
		
		- step5: Tag an image
			- requirements before step execution : have a Docker built image
			- step summary: tags my_first_app image
		
		- step6: Push Image to Dockerhub
			- requirements before step execution : have a tagged built image; be logged-in Docker
			- step summary: pushes the tagged image on Dockerhub


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



## Used apps

 - [Flake8](https://flake8.pycqa.org/)
 - [Editorconfig-checker](https://github.com/editorconfig-checker/editorconfig-checker)
 - [MarkdownFilesCheck](https://github.com/ruzickap/action-my-markdown-link-checker)
 - [Unittest Python](https://docs.python.org/3/library/unittest.html)
 - [GitLeaksCheck](https://github.com/gitleaks/gitleaks-action)
 - [Flyway Check](https://github.com/joshuaavalon/flyway-action)
 - [CodeCov](https://about.codecov.io/tool/github-actions/)
 - [Snyk](https://snyk.io/)
 - [SonarSource's SonarCloud](https://github.com/SonarSource/sonarcloud-github-action)
 - [Security Scan/SecScan2](https://github.com/ShiftLeftSecurity/scan-action)
 - [Codacy Code Analysis CLI](https://github.com/codacy/codacy-analysis-cli-action)
 - [Aqua Trivy Scan](https://github.com/aquasecurity/trivy-action/releases)
 - [Docker](https://www.docker.com/)
 - [Kubernetes - used for 2nd deep dive](https://kubernetes.io/)



