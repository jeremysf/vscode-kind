Companion repository to https://medium.com/@jeremysf/visual-studio-code-github-codespaces-kubernetes-bonkers-c85acfee5148.

Navigate to https://github.com/codespaces and click “New codespaces”. When prompted, enter `jeremysf/vscode-kind` as the repository to start your new Codespace from.

Once your codespace is running, in the built-in terminal in Visual Studio Code, run the script:

```
$ ./create_k8s_cluster.sh
```

Boom. You now have a running Kubernetes cluster. Running, but um, empty. 

Let’s populate it with some services. Run the script:

```
$ ./helm_upgrade.sh
```

A quick `kubectl get services` will show a bevy of running services:

```
$ kubectl get services
NAME                        TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                                 AGE
example-memcached           ClusterIP   10.96.146.238   <none>        11211/TCP                               44s
example-mysql               ClusterIP   10.96.180.46    <none>        3306/TCP                                44s
example-mysql-slave         ClusterIP   10.96.104.245   <none>        3306/TCP                                44s
example-nginx               NodePort    10.96.193.38    <none>        30000:30000/TCP,443:32242/TCP           44s
example-rabbitmq            ClusterIP   10.96.249.67    <none>        5672/TCP,4369/TCP,25672/TCP,15672/TCP   44s
example-rabbitmq-headless   ClusterIP   None            <none>        4369/TCP,5672/TCP,25672/TCP,15672/TCP   44s
example-redis-headless      ClusterIP   None            <none>        6379/TCP                                44s
example-redis-master        ClusterIP   10.96.106.94    <none>        6379/TCP                                44s
example-redis-slave         ClusterIP   10.96.181.250   <none>        6379/TCP                                44s
kubernetes                  ClusterIP   10.96.0.1       <none>        443/TCP                                 2m34s
```

Enjoy!