#!/bin/bash
# Скрипт для парсинга файла и получения значений переменных

# Путь к файлу pars-file
FILE_PATH=$1

# Задаем значение для переменной GITHUB_ENV
GITHUB_ENV="./GITHUB_ENV"

# Проверяем, что файл существует
if [ ! -f "$FILE_PATH" ]; then
  echo "Файл $FILE_PATH не найден!"
  exit 1
fi

# Чтение данных из файла и экспортирование переменных в GITHUB_ENV
while IFS= read -r line; do
  if [[ ! $line =~ ^# && $line =~ .*=.* ]]; then
    IFS='=' read -r key value <<< "$line"
    echo "$key='$value'" >> "$GITHUB_ENV"
  fi
done < "$FILE_PATH"

# Экспорт переменных в текущую сессию
export $(cat $GITHUB_ENV | xargs)

# Проверка, что переменные успешно установлены
echo "Репозиторий: $repository_name"
echo "Среда: $environment"
