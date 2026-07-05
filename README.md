# Terraform module homework

Создание инфраструктуры под две виртуальные машины в Яндекс Облаке
и дополнительное хранилище данных.

## Содержание

1. [Запуск проекта](#1-запуск-проекта)
2. [Деплой проекта](#2-деплой-проекта)
3. [Удаление ресурсов](#3-удаление-ресурсов)
4. [Короткие команды Makefile](#4-короткие-команды-makefile)

## 1. Запуск проекта

1. Создайте файл `.env` и добавьте туда токены от YC и S3 хранилища,
   пример в файле `.env.example`.

2. Загрузите токены командой:

   ```bash
   source .env
   ```

3. Авторизуйтесь в YC из браузера по выведенной в терминале ссылке.

4. При отсутствии GUI на машине пробросьте порты для авторизации
   себе на локальную машину командой:

   ```bash
   ssh -i ~/.ssh/user_key -L <port>:127.0.0.1:<port> <your-vm_user>@<your-server-ip>
   ```

   Порт для авторизации можно получить из ссылки (п.3)
   в GET параметре `redirect_uri`:

   ```bash
   &redirect_uri=http%3A%2F%2F127.0.0.1%3A37267%2Fauth%2Fcallback
   ```

   `37267` — нужный порт.

5. Инициализируйте проект terraform:

   ```bash
   terraform init -backend-config=backend-dev.hcl -reconfigure
   terraform init -backend-config=backend-prod.hcl -reconfigure
   ```

   Флаг `-reconfigure` нужен для чистого переключения между state,
   т.к. сам файл в хранилище отдельный.

6. Создайте workspace для разработки и продакшена:

   ```bash
   terraform workspace new dev
   terraform workspace new prod
   ```

   Проверить, что workspace созданы:

   ```bash
   terraform workspace list
   ```

## 2. Деплой проекта

### Переключение между dev и prod средами

Dev:

```bash
terraform workspace select dev
```

Prod:

```bash
terraform workspace select prod
```

### Запуск DEV

```bash
terraform workspace select dev
terraform plan -var-file=terraform.tfvars.dev
terraform apply -var-file=terraform.tfvars.dev
```

### Запуск PROD

```bash
terraform workspace select prod
terraform plan -var-file=terraform.tfvars.prod
terraform apply -var-file=terraform.tfvars.prod
```

## 3. Удаление ресурсов

### Удаление DEV

```bash
terraform workspace select dev
terraform plan -destroy -var-file=terraform.tfvars.dev
terraform destroy -var-file=terraform.tfvars.dev
```

### Удаление PROD

```bash
terraform workspace select prod
terraform plan -destroy -var-file=terraform.tfvars.prod
terraform destroy -var-file=terraform.tfvars.prod
```

## 4. Короткие команды Makefile

Установите make:

```bash
sudo apt update
sudo apt install make
```

Список всех команд:

```bash
make help
```

| Команда            | Описание                              |
| :---               | :---                                  |
| `make init`        | Инициализировать проект               |
| `make dev`         | Переключиться на dev workspace        |
| `make dev-plan`    | Проверить dev изменения               |
| `make dev-apply`   | Применить/запустить dev               |
| `make dev-plan-d`  | Проверить перед удалением dev         |
| `make dev-destroy` | Удалить ресурсы dev                   |
| `make prod`        | Переключиться на prod workspace       |
| `make prod-plan`   | Проверить prod изменения              |
| `make prod-apply`  | Применить/запустить prod              |
| `make prod-plan-d` | Проверить перед удалением prod        |
| `make prod-destroy`| Удалить ресурсы prod                  |

Команды `*-plan` и `*-apply` автоматически переключают
workspace перед выполнением!
