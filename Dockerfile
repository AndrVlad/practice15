FROM nginx:latest

RUN apt-get update && \
    apt-get install -y git && \
    rm -f /etc/nginx/sites-enabled/default

ENV REPO_URL="https://github.com/AndrVlad/study.git"
ENV PROJECT_DIR="/var/www/rent_car"

RUN mkdir -p $PROJECT_DIR && \
    git clone $REPO_URL $PROJECT_DIR && \
    cd $PROJECT_DIR/rent_car && \
    chown -R www-data:www-data $PROJECT_DIR

COPY nginx.conf /etc/nginx/conf.d/rent_car.conf
COPY nginx.conf /etc/nginx/sites-available/rent_car.conf
WORKDIR /var/www/rent_car/rent_car

# Копируем статические файлы в Nginx и задаем правильные права
RUN chown -R www-data:www-data /var/www/rent_car 
EXPOSE 80 81

CMD ["nginx", "-g", "daemon off;"]
