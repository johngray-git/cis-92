# My CIS-92 Project 

This repository contains the code for my CIS-92 kebernetes application.

By: John Gray

Kubernetes Application documentation
<br /><br />
## Confgiuration
### From config.yaml
| Variable Name | Default Value | Description |
|---|---|---|
| STUDENT_NAME | "John Gray" | Name of Student |
| SITE_NAME | "www.jhg-cis-92.cis-92.com" | Name of site |
| DEBUG | "1" | Debug enabled |
| POSTGRES_DB | "mysite" | Database name |
| POSTGRES_HOSTNAME | postgres-postresql | name of host |
<br />

### From secret.yaml
| Variable Name | Default Value | Description |
|---|---|---|
| SECRET_KEY | this-is-a-bad-key | text key to securing signed data |
| POSTGRES_USER | mysiteuser | PostgresSQL user name |
| POSTGRES_PASSWORD | this-is-a-bad-password | PostgresSQL password |
| POSTGRES_DB | mysite | Name of postgres DB|
<br />

Note: _The values for POSTGRES_USER and POSTGRES_PASSWORD listed in the<br/> 
secret.yaml file MUST match the values for username and postgresPassword listed<br /> 
in the values-postgres.yaml file._
### From values-postgres.yaml
| Variable Name | Default Value | Description |
|---|---|---|
| database | mysite | PostgresSQL database name |
| username | mysiteuser | PostgresSQL custom user name **|
| password | this-is-a-bad=password | Postgres custom user password ** |
| postgresPassword | this-is-a-bad-password | PostgresSQL admin user pasword | 
<br />

 _Primary.Resources.Requests_
| Resource Name | Default Value | Description |
|---|---|---|
| memory | 512Mi | Minimum memory requirement |
| cpu | 500m | Minimum CPU requirement |
| ephemeral-storage | 100Mi | Minimum storage requirement |

<br />

 _Pirimary.Resources.limits_
| Resource Name | Default Value | Description |
|---|---|---|
| memory | 512Mi | Maximum memory requirement |
| cpu | 500m | Maximum CPU requirement |
| ephemeral-storage | 100Mi | Maximum storage requirement |

<br />

## Start up 
helm install postgres oci://registry-1.docker.io/bitnamicharts/postgresql --values values-postgres.yaml<br />
kubectl apply -f deployment/ <br />
helm install external-dns external-dns/external-dns --values values-edns.yaml<br />
helm install cert-manager jetstack/cert-manager --values values-cert-manager.yaml<br />
kubectl apply -f cluster-issuer.yaml<br />
<br />

## Initialization
Initialize the Django web application.<br />
kubectl exec --stdin --tty pod/mysite-pod -- /bin/bash<br />
python manage.py migrate<br />
python manage.py createsuperuser

## Shutdown/Deletion
kubectl delete -f deployment/<br />
kubectl delete -f cluster-issuer.yaml<br />
helm uninstall cert-manager <br />
helm uninstall external-dns<br />
helm uninstall postgres<br/><br />

When in doubt the command helm list will display the running charts.

 Note: _The PostgresSQL database install via helm will allocate an eight Gig Persistent<br/> 
 Volume Claim (PVC) which will remain post helm uninstall. This PVC must be manually<br/>
 removed via kubectl, k9s or cloud specific cmd._<br />
 For example: kubectl delete pvc/data-postgres-postgresql-0

## PostgresSQL Database Access/Diagnostics ** 
kubectl port-forward service/postgres-postgresql 5432:5432<br />
psql -h localhost -U mysiteuser mysite<br /><br />
Note: _The database username and password are listed in the values-postgres.yaml file.<br />
If you change the database username and password in the values-postgres.yaml file and <br />
you already have a PVC allocated, you must delete the PVC or the original values will remain.<br />
The psql command is part of the postgresql-client package which may be installed via_<br />
sudo apt install postgresql-client
