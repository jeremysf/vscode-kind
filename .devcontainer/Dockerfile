# Derived from https://github.com/microsoft/vscode-dev-containers/tree/main/containers/docker-in-docker
# Sadly, they don't publish this container in a public repository, so it's copy/pasted here

# Note: You can use any Debian/Ubuntu based image you want. 
FROM mcr.microsoft.com/vscode/devcontainers/base:buster

# [Option] Install zsh
ARG INSTALL_ZSH="true"
# [Option] Upgrade OS packages to their latest versions
ARG UPGRADE_PACKAGES="false"
# [Option] Enable non-root Docker access in container
ARG ENABLE_NONROOT_DOCKER="true"
# [Option] Use the OSS Moby Engine instead of the licensed Docker Engine
ARG USE_MOBY="true"

# Install needed packages and setup non-root user. Use a separate RUN statement to add your
# own dependencies. A user of "automatic" attempts to reuse an user ID if one already exists.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
COPY library-scripts/*.sh /tmp/library-scripts/
RUN apt-get update \
    && /bin/bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" "true" \
    # Use Docker script from script library to set things up
    && /bin/bash /tmp/library-scripts/docker-in-docker-debian.sh "${ENABLE_NONROOT_DOCKER}" "${USERNAME}" "${USE_MOBY}" \
    # Clean up
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts/
    
VOLUME [ "/var/lib/docker" ]

# Setting the ENTRYPOINT to docker-init.sh will start up the Docker Engine 
# inside the container "overrideCommand": false is set in devcontainer.json. 
# The script will also execute CMD if you need to alter startup behaviors.
ENTRYPOINT [ "/usr/local/share/docker-init.sh" ]
CMD [ "sleep", "infinity" ]

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
     && apt-get -y install --no-install-recommends \
        xz-utils unzip jq uuid-runtime wget gnupg2 curl pkg-config vim sudo man 

# [Optional] Install nodejs
ENV NODE_VERSION 14.17.4
RUN wget -q https://nodejs.org/dist/v14.17.4/node-v$NODE_VERSION-linux-x64.tar.xz \
  && tar -xJvf node-v$NODE_VERSION-linux-x64.tar.xz -C /usr/local --strip-components=1 \
  && rm node-v$NODE_VERSION-linux-x64.tar.xz \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs

# [Optional] Install golang
RUN wget -q https://golang.org/dl/go1.16.6.linux-amd64.tar.gz \
  && tar -C /usr/local -xzf go1.16.6.linux-amd64.tar.gz
ENV PATH="${PATH}:/usr/local/go/bin"

# [Optional] Install the protoc compiler
RUN mkdir /tmp/protoc && cd /tmp/protoc && go mod init protoc && \
    go get -d -u github.com/golang/protobuf/proto@v1.3.1 && \
    go get -d -u github.com/golang/protobuf/protoc-gen-go@v1.3.1 && \
    go install github.com/golang/protobuf/protoc-gen-go && \
    cd .. && rm -rf /tmp/protoc

# Install Kuberenetes' latest stable kubectl command line client
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

# Install Helm
RUN wget -q -O - https://get.helm.sh/helm-v3.2.1-linux-amd64.tar.gz | tar -C /tmp -xzf - && \
    mv /tmp/linux-amd64/helm /usr/bin && chmod a+x /usr/bin/helm

# Install kind
RUN curl -Lo ./kind "https://kind.sigs.k8s.io/dl/v0.11.1/kind-$(uname)-amd64" && \
    chmod +x ./kind && mv ./kind /usr/local/bin
