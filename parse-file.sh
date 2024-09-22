#!/bin/bash
# Скрипт для парсинга файла и получения значений переменных

# Путь к файлу pars-file, передается как первый аргумент
FILE_PATH=$1

# Проверка наличия пути к файлу
if [ -z "$FILE_PATH" ]; then
  echo "Ошибка: не указан путь к файлу."
  exit 1
fi

# Задаем значение для переменной GITHUB_ENV
GITHUB_ENV="./GITHUB_ENV"

# Проверяем, что файл существует
if [ ! -f "$FILE_PATH" ]; then
  echo "Ошибка: файл $FILE_PATH не найден!"
  exit 1
fi

# Чтение данных из файла и экспортирование переменных в GITHUB_ENV
while IFS= read -r line; do
  # Игнорируем строки, начинающиеся с # или пустые строки
  if [[ ! $line =~ ^# && $line =~ .*=.* ]]; then
    IFS='=' read -r key value <<< "$line"
    # Записываем переменную в GITHUB_ENV и эскейпим символы
    echo "$key=\"$value\"" >> "$GITHUB_ENV"
  fi
done < "$FILE_PATH"

# Экспорт переменных в текущую сессию
export $(cat $GITHUB_ENV | xargs)

# Проверка, что переменные успешно установлены
echo "Проверка экспорта переменных:"
echo "Репозиторий: ${repository_name}"
echo "Среда: ${environment}"
echo "Приложение: ${application}"
echo "Тег: ${tag}"
