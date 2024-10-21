## Описание

API развернуто в трех контейнера. postgres-db - контейнер с базой данных, которая хранится во внешней директории /var/database. 
skill-profi-api-container - контейнер с приложением API на ASP.NET core 8 с внешней папкой /var/images, куда сохраняет загруженные 
изображения. nginx - контейнер с Nginx который управляет роутами и ресурсами. 

Между контейнерами развернута локальная виртуальная сеть для обмена данными. Так как проект тестовый не стал закрывать порты 500 и 5432, 
по ним можно в обход nginx подключится к API и базе данных соответственно.

Все контейнеры сконфигурированы и хранятся на моем dockerhub для быстрого и удобного развертывания.

Проект можно запустить и на http, для этого нужно изменить Dockerfile в Nginx - просто не копировать https.conf и заменить адреса в 
docker-compose и файле локальных переменны frontend проекта

## Как развернуть проект по https

### Копируем билд frontend
```bash
scp -r path-to-your-project/skill-profi.frontend/build root@your-server-ip:/var/
```

### Копируем тестовые изображения
```bash
scp -r path-to-your-project/SkillProfi.WebApi/wwwroot/Images root@your-server-ip:/var/
```

### Копируем docker-compose
```bash
scp path-to-your-project/docker-compose.yml root@your-server-ip:/home/
```

### Подключаемся по SSH к серверу
```bash
ssh root@your-server-ip
```

### Лучше обновить пакеты
```bash
sudo apt update
sudo apt upgrade
```

### Добавление SSL сертификата для https
### Если не установлен snapd (Ubuntu 22 по умолчанию):
```bash
sudo apt install snapd
```

### Обновляем версию snapd
```bash
sudo snap install core; sudo snap refresh core
```

### Устанавливаем certbot
```bash
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
```

### Создаем сертификаты (на все соглашаемся, вводим домен)
```bash
sudo certbot certonly --webroot --webroot-path /var/build --config-dir /var/ssl
```

### Устанавливаем Docker
```bash
sudo apt install docker
```

### Устанавливаем Docker-compose
```bash
sudo apt install docker-compose
```

### Переходим в home директорию
```bash
cd /home
```

### Запускаем docker-compose
```bash
sudo docker-compose up
```

### Сервер запущен