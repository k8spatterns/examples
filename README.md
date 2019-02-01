
<!--- <a href="https://leanpub.com/k8spatterns"><img src="https://s3.amazonaws.com/titlepages.leanpub.com/k8spatterns/hero?1492193906" align="right" width="300px" style="float:right; margin: 50px 0px 20px 30px;"/></a> -->

# Kubernetes Patterns - Examples

This GitHub project contains the examples from the "Kubernetes Patterns" book by [Bilgin Ibryam](https://github.com/bibryam) and [Roland Huß](https://github.com/rhuss) (_to be announced soon_)
Each of the examples is contained in an extra directory per pattern and is self contained.

Installation instructions for running the examples are summarized in an extra [installation](INSTALL.adoc) page.
By default, you just need a vanilla Kubernetes installation.
If addons are required, the example description explains this additional requirement.

For feedback, issues or questions in general, please use the [issue tracker](https://github.com/bibryam/k8spatterns/issues) to open issues.

## Patterns

### Foundational Patterns

* [Predictable Demands](foundational/PredictableDemands/README.adoc) - Our sample random generator dealing with hard requirements on ConfigMap and PersistentVolumeClaims as well as with resource limits.

* [Dynamic Placement](foundational/DynamicPlacement/README.adoc) -

* [Declarative Deployment](foundational/DeclarativeDeployment/README.adoc) - Rolling and fixed update of the random generator Deployment from version 1.0 to 2.0.

* [Observable Interior](foundational/ObservableInterior/README.adoc) - Liveness and Readiness checks for the random generator.

* [Life Cycle Conformance](foundational/LifeCycleConformance/README.adoc) -

### Behavorial Patterns

* [Batch Job](behavorial/BatchJob/README.adoc) -

* [Scheduled Job](behavorial/ScheduledJob/README.adoc) -

* [Daemon Service](behavorial/DaemonService/README.adoc) -

* [Singleton Service](behavorial/SingletionService/README.adoc) -

* [Self Awareness](behavorial/SelfAwareness/README.adoc) -

### Structural Patterns

* [Sidecar](structural/Sidecar/README.adoc) - Git polling example for a sidecar

* [Init Container](structural/InitContainer/README.adoc) -

* [Ambassador](structural/Ambassador/README.adoc) -

* [Adapter](structural/Adapter/README.adoc) -

### Configuration Patterns

* [Envvar Configuration](configuration/EnvvarConfiguration/README.adoc) -

* [Configuration Resource](configuration/ConfigurationResource/README.adoc) -

* [Configuration Template](configuration/ConfigurationTemplate/README.adoc) - an example how to use a template configuration `standalone.xml` which is processed with a template processed and filled with data from `ConfigMap` before a Wildly server is started.

* [Immutable Configuration](configuration/ImmutableConfiguration/README.adoc) - several examples how to use immutable configuration containers for application configuration. This includes examples for the plain Docker case and for Kubernetes.

### Advanced Patterns

* [Stateful Service](advanced/StatefulService/README.adoc) -

* [Controller](advanced/Controller/README.adoc) - a simple, pure shell based controller which watches `ConfigMap` resources for changes and restarts `Pods` by using a label selector provided as annotation. An additional [example controller](advanced/Controller/expose-controller/README.adoc) exposes an `Ingress` route when it detects an `exposeService` label attached to the service.

* [Operator](advanced/Operator/README.adoc) - operator based on the `ConfigMap` watch [controller](advanced/Controller/README.adoc) and introduces a CRD `ConfigWatcher` which connects a `ConfigMap` with a set of `Pods` to restart in case of a config change.

* [Image Builder](advanced/ImageBuilder/README.adoc) - setup a [chained build](advanced/ImageBuilder/openshift/README.adoc) on OpenShift and use [Knative build](advanced/ImageBuilder/knative/README.adoc) for doing builds within the cluster.

* [ElasticScale](advanced/ElasticScale/README.adoc) -
