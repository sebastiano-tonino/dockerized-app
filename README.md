# Flask System Monitor Application

A Flask-based web application that provides system metrics and database information through REST APIs.

## Features

- System metrics monitoring (CPU, Memory, OS)
- MariaDB connection and version information

## Prerequisites

- Python 3.x
- Docker
- Minikube(Optional)
- Kubectl
- Kubernetes cluster
- Helm 

## Local Development

1. Create a virtual environment and install dependencies:

```sh
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
```

2. Set up environment variables:

```sh
export DB_HOST=localhost
export DB_USER=db_user
export DB_PASSWORD=password
export DB_NAME=db_development
export DB_PORT=3306
```
Or save the env vars in a .env file

3. Run the application:

```sh
python app.py
```

The application will be available at `http://localhost:5000`

## API Endpoints

- `GET /app/system-data` - Returns system metrics (CPU usage, memory usage, OS)
- `GET /app/database-data` - Returns MariaDB version information

## Dependencies

- Flask==3.0.0
- psutil>=7.1.1
- mysql-connector-python>=9.0.0

## Test in local

1. Build and run using Docker Compose:

```sh
docker-compose up --build -d
```

2. Stop containers:

```sh
docker-compose down
```
Stop and remove containers:
```sh
docker-compose down -v
```

## Docker build 
1. To build docker image:
```sh
docker buildx build -t your-account/image-name:latest --push .
```
To build for multiplatform:
```sh
docker buildx create --name mybuilder --driver docker-container --use
docker buildx inspect --bootstrap
docker buildx build --platform linux/amd64,linux/arm64 -t stonino/flask-app:latest --push
```

## Kubernetes Deployment

1. Add Bitnami Helm repository:

```sh
helm repo add bitnami https://charts.bitnami.com/bitnami
```

2. Update Helm dependencies:

```sh
helm dependency update charts
```

3. Install the application:

```sh
helm install flask-app charts --namespace testing --create-namespace
```

4. Verify the deployment:
```sh
kubectl get pods -n testing
kubectl get svc -n testing
```

5. Scale the application(if you want)
```sh
kubectl scale -n testing deployment flask-app --replicas=1
```

Port forward:
```sh
kubectl port-forward service/flask-app-service 80:80 -n testing
```
## Configuration

The application can be configured through environment variables in .env file:

- `DB_HOST` - Database host
- `DB_USER` - Database user
- `DB_PASSWORD` - Database password
- `DB_NAME` - Database name
- `DB_PORT` - Database port (default: 3306)

For kubernetes chaging the values in charts/values.yaml or better passing value when you launch helm install command.
```sh
helm install flask-app ./charts  -n testing --create-namespace --set database.user=dev ....
```

> **Warning**
> The deployment of the helm templates has only been tested on minikube 




