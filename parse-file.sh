#!/bin/bash
# Скрипт для парсинга файла и получения значений переменных

# Путь к файлу pars-file
FILE_PATH=$1

# Проверяем, что файл существует
if [ ! -f "$FILE_PATH" ]; then
  echo "Файл $FILE_PATH не найден!"
  exit 1
fi

# Чтение данных из файла и вывод значений в формате ::set-env
while IFS= read -r line; do
  if [[ ! $line =~ ^# && $line =~ .*=.* ]]; then
    IFS='=' read -r key value <<< "$line"
    echo "::set-env name=$key::$value"
  fi
done < "$FILE_PATH"

# Проверка, что переменные успешно установлены
echo "Репозиторий: $repository_name"
echo "Среда: $environment"
