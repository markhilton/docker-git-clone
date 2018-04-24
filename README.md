# docker-git-clone

Docker image to clone requested github or bitbucket repository.

## Use case

Kubernetes deployments where init containers usually copy/move code from docker container into emptyDir volume to share between other deployment containers.

In case of push to deploy instead of waiting for the Docker container to be build with a specific repository tag, use this universal container to specify deployment SSH key file authorized to clone requested repository code from specified branch or tag.

## Environment variables

*required*
`REPO_LINK` - github or bitbucket repository SSH clone link

It is also required to mount a volume where the repository will be cloned from local file system into container `/repository` folder.

In case of private repositories you also have to mount deployment SSH key authorized to clone code repository

*optional*
`TAG` - clone specified tag
`BRANCH` - clone specified branch

if cloning using repository username/password instead SSH deployment key, please provide `REPO_LINK` without leading `https://`

`REPO_USER` - authorized user to clone requested repository
`REPO_PASS` - authorized user password to clone requested repository


## Example run

```
docker --rm run -ti \
    -v /path/to/clone/repository:/repository \
    -v /path/to/authorized/id_rsa:/root/.ssh/id_rsa \
    -e REPO_LINK=crunchgeek/git-clone
    -e REPO_BRANCH=master
    -e REPO_TAG=1.0.0
    crunchgeek/git-clone
```

