1. before creating a cluster vistin in browser:
https://console.cloud.google.com/kubernetes/list


https://github.com/waprin/kubernetes_django_postgres_redis
https://medium.com/google-cloud/deploying-django-postgres-redis-containers-to-kubernetes-9ee28e7a146#.q5fccfpzi
https://engineering.adwerx.com/rails-on-kubernetes-8cd4940eacbe#.65qqj8ajn

gcloud components install kubectl

gcloud auth application-default login

gcloud config set compute/zone europe-west1-d

gcloud config set project hulldev-michaloo

gcloud container clusters create hulldev

gcloud container clusters get-credentials hulldev

gcloud compute disks create db-data --size 100GB

kubectl apply -f kubernetes_configs/persistent-volumes.yml
kubectl apply -f kubernetes_configs/redis/redis.yml
kubectl apply -f kubernetes_configs/memcached/memcached.yml
kubectl apply -f kubernetes_configs/elasticsearch/elasticsearch.yml
kubectl apply -f kubernetes_configs/postgres/postgres.yml
kubectl apply -f kubernetes_configs/mongo/mongo.yml


docker build -t hull .
docker tag hull us.gcr.io/hulldev-michaloo/hull:v1
gcloud docker push us.gcr.io/hulldev-michaloo/hull:v1
