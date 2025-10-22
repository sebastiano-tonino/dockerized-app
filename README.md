mariadb db_development -u db_user_development


docker-compose down -v
docker-compose up --build -d

docker buildx build -t stonino/flask-app:latest --push .

# Kubernetes
helm install --debug --dry-run flask-app .\charts\ 
helm install flask-app .\charts\ 

helm dependency update flask-chart/
helm install my-flask flask-chart/ --namespace flask --create-namespace


kubectl get pods -n flask

Sapere IP:
kubectl get svc -n flask


kubectl describe pod flask

Scalare pod
kubectl scale -n default deployment flask-app --replicas=1


Per loadbalancer:
service:
  type: LoadBalancer
  port: 80

kubectl port-forward service/flask-app-service 80:80


