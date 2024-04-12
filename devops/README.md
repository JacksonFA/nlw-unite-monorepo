# Etapas para configurar um deploy Kubernetes do ZERO

## Etapa 1 - Conteinerizando a aplicação

Criar um arquivo Dockerfile para conseguir executar a aplicação via Container

Ex.: https://github.com/JacksonFA/nlw-unite-monorepo/blob/main/backend/Dockerfile

## Etapa 2 - Executando a aplicação com suas dependências

Criar um arquivo docker-compose.yml para conseguir executar a imagem da aplicação e de suas dependências

Ex.: https://github.com/JacksonFA/nlw-unite-monorepo/blob/main/backend/docker-compose.yml

## Etapa 3 - Pipeline de CI

Criar um arquivo .yml para a construir uma nova imagem Docker da aplicação e enviar para um Registry a cada commit

Ex.: https://github.com/JacksonFA/nlw-unite-monorepo/blob/main/.github/workflows/node-ci_cd.yml

## Etapa 4 - Iniciando cluster Kubernetes localmente

Para criar um cluster Kubernetes é necessário instalar uma ferramente que permita o gerencialmente do mesmo localmente, como por exemplo Kind, Mini Kube, k3d, entre outros.
Além disso, também é preciso instalar a CLI do Kubernetes, o kubectl.

- Kind: https://kind.sigs.k8s.io/
- Mini Kube: https://minikube.sigs.k8s.io/docs/
- k3d: https://k3d.io/v5.6.3/
- Kubectl: https://kubernetes.io/docs/reference/kubectl/
  
*Lens: Interface gráfica para gerenciamento do Kubernetes. (https://docs.k8slens.dev/getting-started/install-lens/)

### Usando o k3d

```zsh
k3d cluster create <name> --servers 2
```

### Comandos do Kubectl

- Listar infos do cluster: `kubectl cluster-info`
- Listar nodes do cluster: `kubectl get nodes`
- Listar namespaces do cluster: `kubectl get ns`
- Criar um namespace: `kubectl create namespace <name>` (Boa prática não utilizar o default)
- Executar manifestos em um namespace: `kubectl apply -f <manifests_path> -n <namespace>`
- Listar deployments de um namespace: `kubectl get deployments -n <namespace>`
- Listar pods de um namespace: `kubectl get pods -n <namespace>` (Dica: Utilizar a ferramenta watch para ver a criação de pods)

## Etapa 5 - Manifesto Kubernetes da aplicação

Criar um arquivo .yaml com as definições de um manifesto Kubernetes para executar o container da aplicação

Ex.: https://github.com/JacksonFA/nlw-unite-monorepo/blob/main/backend/k8s/deployment.yaml

Criar um arquivo .yaml com as definições de services

Ex.: https://github.com/JacksonFA/nlw-unite-monorepo/blob/main/backend/k8s/service.yaml

Criar configMap para variáveis simples e secret para variáveis sensíveis que serão utilizadas no manifesto da aplicação

Ex.: https://github.com/JacksonFA/nlw-unite-monorepo/blob/main/backend/k8s/configmap.yaml
Ex.: https://github.com/JacksonFA/nlw-unite-monorepo/blob/main/backend/k8s/secret.yaml

## Etapa 6 - Utilizando o Helm

O Helm é um gerenciador de pacotes para o Kubernetes, permitindo criar pacotes de nossos manifestos para "automatizar" o kubectl

- Instalar o Helm: https://helm.sh/
- Criar um pacote: `helm create <name>`
- Preencher o arquivo values.yaml: Ex.: https://github.com/JacksonFA/nlw-unite-monorepo/blob/main/backend/helm/values.yaml
- Executar o pacote dentro de um namespace: `helm upgrade --install <chart_name> <helm_manifests_path> -n <namespace>`
- Listar releases de um namespace: `helm list -n <namespace>`

## Etapa 7 - Utilizando o ArgoCD

O ArgoCD é uma ferramenta para criar GitOps Continuous Delivery para o Kubernetes de forma declarativa

- Documentação: https://argoproj.github.io/cd/
- Instalação dentro do cluster Kubernetes:
  - ```zsh
    kubectl create namespace argocd
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    ```
- Listar services instalado no namespace do Argo: `kubectl get svc -n argocd`
- Redirecionamento de porta para acessar a UI do Argo: `kubectl port-forward svc/argocd-server -n argocd 3001:80`
- Para logar na UI, é preciso pegar a senha criada na instalação
  - Basta rodar o comando: `kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`
  - É possível usar o Lens, acessando o cluster, abrindo a tela Config > Secrets e procurar pela secret "argocd-initial-admin-secret"
- Criar acesso do Argo ao repositório da aplicação:
  - Arquivo da application: Ex.: https://github.com/JacksonFA/nlw-unite-monorepo/blob/main/devops/argocd/apps/passin/argo.yaml
  - Arquivo da secret: Ex.: https://github.com/JacksonFA/nlw-unite-monorepo/blob/main/devops/argocd/apps/passin/repository.yaml 
- Aplicar manifestos ao cluster: `kubectl apply -n argocd -f <argo_app_path>`

## Etapa 8 - Atualizar a pipeline CI

Atualizar o arquivo .yml que contém a configuração da pipeline de CI para incluir o step que irá disparar o CD no Argo.
Para isso, basta adicionar as linhas abaixo, que irá criar um novo commit alterando o arquivo values.yaml do helm, atualizando nele a tag da image Docker utilizada

```yml
 - name: Update image tag
      uses: fjogeleit/yaml-update-action@main
      with:
        branch: main
        valueFile: 'backend/helm/values.yaml'
        propertyPath: 'image.tag'
        value: "${{ steps.generate_sha.outputs.sha }}"
        commitChange: true
        message: 'new: updated tag in value Helms'
```

*Verificar Workflow Permissions nas configurações do repositório

## Etapa 9 - Utilizando o Terraform

É possível utilizar o terraform para fazer a criação de recursos em clouds como AWS, Azure, GCP, Oracle, Digital Ocean, etc...

- Exemplo de criação de banco de dados na Digital Ocean: https://github.com/JacksonFA/nlw-unite-monorepo/tree/main/devops/terraform
- Exemplo de criação do cluster Kubernetes na Oracle: 
- Exemplo de criação do cluster Kubernetes na AWS: 

## Etapa 10 - Deploy da aplicação em cluster Kubernetes auto gerenciado:

Após ter um cluster criado dentro de alguma cloud provider, é preciso atualizar o contexto local do kubectl:

- Exemplo de configuração da Oracle: `oci ce cluster create-kubeconfig --cluster-id <cluster_id> --file $HOME/.kube/config --region <region> --token-version 2.0.0  --kube-endpoint PUBLIC_ENDPOINT`
- Exemplo de configuração da AWS: `aws eks --region <region> update-kubeconfig --name <cluster_name>`

Com o contexto do kubectl atualizado, basta executar novamente os comandos da etapa 7 e também criar o namespace que será utilizado pela aplicação.

*Isso é preciso caso a criação da infra via Terraform não esteja automatizada com pipelines.
