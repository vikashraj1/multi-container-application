# Multi-Container Todo API 🌐

Complete CI/CD pipeline of an unauthenticated Node.js REST API

> This project is created as part of the [Multi-Container Application](https://roadmap.sh/projects/multi-container-service) project.

## Overview 📚

- **API:** Node.js with Express & Mongoose.
- **Database:** MongoDB with persistent volumes.
- **Containerization:** Docker and Docker Compose.
- **Reverse Proxy:** NGINX.
- **Infrastructure & Config:** Vagrant (or Terraform) & Ansible.
- **CI/CD:** GitHub Actions to build and push to Docker Hub, and deploy.

## API Endpoints 🔗

- `GET /todos` — List all todos.
- `GET /todos/{id}` — Get a todo by ID.
- `POST /todos` — Create a todo (JSON payload with `title`, `description`, `completed`).
- `PUT /todos/{id}` — Update a todo.
- `DELETE /todos/{id}` — Delete a todo.

### Example (using curl):

```bash
curl -X POST http://todoapi.app/todos \
  -H "Content-Type: application/json" \
  -d '{"title": "My Todo", "description": "Todo description", "completed": false}'
```

---

## Project Setup (using Vagrant) 🛠

**Prerequisites:**  
- At least 4GB free RAM  
- [Vagrant](https://www.vagrantup.com/) and a supported provider (e.g., VirtualBox) installed  
- Git installed  
- Dockerhub account and a repository

 **Prepare the Infrastructure Directory:**
   - Create and navigate to your project directory:
     ```bash
     mkdir todoapi-project
     cd todoapi-project
     ```
   - Download `Vagrantfile`:
     ```bash
     curl -kO https://raw.githubusercontent.com/vikashraj1/multi-container-application/refs/heads/main/Infra/vagrant/Vagrantfile
     ```
   - Create a shared folder and clone the project repository:
     ```bash
     mkdir shared
     git clone https://github.com/vikashraj1/multi-container-application.git shared
     ```

 **Start Vagrant Environment:**
   - Bring up and ssh into ansible VM:
     ```bash
     vagrant up && vagrant ssh ansible
     ```


 **Docker Setup**
   - Create dockerhub account and a repository

   - In the `docker-compose.yml` file, update the `image` field with your Docker Hub repository. *Also change `tag` in `docker-publish.yml` for the GitHub Actions workflow*


   - Export your Docker Hub credentials:
     ```bash
     export DOCKER_USERNAME=your_docker_username
     export DOCKER_PASSWORD=your_docker_password
     ```
   - Also add these credentials as secrets in your GitHub repository for GitHub Actions workflow to push image to your dockerhub repository


 **Deploy the Application with Ansible:**

   - switch to root user and navigate to `/root/shared/ansible_code` directory
     ```bash
     sudo su -
     cd /root/shared/ansible_code
     ```

   - Run the playbook:
     ```bash
     ansible-playbook -i inventory playbook.yml
     ```

 **Test the API:**
   - Verify that the API is running:
     ```bash
     curl http://todoapi.app
     curl http://todoapi.app/todos
     ```

---

## Project Setup (using Terraform) 🏗️

> **Note:** I have tested it using [LocalStack](https://localstack.cloud/) only.  

**Prerequisites:**  
- Docker Hub credentials  
- AWS CLI
- Terraform installed


**Setup**

- config aws creds using aws-cli
    ```bash
    aws config
    ```


- *(Tip: In `infra/terraform/sg.tf`, add your public IP address to the `allow_ssh_ipv4` list to ensure secure SSH access.)*


- Plan and apply your Terraform configuration:
    ```bash
    terraform plan
    terraform apply
    ```

- In the `ansible_code/inventory` file, replace the values of `ansible_host` and `ansible_user` with public IP of the EC2 instance.

- Add `DOCKER_USERNAME` and `DOCKER_PASSWORD` credentials as secrets for GitHub Actions workflow.

- push the new code in your repo

- wait for the GitHub Actions workflow to complete

**Test the API:**
   - Once your infrastructure is deployed, test the API using the public IP of your EC2 instance:
     ```bash
     curl http://<public-ip-of-ec2-instance>
     curl http://<public-ip-of-ec2-instance>/todos
     ```