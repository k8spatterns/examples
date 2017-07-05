
<a href="https://leanpub.com/k8spatterns"><img src="https://s3.amazonaws.com/titlepages.leanpub.com/k8spatterns/hero?1492193906" align="right" width="300px" style="float:right; margin: 50px 0px 20px 30px;"/></a>

# Kubernetes Patterns - Examples

This GitHub project contains the examples from the [Kubernetes Patterns](https://leanpub.com/k8spatterns) book by [Bilgin Ibryam](https://github.com/bibryam) and [Roland Huß](https://github.com/rhuss). 
Each of the examples is contained in an extra directory and is self contained.

[minikube](https://github.com/kubernetes/minikube) is recommended not only for trying out theses examples but also for an easy and simple to use Kubernetes setup in general.

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
