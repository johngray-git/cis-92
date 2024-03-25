# My CIS-92 Project 

This repository contains the code for my CIS-92 kebernetes application.

By: John Gray

Kubernetes Application documentation
<br /><br />

From config.yaml
| Variable Name | Default Value | Description |
|---|---|---|
| STUDENT_NAME | "John Gray" | Name of Student |
| SITE_NAME | "*" | Name of site |
| DATA_DITR | "/data" | Database location |
| DEBUG | "1" | Debug enabled |
<br />

From secret.yaml
| Variable Name | Default Value | Description |
|---|---|---|
| SECRET_KEY | "this-is-a-bad-key" | text key to securing signed data |


<br />
<h3>Start up</h3>
kubectl apply -f deployment/
<br />

<h3>Initialization</h3>
kubectl exec --stdin --tty pod/mysite-pod -- /bin/bash<br />
python manage.py migrate<br />
python manage.py createsuperuser

<h3>Deletion</h3>
kubectl delete service/mysite-svc pod/mysite-pod

