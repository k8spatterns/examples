# Gomplate Wrapper

<img src="https://s3.amazonaws.com/titlepages.leanpub.com/k8spatterns/hero?1492193906" align="right" width="300px" style="float:right; margin: 50px 0px 20px 30px;"/>

This image is a simple wrapper around [gomplate](https://github.com/hairyhenderson/gomplate). It adds support for bulk operation and is nicely fit for an init contaiener to pre-process configuration files in a Kubernetes pod.

This image is typically used as a base image like in 

```Dockerfile
FROM k8spatterns/gomplate
COPY myconfig/ in/
CMD [ "/in", "/params", "/out" ]
```

The entry point of this image expects three positional parameters:

* The **input** directory holding the templates. These are typically baked into the image
* The **params** directory holding the `gomplate` datasources. Each file in this directory is taken as an individual datasource which is used with the file's basename as key. E.g. a `config.yml` can be referenced from the template as `{{ (datasource "config").someKeyFromYamlFile }}`. This directory is typically mounted from the outside (e.g. from a Kubernetes `ConfigMap` backed volume).
* The **output** directory where to store the processed files. The generated files will have the same name as the input files. Only a flat directory is supported for the moment. This directory is typically also pointing to a directory within a volume so that the processed files can be used from the application to configure.

An addition parameter `-u uid:gid` can be used to change the ownership of the outputfiles. These should be numeric values and the option must come before any other arguments.
