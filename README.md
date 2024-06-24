# Etcd Helper

A helper tool for getting OpenShift/Kubernetes data directly from Etcd.

This is a copy of <https://github.com/openshift/origin/tree/master/tools/etcdhelper> with Docker support.

## How to Use

### Connecting to Etcd

* Connect the Docker container's network with the Etcd server, or connect by using the `endpoint` parameter.

### Output in JSON Format

```bash
docker run --rm --network container:etcd-server cr.sihe.cloud/docker.io/psychopurp/etcdhelper:latest /bin/sh -c "
    etcdhelper get /registry/deployments/default/nginx-deployment
"
```

### Output in YAML Format

* Using yq to convert JSON to YAML format:

```bash
docker run --rm --network container:etcd-server cr.sihe.cloud/docker.io/psychopurp/etcdhelper:latest /bin/sh -c "
    etcdhelper get /registry/deployments/default/nginx-deployment
" | yq -P e -
```

## How to build

```bash
go build .
```

## Basic Usage

This requires setting the following flags:

* `-key` - points to `master.etcd-client.key`
* `-cert` - points to `master.etcd-client.crt`
* `-cacert` - points to `ca.crt`

Once these are set properly, one can invoke the following actions:

* `ls` - list all keys starting with prefix
* `get` - get the specific value of a key
* `dump` - save the entire contents of etcd to individual files

## Sample Usage

List all keys starting with `/openshift.io`:

```
etcdhelper -key master.etcd-client.key -cert master.etcd-client.crt -cacert ca.crt ls /openshift.io
```

Get YAML-representation of `imagestream/python` from `openshift` namespace:

```
etcdhelper -key master.etcd-client.key -cert master.etcd-client.crt -cacert ca.crt get /openshift.io/imagestreams/openshift/python
```

Dump the contents of etcd to yaml files:

```
etcdhelper -key master.etcd-client.key -cert master.etcd-client.crt -cacert ca.crt dump
```
