GREEN='\033[0;32m'
NC='\033[0m'
useradd -m sftpuser
echo "${GREEN}Type in password for sftpuser${NC}"
passwd sftpuser
service sshd restart
wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
apt-get update
apt install blobfuse
mkdir /mnt/resource/blobfusetmp -p
chown sftpuser /mnt/resource/blobfusetmp
echo "${GREEN}Type in Storage Account Name${NC}"
read accountName
echo "${GREEN} Type in Storage Account Key${NC}"
read accountKey
echo "${GREEN} Type in Storage Container Name${NC}"
read containerName
echo accountName $accountName > /home/sftpuser/fuse_connection.cfg
echo accountKey $accountKey >> /home/sftpuser/fuse_connection.cfg
echo containerName $containerName >> /home/sftpuser/fuse_connection.cfg
mkdir /home/sftpuser/azstoragecontainer -p
chown -R sftpuser /home/sftpuser
sudo -u sftpuser blobfuse /home/sftpuser/azstoragecontainer --tmp-path=/mnt/resource/blobfusetmp  --config-file=/home/sftpuser/fuse_connection.cfg -o attr_timeout=240 -o entry_timeout=240 -o negative_timeout=120