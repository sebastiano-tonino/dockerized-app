mariadb db_development -u db_user_development


docker-compose down -v
docker-compose up --build -d


docker buildx build -t stonino/flask-app:latest --push .


docker buildx create --name mybuilder --driver docker-container --use
docker buildx inspect --bootstrap
docker buildx build --platform linux/amd64,linux/arm64 -t stonino/flask-app:latest --push

# Kubernetes
helm install --debug --dry-run flask-app .\charts\ 
helm install flask-app .\charts\ 

helm repo add bitnami https://charts.bitnami.com/bitnami
helm dependency build update charts
helm install flask-app charts --namespace flask-app --create-namespace


kubectl get pods -n flask

Sapere IP:
kubectl get svc -n flask


kubectl describe pod flask

Scalare pod
kubectl scale -n flask-app deployment flask-app --replicas=1


Per loadbalancer:
service:
  type: LoadBalancer
  port: 80

kubectl port-forward service/flask-app-service 80:80


