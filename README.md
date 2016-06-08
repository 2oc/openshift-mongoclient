# openshift-mojolicious

Template for running Mojolicious on a container based on centos linux/openshift/docker.

### Installation

You need oc (https://github.com/openshift/origin/releases) locally installed:

create a new project (change to your whishes) or add this to your existing project

```sh
oc new-project openshift-mojolicious \
    --description="WebServer - Mojolicious" \
    --display-name="Mojolicious"
```

Deploy (externally)

```sh
oc new-app https://github.com/weepee-org/openshift-mojolicious.git --name mojolicious
```

Deploy (weepee internally)
add to Your buildconfig
```yaml
spec:
  strategy:
    dockerStrategy:
      from:
        kind: ImageStreamTag
        name: mojolicious:latest
        namespace: weepee-registry
    type: Docker
```
use in your Dockerfile
```sh
FROM weepee-registry/mojolicious

# Your app
ADD app/mojo.pl /app/mojo.pl
```

#### Route.yml

Create route for development and testing

```sh
curl https://raw.githubusercontent.com/ure/openshift-mojolicious/master/Route.yaml | oc create -f -
```
