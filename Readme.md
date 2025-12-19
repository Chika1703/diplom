# Дипломный проект  
## Kubernetes, Terraform и CI/CD (Timeweb Cloud)

---

## Цели проекта

1. Подготовить облачную инфраструктуру на базе Timeweb Cloud с использованием Terraform.
2. Развернуть и сконфигурировать Kubernetes кластер.
3. Установить и настроить систему мониторинга (Prometheus + Grafana).
4. Настроить тестовое приложение с использованием Docker.
5. Настроить CI/CD для автоматической сборки и деплоя приложения.

---

## Общая архитектура проекта

Дипломный проект реализован в виде **трёх логически разделённых репозиториев**:

1. **Terraform** — создание облачной инфраструктуры  
2. **Kubernetes** — развёртывание кластера и мониторинга  
3. **Test App** — сборка Docker-образа и деплой приложения  

Проект реализован на базе **Timeweb Cloud** с полной автоматизацией через CI/CD.

---

## Репозитории проекта

- Terraform (инфраструктура):  
  https://gitlab.com/dimakolb2/terraform

- Kubernetes (кластер и мониторинг):  
  https://gitlab.com/dimakolb2/k8s

- Test App (Docker + CI/CD):  
  https://gitlab.com/dimakolb2/test-app

---

## Этап 1. Создание облачной инфраструктуры (Terraform)

Инфраструктура создаётся **автоматически через GitLab CI/CD**.

### Реализовано:

- VPC с приватной сетью 
- NAT-server с публичным IP (master node) (в приватной сети)
- Load Balancer с публичным IP (в приватной сети)
- Lamp-servers нет публичного IP (worker nodes) (в приватной сети)
- Backend для Terraform state (S3 Backet) уже создан отдельно
- Автоматический `terraform apply / destroy` через CI/CD

### Сетевая схема:

- **Master node**
  - Находится в приватной сети
  - Имеет доступ в интернет
  - Используется как control-plane Kubernetes

- **Worker nodes**
  - Не имеют публичных IP-адресов
  - Выходят в интернет через NAT (для установки пакетов и образов)
  - Принимают трафик от Load Balancer

- **Load Balancer**
  - Имеет публичный IP
  - Находится в приватной сети
  - Балансирует HTTP-трафик на worker-ноды

Terraform полностью управляет жизненным циклом инфраструктуры.

---

## Этап 2. Развёртывание Kubernetes кластера

После создания инфраструктуры используется репозиторий **k8s**.

### Последовательность действий:

1. Настройка сетевого доступа lamp в интернет через NAT  
2. Инициализация Kubernetes кластера  
3. Подключение worker-нод к master  
4. Настройка доступа через `~/.kube/config`  
5. Проверка работоспособности кластера  

Кластер является **self-hosted**, развёрнут на виртуальных машинах.

Проверка состояния кластера:

- Получение списка нод
- Получение pod'ов во всех namespace
- Проверка сетевой доступности сервисов

---

## Этап 3. Мониторинг Kubernetes

После развёртывания кластера установлен мониторинг:

- Prometheus
- Grafana
- Node Exporter

### Доступы:

- Prometheus:  
  http://194.87.226.128:30900/

- Grafana:  
  http://194.87.226.128:30300/

---

## Этап 4. Test App — сборка и деплой приложения

Тестовое приложение находится в отдельном репозитории **test-app**.

### Реализовано:

- Простое приложение на базе Nginx
- Dockerfile для сборки образа
- Публикация образа в DockerHub
- CI/CD пайплайн GitLab

### CI/CD логика:

- При коммите:
  - Сборка Docker-образа
  - Push в DockerHub

- При создании тега:
  - Сборка версии с tag
  - Деплой образа в Kubernetes кластер

Приложение разворачивается на **worker нодах Kubernetes**.

### Доступ к приложению:

- http://176.124.219.27/

---

## Скриншоты

- Terraform (CI/CD, ресурсы)
- Kubernetes (ноды, pods)
- Мониторинг (Prometheus, Grafana)
- Test App (доступность приложения)

Скриншоты, подтверждающие выполнение этапов, находятся в каталоге:

`diplom1/test-app/icons/`

- ![Terraform_1.jpg](https://github.com/Chika1703/diplom/blob/main/jpg/Terraform_1.jpg)  
- ![Terraform_2.jpg](https://github.com/Chika1703/diplom/blob/main/jpg/Terraform_2.jpg)  
- ![Terraform_3.jpg](https://github.com/Chika1703/diplom/blob/main/jpg/Terraform_3.jpg)  
- ![k8s_1.jpg](https://github.com/Chika1703/diplom/blob/main/jpg/k8s_1.jpg)  
- ![k8s_2.jpg](https://github.com/Chika1703/diplom/blob/main/jpg/k8s_2.jpg)  
- ![k8s_3.jpg](https://github.com/Chika1703/diplom/blob/main/jpg/k8s_3.jpg)  
- ![Monitoring_1.jpg](https://github.com/Chika1703/diplom/blob/main/jpg/Monitoring_1.jpg)  
- ![Monitoring_2.jpg](https://github.com/Chika1703/diplom/blob/main/jpg/Monitoring_2.jpg)  
- ![App_1.jpg](https://github.com/Chika1703/diplom/blob/main/jpg/App_1.jpg)  
- ![App_2.jpg](https://github.com/Chika1703/diplom/blob/main/jpg/App_2.jpg)  

---

## Итог

В рамках дипломного проекта:

- Инфраструктура полностью автоматизирована Terraform
- Kubernetes кластер развёрнут на self-hosted VM
- Реализована безопасная сетевая схема с NAT и LB
- Настроен мониторинг Kubernetes
- Настроен CI/CD для сборки и деплоя приложения



