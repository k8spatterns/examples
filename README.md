
<a href="https://leanpub.com/k8spatterns"><img src="https://s3.amazonaws.com/titlepages.leanpub.com/k8spatterns/hero?1492193906" align="right" width="300px" style="float:right; margin: 50px 0px 20px 30px;"/></a>

# Kubernetes Patterns - Examples

This GitHub project contains the examples from the [Kubernetes Patterns](https://leanpub.com/k8spatterns) book by [Bilgin Ibryam](https://github.com/bibryam) and [Roland Huß](https://github.com/rhuss).
Each of the examples is contained in an extra directory and is self contained.

[minikube](https://github.com/kubernetes/minikube) is recommended not only for trying out theses examples but also for an easy and simple to use Kubernetes setup in general.

ALternatively you can also try out these examples on the [Kubernetes Playground](https://www.katacoda.com/courses/kubernetes/playground) or [Play with Kubernetes](https://labs.play-with-k8s.com/).

For feedback, issues or questions in general, please use the [issue tracker](https://github.com/bibryam/k8spatterns/issues) to open issues.

## Patterns

### Foundational Patterns

### Behavorial Patterns

### Structural Patterns

* [Sidecar](structural/Sidecar/README.adoc) - Git polling example for a sidecar

### Configuration Patterns

* [Configuration Template](configuration/ConfigurationTemplate/README.adoc) - an example how to use a template configuration `standalone.xml` which is processed with a template processed and filled with data from `ConfigMap` before a Wildly server is started.

* [Immutable Configuration](configuration/ImmutableConfiguration/README.adoc) - several examples how to use immutable configuration containers for application configuration. This includes examples for the plain Docker case and for Kubernetes.

### Advanced Patterns

* [Controller](advanced/Controller/README.adoc) is a simple, pure shell based controller which watches `ConfigMap` resources for changes and restarts `Pods` by using a label selector provided as annotation. An additional [example controller](advanced/Controller/expose-controller/README.adoc) exposes an `Ingress` route when it detects an `exposeService` label attached to the service.

* [Operator](advanced/Operator/README.adoc) is based on the `ConfigMap` watch [controller](advanced/Controller/README.adoc) and introduces a CRD `ConfigWatcher` which connects a `ConfigMap` with a set of `Pods` to restart in case of a config change.

* [ImageBuilder](advanced/ImageBuilder/README.adoc) shows you how you can setup a [chained build](advanced/ImageBuilder/openshift/README.adoc) on OpenShift and how to use [Knative build](advanced/ImageBuilder/knative/README.adoc) for doing builds within the cluster.
