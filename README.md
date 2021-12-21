# Terraform GKE Cluster with Nginx and Ghost Deployments  


This module provides  the creation of a Kubernetes Engine cluster  with a custom network with a secondary ranges to be use by the GKE cluster, also it creates 2 deployments an Nginx with 3 replicas and a Ghost with 2 replicas using NodePort and it has a google ingress controller to expose both deployments.

## Compatibility

This module is meant for use with 
```Terraform v1.0.11``` 
And  
```provider registry.terraform.io/hashicorp/google v4.2.1```

## Limits

The GKE cluster is going to contain only 2 nodes.
The GKE cluster is a zonal type
It creates 2 deployments an Nginx with 3 replicas and a Ghost with 2 replicas using NodePort



## Requirements
Before this module can be used on a project, you must ensure that the following pre-requisites are fulfilled:

   1.-Terraform and kubectl are installed on the machine where Terraform is executed.

   2.-The Service Account you execute the module with has the right permissions.
      
      roles/compute.viewer

      roles/compute.securityAdmin 

      roles/container.clusterAdmin

      roles/container.developer

      roles/iam.serviceAccountAdmin

      roles/iam.serviceAccountUser

      roles/resourcemanager.projectIamAdmin 

   3.-The Compute Engine and Kubernetes Engine APIs are active on the project you will launch the cluster in.

## Executing Network and GKE

First execute the network and after that execute the GKE with the below commands

```python

# To get the plugins
terraform init

# To see the infrastructure plan
terraform plan

# To apply the infrastructure build
terraform apply
```
## Connect to GCP console

to connect to your GKE cluster execute the below command
```python

gcloud container clusters get-credentials gke-cluster-name --zone zone-name
```

## Executing the Deployments

Once you have created the Network and the GKE you can execute the deployments with the below commands:

```python

# To apply the ghost deployment
kubectl apply -f ghost/deployment_ghost.yaml 

$ kubectl get deployments
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
deployment-ghost   2/2     2            2           8s 

# To apply the service ghost
kubectl apply -f ghost/service_ghost.yaml

$ kubectl get services
NAME            TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
kubernetes      ClusterIP      192.170.0.1    <none>        443/TCP        66m
service-ghost   LoadBalancer   192.170.2.43   <pending>     80:30802/TCP   9s 


# To apply the nginx deployment
kubectl apply -f nginx/deployment_nginx.yaml

$ kubectl get deployments
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
deployment-ghost   2/2     2            2           64s
deployment-nginx   3/3     3            3           10s

# To apply the service nginx
kubectl apply -f nginx/service_nginx.yaml 

$ kubectl get services
NAME            TYPE           CLUSTER-IP      EXTERNAL-IP    PORT(S)          AGE
kubernetes      ClusterIP      192.170.0.1     <none>         443/TCP          66m
service-ghost   LoadBalancer   192.170.2.43    35.194.1.191   80:30802/TCP     64s
service-nginx   LoadBalancer   192.170.0.232   <pending>      8080:30991/TCP   6s

# To apply the ingress
kubectl apply -f ingress_ghost_and_nginx.yaml

$ kubectl get ingress
NAME                      CLASS    HOSTS                                                 ADDRESS          PORTS   AGE
ingress-ghost-and-nginx   <none>   service-ghost.example.com,service-nginx.example.com   34.149.93.55     80      19h

```
Go to kubernetes Engine > services & Ingress > Ingress and now you should be able to see the follow in gcp console:
<img width="689" alt="GKE1" src="https://user-images.githubusercontent.com/78040799/147002250-7a0609c2-6ac2-452b-a511-3d08c2ff5826.PNG">

Now go to Frontends and click on the ip or in the url you should be able to see the following:
For Ghost:
<img width="760" alt="Ghost" src="https://user-images.githubusercontent.com/78040799/147002743-060b858b-8522-4a15-9c2f-ebde342fc5ae.PNG">

For Nginx:
<img width="611" alt="nginx" src="https://user-images.githubusercontent.com/78040799/147002786-458d5266-19c6-4b81-893b-a5a2d2309aac.PNG">

## Additional Comments
Please be informed that for this purpose we comment the following line since the first time we create and authorize network using a public ip, but once you restart your device your public IP will change and this could affect the funcionality


```python

master_authorized_networks = [
    {
      cidr_block   = "187.233.16.82/32"
      display_name = "internet"
    }
```
# Authors
|        Name       |
|-------------------|
|  Karen Dominguez  |

<img width="863" alt="Task2" src="https://user-images.githubusercontent.com/78040799/147002823-8dea8d20-e457-4806-9684-db68bf47c7a8.png">
