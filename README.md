
![Github Actions](https://github.com/user-attachments/assets/0a3260a7-dd05-433a-a789-58ca446693b5)
<h1>Automated CI/CD Pipeline for a Node.js App using GitHub Actions ,Kubernetes and ArgoCD</h1>
Part 1: Continuous Integration (CI) - Building and Testing
Source Code Commit: The process begins when a developer pushes new code or changes to a source code repository, which is hosted on a platform like GitHub.

GitHub Actions Trigger: This push automatically triggers a predefined workflow in GitHub Actions. GitHub Actions serves as the Continuous Integration (CI) server.

Install Dependencies: The first step in the workflow is $npm install$. This command installs all the necessary project dependencies for a Node.js application.

Run Tests: After dependencies are installed, automated tests are executed to check for errors and ensure the new code doesn't break existing functionality. The diagram shows a "Yes" path, indicating that the pipeline only continues if all tests pass. If tests fail, the pipeline stops and notifies the developer.

Build and Push Docker Image:

Once the tests pass, the workflow logs into a container registry, in this case, Docker Hub.

It then builds a new Docker image from the source code. This image packages the application and all its dependencies into a single, portable container.

This new image is then "pushed" (uploaded) to Docker Hub, tagged with a unique identifier (like a version number or commit hash).

Part 2: Continuous Deployment (CD) - Deploying with GitOps
This part of the pipeline uses a GitOps methodology, where a Git repository is the single source of truth for the desired state of the application. ArgoCD is the tool used to implement this.

Image Updater: A tool, represented here as "Image updater" (like ArgoCD Image Updater or a similar utility), is constantly watching Docker Hub for new versions of the application image.

Update Manifest Repo: When the Image Updater detects the new image that was just pushed, it automatically commits a change to a separate Git repository, the "Manifest repo". This repository contains the Kubernetes configuration files (manifests) that define how the application should be deployed. The change updates the image tag in the deployment manifest to point to the new version.

ArgoCD Detects Change: ArgoCD is configured to continuously monitor the "Manifest repo". It detects the commit made by the Image Updater and sees that the desired state defined in Git has changed.

Sync and Deploy: ArgoCD compares the desired state (from the Git repo) with the actual state of the application running in the Kubernetes cluster.

Recognizing they are out of sync, ArgoCD pulls the updated manifest from the repo and the corresponding new Docker image from Docker Hub.

It then applies the new configuration to the Kubernetes cluster, which triggers a rolling update to deploy the new version of the application with zero downtime.
