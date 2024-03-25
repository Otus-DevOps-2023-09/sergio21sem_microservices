# Micorservices

#Docker-3
# что сделано:
1. Ранее деплоемое приложение с одним докер файлом, было сплитнуто на несколько контейнеров. Потренировался в описаниии Dockerfile;
2. Задание со "*" +Дебаг проблем при запуске контейнеров. Из-за проблем с версиями образов, немного оптимизированы докер файлы и с код приложений
3. Тренировка с docker volume


##Docker-4
# Kubernetes-1

Установка ВМ ubuntu1804

yc compute instance create \
  --name worker \
  --zone ru-central1-a \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1804-lts,size=45,type=network-ssd \
  --memory 4 \
  --cores 4 \
  --ssh-key ~/.ssh/x.pub

yc compute instance create \
  --name master \
  --zone ru-central1-a \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1804-lts,size=45,type=network-ssd \
  --memory 4 \
  --cores 4 \
  --ssh-key ~/.ssh/x.pub

Получаем адреса

    worker address: 158.160.96.53
    master address: 158.160.51.61

Заходим на воркер

    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/engineer
    ssh yc-user@158.160.96.53

Ставим докер 19.03

    sudo apt-get update
    sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt update
    sudo apt install docker-ce=5:19.03.12~3-0~ubuntu-bionic docker-ce-cli=5:19.03.12~3-0~ubuntu-bionic containerd.io

Ставим кубер 1.19

    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
    sudo apt install kubectl=1.19.14-00 kubelet=1.19.14-00 kubeadm=1.19.14-00

Делаем то же самое на мастере

Инициализируем мастер где 158.160.51.61 - мастер

    sudo kubeadm init --apiserver-cert-extra-sans=158.160.51.61 --apiserver-advertise-address=0.0.0.0 --control-plane-endpoint=158.160.51.61 --pod-network-cidr=10.244.0.0/16

В результате получаем команду, которую выполняем на воркере

Then you can join any number of worker nodes by running the following on each as root:

    sudo kubeadm join 158.160.51.61:6443 --token lrm8su.4n7nhhunqrv6g2je \
    --discovery-token-ca-cert-hash sha256:1111111111111111111111111111111111111111111111111111111111111111

Выполняем команды на мастере

    mkdir $HOME/.kube/
    sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $USER $HOME/.kube/config

Теперь можно посмотреть ноды

    kubectl get nodes

Смотрим описание

    kubectl describe node fhm3pgql6b5blrvv537t
    kubectl describe node fhmm1c6su2je2idgin73

Ставим калико (мастер нода)

    curl https://docs.projectcalico.org/archive/v3.15/manifests/calico.yaml -O


    vim calico.yaml

Листаем в почти в самый низ кнопкой PgDn (Page Down)

Раскомментируем и меняем строки

            - name: CALICO_IPV4POOL_CIDR
              value: "10.244.0.0/16"

Применяем

    kubectl apply -f calico.yaml

Проверяем

    kubectl get nodes

Создаем на мастере файлы из задания
Пробуем запустить

    kubectl apply -f  ui-deployment.yml
    kubectl apply -f  post-deployment.yml
    kubectl apply -f  comment-deployment.yml
    kubectl apply -f  mongo-deployment.yml

Проверяем

    kubectl get pods
