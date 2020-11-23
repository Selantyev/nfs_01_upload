
Vagrant стенд для NFS
1. vagrant up поднимает 2 виртуалки: nfsserver и nfsclient
2. provision shell берёт скрипты nfsserver_script.sh и nfsserver_client.sh

nfsserver_script.sh
1. Скрипт выводит информацию о хосте (имя хоста, ip алрес и тд.)
2. Добавляет хост nfsserver в /etc/hosts/
3. Создаёт директорию /nfs/upload с правами 777 и владельцем nfsnobody
4. Выводит информацию о содержимом директории /nfs/
5. Устанавливает пакет nfs-utils
6. Добавляет строчку конфигурации nfs сервера в файл /etc/exports
/nfs/upload 192.168.50.0/24(rw,all_squash,sync,no_subtree_check)
(доступ к директории /nfs/upload/ с подсети 192.168.50.0/24, права на чтение-запись, пользователи nfsnobody, режим sync, нет проверки дерева)
7. Применяет конфигурацию
8. Запускает службу nfs-server.service и добавляет в автозагрузку
9. Включает и настраивает firewall для работы с nfs

nfsserver_client.sh
1. Скрипт выводит информацию о хосте (имя хоста, ip алрес и тд.)
2. Добавляет хост nfsserver в /etc/hosts/
3. Создаёт директорию для монтирования /nfs/nfsserver10/upload/
4. Устанавливает пакет nfs-utils
5. Включает и настраивает firewall для работы с nfs
6. Добавляет в fstab (автомонтирование при старте) строку:
nfsserver:/nfs/upload /nfs/nfsserver10/upload nfs rw,sync 0 0
7. Монтирует nfsserver:/nfs/upload/ в /nfs/nfsserver10/upload/
8. Проверяет загрузку файлов в /nfs/nfsserver10/upload/

Результат:
1. На сервере расшарена директория upload с правами на запись
2. На клиенте она автоматически монтируется при старте (fstab)
3. Включенный firewall
4. Клиент пишет файлы в директорию upload
