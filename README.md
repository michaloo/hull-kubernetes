## Kubernetes - Google Cloud Installation

1. before creating a cluster vist in browser:
https://console.cloud.google.com/kubernetes/list

**inital setup**:

```sh
gcloud components install kubectl
gcloud auth application-default login
gcloud config set compute/zone europe-west1-d
gcloud config set project hulldev-michaloo
```


**prepare disk and IP**:
```sh
gcloud compute disks create db-data --size 200GB
gcloud compute addresses create hull-external --region=europe-west1
gcloud compute addresses create hull-dashboard-external --region=europe-west1
```

**create cluster**:

```sh
gcloud container clusters create hulldev
gcloud container clusters get-credentials hulldev
```

**deploy services**:
```sh
kubectl apply -f kubernetes_configs/persistent-volumes.yml
kubectl apply -f kubernetes_configs/redis/redis.yml
kubectl apply -f kubernetes_configs/memcached/memcached.yml
kubectl apply -f kubernetes_configs/elasticsearch/elasticsearch.yml
kubectl apply -f kubernetes_configs/postgres/postgres.yml
kubectl apply -f kubernetes_configs/mongo/mongo.yml
```

**cluster dashboard**
```sh
kubectl proxy
open http://localhost:8001/ui
```

> edit `kubernetes_configs/hull/hull.yml` and set ip and project name

**deploy application (needs copying Dockerfile to hull/hull)**:
```sh
docker build -t hull .
docker tag hull eu.gcr.io/hulldev-michaloo/hull:v2
gcloud docker -- push eu.gcr.io/hulldev-michaloo/hull:v2
kubectl apply -f kubernetes_configs/hull/hull.yml
```



### Inspirations

https://github.com/waprin/kubernetes_django_postgres_redis

https://medium.com/google-cloud/deploying-django-postgres-redis-containers-to-kubernetes-9ee28e7a146#.q5fccfpzi

https://engineering.adwerx.com/rails-on-kubernetes-8cd4940eacbe#.65qqj8ajn
