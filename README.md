# kubesible-with-kustomize

## Usage

### init
```
$ sh install.sh
```

### scaffold
```
$ kubesible gen-scaffold sample_project ./
```

### linked to files
```
# kustomize file path
$ cd <kustomizes path>
$ ln -s  <files dir path>

# kubeconfig path
$ cd <kubeconfig path>
$ ln -s  <files dir path>
```

#### Notice
kustomize dir is prefered down below
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

### playbook
```
$ kubesible playbook . sample_project/tasks/default.yaml sammple_project/vars/dev.yaml --dry_run
```

