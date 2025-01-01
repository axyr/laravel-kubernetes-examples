# Kubernetes configurations for Laravel applications

This repository contains various examples of Kubernetes configurations to deploy a Laravel application.

This repository takes the following assumptions:

- You know what Laravel is and how it should be installed.
- You have basic Docker knowledge.
- You have PHP and Composer running on you local machine.

The Larvel application should be installed in the `./laravel` directory.
The `insall.sh` script does this for you.

The examples can be found in `kubernetes` directory.
Each directory contains a more details README.md.

> The examples are meant to be a starting point to get Laravel running on a locally running Kubernetes cluster.

Every example runs in a dedicated namespace. See `namespace.yaml` in each directory.
Note that persistent volumes are unaware of namespaces.

> Examples might contain unsecure settings and commands that are not suitable for a production environments like:
> - hardcoded database credentials
> - 777 chmodded directories and files

This project comes intentional without Laravel.
This makes it easy to pull in any Laravel version you want and perform any updates if needed.

## Install Docker with Kubernetes

Install a Docker application for your OS that also supports running a local Kubernetes clusters.

Examples of desktop applications that allow you to run Docker and Kubernetes on your machine are:

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Orbstack](https://orbstack.dev/)
- [Rancher Desktop](https://rancherdesktop.io/)

Most these applications require you to enable Kubernetes support manually.

# Installation

## TL;DR

Run the following bash command from the command line:

```bash 
bash install.sh
```

## 1. Clone this repository

```bash 
git clone git@github.com:axyr/laravel-kubernetes-examples.git
```

> From here we assume you have a terminal open in the root directory of the cloned repository.

## 2. [Install Laravel](https://laravel.com/docs/master/installation) in the laravel directory.

If you have the Laravel installer installed, you can run the following command from the root directory of thi:
```bash
$ laravel new laravel -f
```

## Docker Registry

localhost:5000