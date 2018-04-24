#!/bin/bash

if [ -z "$REPO_LINK" ]; then 
	echo -e "\033[1;91mERROR:\033[0m REPO_LINK env variable is required"
	exit 1
fi

if [ -z "$REPO_BRANCH" ]; then 
	export REPO_BRANCH=master
fi

# check if credentials files exist
if [[ -f "/root/.ssh/id_rsa" ]] ; then 
	chmod 600 /root/.ssh/id_rsa
fi

if [ ! -z "$REPO_USER" ] && [ ! -z "$REPO_PASS" ]; then 
	# clone with repository username & password
	git clone -b $REPO_BRANCH https://$REPO_USER:$REPO_PASS@$REPO_LINK /repository
elif [[ ! -f "/root/.ssh/id_rsa" ]] ; then 
	echo -e "\033[1;91mERROR:\033[0m REPO_USER, REPO_PASS env variables or SSH deployment key missing"
	exit 1
else
	# clone public repository or using ssh deployment key
	git clone -b $REPO_BRANCH $REPO_LINK /repository
fi

if [ ! -z "$REPO_TAG" ]; then 
	cd /repository && \
	git checkout tags/$REPO_TAG
fi

