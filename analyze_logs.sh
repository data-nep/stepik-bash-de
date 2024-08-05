##!/bin/bash

# Подсчет общего количества запросов
total_requests=$(wc -l < access.log)

# Подсчет количества уникальных IP-адресов
unique_ips=$(awk '{print $1}' access.log | sort | uniq | wc -l)

# Подсчет количества запросов по методам
request_methods=$(awk '{print $6}' access.log | cut -d'"' -f2 | sort | uniq -c)

# Поиск самого популярного URL
popular_url_info=$(awk '{print $7}' access.log | sort | uniq -c | sort -nr | head -1)
popular_url_count=$(echo "$popular_url_info" | awk '{print $1}')
popular_url=$(echo "$popular_url_info" | awk '{print $2}')

# Создание отчета
cat <<EOL > report.txt
Общее количество запросов: $total_requests
Количество уникальных IP-адресов: $unique_ips

Количество запросов по методам:
$request_methods

Самый популярный URL: $popular_url ($popular_url_count обращений)
EOL

# Сообщение о сохранении отчета
echo "Отчет сохранен в файл report.txt"

