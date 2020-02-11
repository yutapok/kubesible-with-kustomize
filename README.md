# kubesible-with-kustomize

## About
- deploy tool for k8s with kustomize on respect of ansbile interface
- kubesible is treatment of handle deploy management
  - in order, collect resources per services or something you need, safety treatment secret
  - kustomize is for treatment of manifest per environment

## Dependency
```
kubectl
kustomize
python3
```

## Usage
### init install
```
$ python3 -m venv <path>
$ source <path>/bin/activate
$ sh install
```

### enc
```
$ vim files/.secret.yml
$ kubesible enc <cur_path>
$ => Info: done encrypto to ./.secret.yml.enc
```

### playbook
```
$ kubesible playbook <cur_path> <taks.yaml> <var.yaml> [--option]
option:
  --dry-run
  --skip-ignore
```

### scaffold
```
$ kubesible gen-scaffold sample_project ./
```


### Example
#### 1.scaffold
```
$ kubesible gen-scaffold sample_project ./
```
create and edit yaml
``` tasks/sample.yaml
common:
  env: {{ vars.env }}
  namespace:  {{ vars.namespace }}
  kubeconfig: {{ vars.kubeconfig }}
  kustomize:
    env_root: overlay
    env: {{ vars.kustomize.env }}

- name: create secret AWS_KEY
  kubectl:
    secret:
      name: aws-key
      literal: aws-access-key
      value: $aws_access_key_id
    type: None
```
``` vars/sample.yaml
vars:
  env: dev
  namespace: dev
  kubeconfig: k8s-cluster.conf
  kustomize:
    env: development
```

#### 2.linked to files
```
# kustomize file path
$ cd <kustomizes path>
$ ln -s  <files dir path>

# kubeconfig path
$ cd <kubeconfig path>
$ ln -s  <files dir path>
```

#### 3.enc
- edit
```
$ vim files/.secret.yml
aws_key:
  envkey: aws_access_key_id
  envval: sample
```
- run
```
$ kubesible enc .
$ => Info: done encrypto to files/.secret.yml.enc
```

#### 4.playbook
```
$ kubesible playbook . sample_project/tasks/default.yaml sammple_project/vars/dev.yaml --dry_run
# if ok
$ kubesible playbook . sample_project/tasks/default.yaml sammple_project/vars/dev.yaml
=>
 --------------------------------------------------------------------
[Complete] task: create secret AWS_KEY
StatusCode: 0
Mode: DryRun (Deploy)
Command >>
kubectl create secret generic aws-key --from-literal=aws-access-key=$aws-access-key -n dev --dry-run

Stdout >>
secret/aws-key created (dry run)
```

### Notice
- kustomize dir is prefered down below
``` sample
.kustomizes
├── base
│   ├── common
│      ├── k8s
│      │   ├── kustomization.yaml
│      │   └── secret.yaml
│      └── redis
│          ├── kustomization.yaml
│          ├── operator.yaml
│          └── redis-failover.yaml
└── overlay
    ├── common
       └── redis
           ├── development
           │   ├── kustomization.yaml
           │   └── redis-failover.yaml
           └── production
               ├── kustomization.yaml
               └── redis-failover.yaml
```

- inside program, running basicaly such as kustomize build ... | kubectl apply -f -
