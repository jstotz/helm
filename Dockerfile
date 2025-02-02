FROM alpine:3.10.2

ENV BASE_URL="https://get.helm.sh"

ENV HELM_2_FILE="helm-v2.16.1-linux-amd64.tar.gz"
ENV HELM_3_FILE="helm-v3.0.0-linux-amd64.tar.gz"
ENV HELM_HOME="/opt/helm"

RUN apk add --no-cache ca-certificates jq curl bash nodejs git && \
    # Install helm version 2:
    curl -L ${BASE_URL}/${HELM_2_FILE} |tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64 && \
    mkdir -p $HELM_HOME && \
    # Install helm version 3:
    curl -L ${BASE_URL}/${HELM_3_FILE} |tar xvz && \
    mv linux-amd64/helm /usr/bin/helm3 && \
    chmod +x /usr/bin/helm3 && \
    rm -rf linux-amd64 && \
    # Init version 2 helm:
    helm init --client-only && \
    helm plugin install https://github.com/databus23/helm-diff --version v2.11.0+5


COPY . /usr/src/
ENTRYPOINT ["node", "/usr/src/index.js"]
