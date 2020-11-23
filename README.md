
1. Vagrant стенд для NFS
vagrant up поднимает 2 виртуалки: nfsserver и nfsclient
provision shell берёт скрипты nfsserver_script.sh и nfsserver_client.sh

2. nfsserver_script.sh
Скрипт выводит информацию о хосте (имя хоста, ip алрес и тд.)
Добавляет хост nfsserver в /etc/hosts/
Создаёт директорию /nfs/upload с правами 777 и владельцем nfsnobody
Выводит информацию о содержимом директории /nfs/
Устанавливает пакет nfs-utils

Добавляет строчку конфигурации nfs сервера в файл /etc/exports
/nfs/upload 192.168.50.0/24(rw,all_squash,sync,no_subtree_check)
(доступ к директории /nfs/upload/ с подсети 192.168.50.0/24, права на чтение-запись, пользователи nfsnobody, режим sync, нет проверки дерева)

Применяет конфигурацию
Запускает службу nfs-server.service и добавляет в автозагрузку

Включает и настраивает firewall для работы с nfs

3. nfsserver_client.sh
Скрипт выводит информацию о хосте (имя хоста, ip алрес и тд.)
Добавляет хост nfsserver в /etc/hosts/
Создаёт директорию для монтирования /nfs/nfsserver10/upload/
Устанавливает пакет nfs-utils

Включает и настраивает firewall для работы с nfs

Добавляет в fstab (автомонтирование при старте) строку:
nfsserver:/nfs/upload /nfs/nfsserver10/upload nfs rw,sync 0 0
Монтирует nfsserver:/nfs/upload/ в /nfs/nfsserver10/upload/

Проверяет загрузку файлов в /nfs/nfsserver10/upload/

Результат:
На сервере расшарена директория upload с правами на запись
На клиенте она автоматически монтируется при старте (fstab)
Включенный firewall
Клиент пишет файлы в директорию upload
