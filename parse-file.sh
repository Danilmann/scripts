#!/bin/bash
# Скрипт для парсинга файла и получения значений переменных

FILE_PATH=$1

if [ ! -f "$FILE_PATH" ]; then
  echo "Файл $FILE_PATH не найден!"
  exit 1
fi

# Чтение данных из файла и экспортирование переменных в окружение
while IFS= read -r line; do
  if [[ ! $line =~ ^# && $line =~ .*=.* ]]; then
    # Разделяем строку на ключ и значение
    IFS='=' read -r key value <<< "$line"
    # Экспортируем переменные в окружение
    echo "export $key='$value'" >> $GITHUB_ENV
  fi
done < "$FILE_PATH"

echo "Репозиторий: $repository_name"
echo "Среда: $environment"
