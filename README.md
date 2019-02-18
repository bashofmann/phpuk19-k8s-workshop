# PHP UK 2019 - Kubernetes Workshop

## 0. Preparing your cluster

* Download kubectl: https://kubernetes.io/docs/tasks/tools/install-kubectl/
* Download kubeconfig of cluster and copy it to `~/.kube/config`
* Test connection to cluster:
```
$ kubectl version
Client Version: version.Info{Major:"1", Minor:"13", GitVersion:"v1.13.3", GitCommit:"721bfa751924da8d1680787490c54b9179b1fed0", GitTreeState:"clean", BuildDate:"2019-02-04T04:48:03Z", GoVersion:"go1.11.5", Compiler:"gc", Platform:"darwin/amd64"}
Server Version: version.Info{Major:"1", Minor:"13", GitVersion:"v1.13.3", GitCommit:"721bfa751924da8d1680787490c54b9179b1fed0", GitTreeState:"clean", BuildDate:"2019-02-01T20:00:57Z", GoVersion:"go1.11.5", Compiler:"gc", Platform:"linux/amd64"}
```
* Create your own namespace to work in:
```
$ kubectl create namespace <your name>
namespace/<your name> created
```
* Change your default context to your namespace:
```
$ kubectl config set-context default --namespace=<your name>
Context "default" modified.
```
* Make configs individual
```
./apply-your-name.sh
```

## 1. Simple Web Application

* Build docker image
```
docker build -t bashofmann/k8s-workshop-web-application:1.0.0 01.simple-application/web-application/
```
* Deploy application
```
kubectl apply -f 01.simple-application/web-application/deployment/
```
* Get external IP from LoadBalancer Service
```
kubectl get service web-application
```

## 2. Simple Web Application with Ingress and TLS

* Build docker image
```
docker build -t bashofmann/k8s-workshop-web-application:2.0.0 02.ingress-lb-and-tls/web-application/
```
* Deploy application
```
kubectl apply -f 02.ingress-lb-and-tls/web-application/deployment/
```
* Get external URL from ingress
```
kubectl get ingress web-application
```

## 3. ConfigMaps and Secrets

* Build docker image
```
docker build -t bashofmann/k8s-workshop-web-application:3.0.0 03.configmaps-and-secrets/web-application/
```
* Deploy application
```
kubectl apply -f 03.configmaps-and-secrets/web-application/deployment/
```

## 4. Helm

* Build docker image
```
docker build -t bashofmann/k8s-workshop-web-application:4.0.0 04.helm/web-application
```
* Deploy application
```
helm upgrade --install <yourname>-web-application 04.helm/web-application/helm/web-application -f 04.helm/web-application/my-values.yaml
```
* See deployed applications
```
helm ls
```

## 5. Service Discovery

* Build docker image
```
docker build -t bashofmann/k8s-workshop-web-application:4.0.0 05.service-discovery/web-application
```
* Update application
```
helm upgrade --install <yourname>-web-application 05.service-discovery/web-application/helm/web-application -f 05.service-discovery/web-application/my-values.yaml
```
* Build and deploy quote-svc
```
docker build -t bashofmann/k8s-workshop-quote-svc:1.0.0 05.service-discovery/quote-svc/
kubectl apply -f 05.service-discovery/quote-svc/deployment/
```
* Build and deploy hell0-svc
```
docker build -t bashofmann/k8s-workshop-hello-svc:1.0.0 05.service-discovery/hello-svc/
kubectl apply -f 05.service-discovery/hello-svc/deployment/
```
