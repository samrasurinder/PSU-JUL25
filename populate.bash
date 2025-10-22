cd /u02/software/PSU
mkdir -p OCT2025/$(hostname)
chmod -R 777 OCT2025/$(hostname)
unzip /u02/software/PSU/OCT2025CPU.zip  -d /u02/software/PSU/OCT2025/$(hostname)
cd /u02/software/PSU/OCT2025/$(hostname)
chmod 777 /u02/software/PSU/OCT2025
chmod -R 777 *
