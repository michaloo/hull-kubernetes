## Kubernetes - Google Cloud Installation

> before creating a cluster vist in browser:
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
gcloud compute addresses create hull-external --region=europe-west1
```

**create cluster**:

```sh
gcloud container clusters create hulldev
gcloud container clusters get-credentials hulldev
```

**deploy database services**:
```sh
kubectl apply -f kubernetes-config/redis/redis.yml
kubectl apply -f kubernetes-config/memcached/memcached.yml
kubectl apply -f kubernetes-config/elasticsearch/elasticsearch.yml
kubectl apply -f kubernetes-config/postgres/postgres.yml
kubectl apply -f kubernetes-config/mongo/mongo.yml
```

**cluster dashboard**
```sh
kubectl proxy
open http://localhost:8001/ui
```

> edit `kubernetes-config/hull/hull.yml` and set ip and project name

**deploy applications**:
```sh
kubectl apply -f kubernetes-config/hull/hull.yml
kubectl apply -f kubernetes-config/hull-admin/hull-admin.yml
```

**deploy traefik router**:
```sh
kubectl apply -f kubernetes-config/traefik/config.yml
kubectl apply -f kubernetes-config/traefik/traefik.yml
kubectl apply -f kubernetes-config/traefik/ingess.yml
```


**clear the gcloud project**:
```sh
gcloud container clusters delete hulldev
# remember to remove forwarding rules from public IP if you are not removing it
```


### Inspirations

https://github.com/waprin/kubernetes_django_postgres_redis

https://medium.com/google-cloud/deploying-django-postgres-redis-containers-to-kubernetes-9ee28e7a146#.q5fccfpzi

https://engineering.adwerx.com/rails-on-kubernetes-8cd4940eacbe#.65qqj8ajn
