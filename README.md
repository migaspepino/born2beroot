# 42cursus - Born2beroot

**Version 1 of the Born2beroot exercise**

<sub>Based on the tutorials by [hanshazairi](https://web.archive.org/web/20211229212338/https://github.com/hanshazairi/42-born2beroot/blob/main/README.md) and [caroldaniel](https://web.archive.org/web/20220109013343/https://github.com/caroldaniel/42sp-cursus-born2beroot/blob/master/guides/Bonus-en.md)</sub>

## Table of Contents
1. [Installation](#installation)
2. [*sudo*](#sudo)
    - [Step 1: Installing *sudo*](#step-1-installing-sudo)
    - [Step 2: Adding User to *sudo* Group](#step-2-adding-user-to-sudo-group)
    - [Step 3: Running *root*-Privileged Commands](#step-3-running-root-privileged-commands)
    - [Step 4: Configuring *sudo*](#step-4-configuring-sudo)
3. [SSH](#ssh)
    - [Step 1: Installing & Configuring SSH](#step-1-installing--configuring-ssh)
    - [Step 2: Installing & Configuring UFW](#step-2-installing--configuring-ufw)
    - [Step 3: Connecting to Server via SSH](#step-3-connecting-to-server-via-ssh)
4. [User Management](#user-management)
    - [Step 1: Setting Up a Strong Password Policy](#step-1-setting-up-a-strong-password-policy)
       - [Password Age](#password-age)
       - [Password Strength](#password-strength)
    - [Step 2: Creating a New User](#step-2-creating-a-new-user)
    - [Step 3: Creating a New Group](#step-3-creating-a-new-group)
5. [Script](#script)
6. [*cron*](#cron)
    - [Setting Up a *cron* Job](#setting-up-a-cron-job)
7. [Useful commands](#Useful-commands)
    - [SSH commands](#SSH-commands)
    - [What to check?](#What-to-check)
    - [New user](#New-user)
    - [Groups](#Groups)
    - [Change Hostname](#Change-Hostname)
    - [How to add and remove port ***x*** in UFW?](#How-to-add-and-remove-port-x-in-UFW)

9. [Bonus](#bonus)
    - [lighttpd](#lighttpd)
    - [MariaDB](#MariaDB)
    - [PHP](#PHP)
    - [Wordpress](#Wordpress)
    - [Fail2ban](#Fail2ban)
    - [File Transfer Protocol *(FTP)*](#3-file-transfer-protocol-ftp)
       - [Step 1: Installing & Configuring FTP](#step-1-installing--configuring-ftp)
       - [Step 2: Connecting to Server via FTP](#step-2-connecting-to-server-via-ftp)

## Installation
The following note is from the Guide on which this one is based (see note at the beginning):
<sub>At the time of writing, the latest stable version of [Debian](https://www.debian.org) is *Debian 10 Buster*. </sub>
<sub>Watch *bonus* installation walkthrough *(no audio)* [here](https://youtu.be/2w-2MX5QrQw).</sub>

However at the time of rewriting of this Guide the latest stable version of [Debian](https://www.debian.org) is *Debian 11 _bullseye_*
<sub>This is a similar process for the mandatory and bonus part the only thing that changes is the number of partitions and their size.</sub>

___

After completing the UTM or Virtualbox setup we start our virtual machine:

**MAKE SURE YOU ARE IN BIOS MODE (NOT UEFI) OR YOU WON'T BE ABLE TO MAKE THE PARTITIONS ACCORDING TO THE EXERCISE**

![bios prompt](https://imgur.com/x5Fq6zO.png)Select `install` 

Select your language
Select your time-zone location
And your keyboard layout (I picked Portuguese):

![select language](https://imgur.com/5EMmqzb.png)

![Select timezone](https://imgur.com/Sfe2gZa.png)

![keyboard layout](https://imgur.com/OxHGzyw.png)

Now it will take a bit:

![loading1](https://imgur.com/rQL7rBW.png)

For the hostname put your user followed by 42 (born2beroot v1):

![Hostname](https://imgur.com/xz6Ugva.png) 

Leave the domain empty:

![domain](https://imgur.com/HosB3gI.png)

Pick a root password (born2beroot v1):

 - Your password must be at least 10 characters long.
 - It must contain an uppercase letter and a number.
 - It must not contain more than 3 consecutive identical characters.

![root password](https://imgur.com/jxaWJ5o.png)

Repeat it:

![repeat password](https://imgur.com/pJg0DSe.png)

It will now ask for your full name for the non root, a user and a password for it:

![username](https://imgur.com/irBZu5I.png)

![password for user](https://imgur.com/3mGbcG3.png) 

Now on to partition the disks...
It will show you this menu, pick manual:

![partitioning disks](https://imgur.com/zHruPsB.png)

Click on the empty drive (name will vary UTM vs Virtualbox):

![pick drive](https://imgur.com/dKPGEAz.png)

![loading2](https://imgur.com/CW94G4V.png)

You'll get a warning. Press yes:

![warning1](https://imgur.com/O2ofKS0.png)

You now have a free partition, click on it (enter):

![new partition 1](https://imgur.com/aPcIdRC.png)

Create a new partition:

![create a new partition](https://imgur.com/dchoHGz.png)

Pick size:

![size1](https://imgur.com/DyuB0K8.png)

Chose Primary partition (this won't show in UEFI mode):

![primary partition](https://imgur.com/83LBPOw.png) 

Pick beginning of available space:

![beginning of available space](https://imgur.com/9BKG4Pf.png)

Change the mount point to `/boot` and then `Done setting up the partition` :

![boot mount point](https://imgur.com/aSEFfCS.png)

Pick the available space to create a new partition:

![new partition 2](https://imgur.com/zxm9ZZ7.png)

Asking how much to allocate pick `MAX` (Maximum Space) (Don't worry the 1K partition will be created on the next step):

![allocate max space](https://imgur.com/IkzpV02.png)

This time chose Logical partition (this won't show in UEFI mode):

![logical partition](https://imgur.com/o7GxzRN.png)

This will create a 1K [extended](https://en.wikipedia.org/wiki/Extended_boot_record) partition that contains the [logical ones](https://web.archive.org/web/20140410191344/http://pcguide.com/ref/hdd/file/structPartitions-c.html). (Thanks to [terdon](https://unix.stackexchange.com/questions/128290/what-is-this-1k-logical-partition))

The structure of the logical portions in the extended partition is described using one or more Extended Boot Records (EBR). EBRs that describe multiple logical drives are organized as a linked list. Each EBR comes before the logical drive described by it. The first EBR will contain the starting point of the EBR that describes the next logical drive. (thanks to [DifferenceBetween](https://www.differencebetween.com/difference-between-primary-partition-and-vs-logical-partition/))

![Extended Logical Partitions Scheme](https://imgur.com/9I6xQEV.png)

(Image thanks to [Denise Duffy](https://www.infosecinstitute.com/authors/denise-duffy/))

Go into mount point and chose none:

![no mount point](https://imgur.com/YMDF6nv.png)

![mount point menu](https://imgur.com/w89ovmR.png)

Then pick `Done  setting up the partition`

Now that we have two partitions lets encrypt one of them. Go to `configure encrypted volume`:

![configure encrypted volume](https://imgur.com/9VfeCUs.png)

Apply changes before proceeding:

![apply changes1](https://imgur.com/U3idHER.png)

Chose `create encrypted volumes`:

![create encrypted volumes](https://imgur.com/6JDWtus.png)

Select the partition to encrypt:

![Select the partition to encrypt](https://imgur.com/znvqWOa.png)

And Finish:

![Finish](https://imgur.com/MLnrjkm.png)

Encrypt it (Select yes):

![Encrypt it](https://imgur.com/aZLimYy.png)

![wait for it](https://imgur.com/koqVXhu.png)

And give it a Password:

![enter image description here](https://imgur.com/Nrn8Pe9.png)

Now we'll start to populate this partition, select `configure the logical volume manager`:

![configure the logical volume manager](https://imgur.com/U4VaTGt.png)

([What is being done](https://www.youtube.com/watch?v=dMHFArkANP8))

Select `create volume group`: 

![create volume group](https://imgur.com/T2jSGdF.png)

Enter volume group name `<yourname>-vg` (Note that I messed up and put two hyphens **just use one hyphen, LVM [doubles the hyphen](https://unix.stackexchange.com/questions/319877/doubled-hyphens-in-lvm-dev-mapper-names) when a device path file is created**):

![enter VG name](https://imgur.com/A9wJErZ.png)

(**NOTES IF YOU MESSED UP THE NAMING**)

(If you messed up the naming; after the install, you can just do [this](https://wiki.networksecuritytoolkit.org/index.php/HowTo_Change_The_LVM_Volume_Group_Name_That_Includes_The_Root_Partition))

(**DO NOT DO VGRENAME AND REBOOT**)

(if you still did, on the terminal that appears just use `/sbin/lvm vgrename <changed name> <original name>` + `exit` and it will boot again)

select devices for VG:

![select devices for vg](https://imgur.com/ofiCoIZ.png)

Select `Create Logical Volume`:

![Create Logical Volume](https://imgur.com/fqNRiMK.png)

Select the Volume Group we just created:

![select the volume group](https://imgur.com/3kWCv0c.png)

First we start with `root`  adding the size afterwards, then we'll do all the others:

![Logical volume root](https://imgur.com/X3ifOuf.png)

![Logical Volume swap](https://imgur.com/4XOxom5.png)

![Logical volume home](https://imgur.com/mdYx6ZJ.png)

After it's all done we finish:

![Finish2](https://imgur.com/vuqJ2jr.png)

Now going one by one to each partition on the partition disks screen (selecting under `LVM VG wil-vg, LV` `root` ,`swap_1`, `home`) we will change the partition setting from `do not use` to `EXT4`, `swap area` and `EXT4` for `root` ,`swap_1` and `home` respectively:

![main menu1](https://imgur.com/nwQQaSi.png)

![partition settings1](https://imgur.com/EUbt2cl.png)

![Use partition as Ext4](https://imgur.com/xhAYnMV.png)

![mount point /home](https://imgur.com/H7fHgvp.png)

![partition settings1](https://imgur.com/EUbt2cl.png)

![Use partition as Ext4 (2)](https://imgur.com/xhAYnMV.png)

![mount point root](https://imgur.com/2aWKTfr.png)

![partition settings1](https://imgur.com/EUbt2cl.png)

![use as swap](https://imgur.com/uae7pex.png)

We finish:

![finish partitioning and write changes to disk](https://imgur.com/NUDWkEa.png)

![confirmation prompt](https://imgur.com/2XzJdP4.png)

Now awaits us a long wait:

![Loading2](https://imgur.com/lzraSxc.png)

Now for the finishing touches, we select a country of the mirror to download the package manager (I selected mine):

![package manager mirror countries](https://imgur.com/KFcWNfg.png)

Select a mirror:

![Select a mirror](https://imgur.com/qQrdrIt.png)

If you have a proxy configure it but it will probably be left blank:

![ERGO PROXY](https://imgur.com/apo9lb7.png)

More loading:

![Loading3](https://imgur.com/1vFmeuV.png)

Prompt to send Anonymous data:

![data mining](https://imgur.com/hIT7Muo.png)

Now to the software selection (uncheck all):

![software selection](https://imgur.com/ce9EUEb.png)

Now to install the boot loader into the `/boot` partition:

![install grub yes](https://imgur.com/pF7dUWu.png)

![/dev/sda or /boot partition](https://imgur.com/TECBdVm.png)

And we're done!

![finished](https://imgur.com/PAHnvRm.png)


## *sudo*

### Step 1: Installing *sudo*

Switch to *root* and its environment via `su -`.

```
$ su -
Password:
#
```

Install *sudo* via `apt install sudo`.

```
# apt install sudo
```

Verify whether *sudo* was successfully installed via `dpkg -l | grep sudo`.

```
# dpkg -l | grep sudo
```

### Step 2: Adding User to *sudo* Group

Add user to *sudo* group via `adduser <username> sudo`.

```
# adduser <username> sudo
```

>Alternatively, add user to *sudo* group via `usermod -aG sudo <username>`.

>```
># usermod -aG sudo <username>
>```

Verify whether user was successfully added to *sudo* group via `getent group sudo`.

```
$ getent group sudo
```

`reboot` for changes to take effect, then log in and verify *sudopowers* via `sudo -v`.

```
# reboot
<--->
Debian GNU/Linux 10 <hostname> tty1

<hostname> login: <username>
Password: <password>
<--->
$ sudo -v
[sudo] password for <username>: <password>
```

### Step 3: Running *root*-Privileged Commands

From here on out, run *root*-privileged commands via prefix `sudo`. For instance:

```
$ sudo apt update
```

### Step 4: Configuring *sudo*

Configure *sudo* via `sudo visudo /etc/sudoers.d/<filename>`. `<filename>` shall not end in `~` or contain `.`.

```
$ sudo visudo /etc/sudoers.d/<filename>
```

To limit authentication using *sudo* to 3 attempts *(defaults to 3 anyway)* in the event of an incorrect password, add below line to the file.

```
Defaults        passwd_tries=3
```

To add a custom error message in the event of an incorrect password:

```
Defaults        badpass_message="<custom-error-message>"
```

To log all *sudo* commands to `/var/log/sudo/sudo.log`:

```
Defaults        logfile="/var/log/sudo/sudo.log"
```

To archive all *sudo* inputs & outputs to `/var/log/sudo/`:

```
Defaults        log_input,log_output
Defaults        iolog_dir="/var/log/sudo"
```

To require *TTY*:
 
```
Defaults        requiretty
```

To set *sudo* paths to `/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin`:

```
Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
```

## *SSH*

### Step 1: Installing & Configuring SSH

Install *openssh-server* via `sudo apt install openssh-server`.

```
$ sudo apt install openssh-server
```

Verify whether *openssh-server* was successfully installed via `dpkg -l | grep ssh`.

```
$ dpkg -l | grep ssh
```

Configure SSH via `sudo vi /etc/ssh/sshd_config`.

```
$ sudo vi /etc/ssh/sshd_config
```

To set up SSH using Port 4242, replace below line:

```
13 #Port 22
```

with:

```
13 Port 4242
```

To disable SSH login as *root* irregardless of authentication mechanism, replace below line

```
32 #PermitRootLogin prohibit-password
```

with:

```
32 PermitRootLogin no
```

Check SSH status via `sudo service ssh status`.

```
$ sudo service ssh status
```
 
>Alternatively, check SSH status via `systemctl status ssh`.

>```
>$ systemctl status ssh
>```

### Step 2: Installing & Configuring UFW

Install *ufw* via `sudo apt install ufw`.

```
$ sudo apt install ufw
```

Verify whether *ufw* was successfully installed via `dpkg -l | grep ufw`.

```
$ dpkg -l | grep ufw
```

Enable Firewall via `sudo ufw enable`.

```
$ sudo ufw enable
```

Allow incoming connections using Port 4242 via `sudo ufw allow 4242`.

```
$ sudo ufw allow 4242
```

Check UFW status via `sudo ufw status`.

```
$ sudo ufw status
```

### Step 3: Connecting to Server via SSH

SSH into your virtual machine using Port 4242 via `ssh <username>@<ip-address> -p 4242`.

```
$ ssh <username>@<ip-address> -p 4242
```

Terminate SSH session at any time via `logout`.

```
$ logout
```

>Alternatively, terminate SSH session via `exit`.
>```
>$ exit
>```

## User Management

See https://ostechnix.com/how-to-set-password-policies-in-linux/

### Step 1: Setting Up a Strong Password Policy

#### Password Age

Configure password age policy via `sudo vi /etc/login.defs`.

```
$ sudo vi /etc/login.defs
```

To set password to expire every 30 days, replace below line

```
160 PASS_MAX_DAYS   99999
```

with:

```
160 PASS_MAX_DAYS   30
```

To set minimum number of days between password changes to 2 days, replace below line

```
161 PASS_MIN_DAYS   0
```

with:

```
161 PASS_MIN_DAYS   2
```

To send user a warning message 7 days *(defaults to 7 anyway)* before password expiry, keep below line as is.

```
162 PASS_WARN_AGE   7
```

#### Password Strength

Secondly, to set up policies in relation to password strength, install the *libpam-pwquality* package.

```
$ sudo apt install libpam-pwquality
```

Verify whether *libpam-pwquality* was successfully installed via `dpkg -l | grep libpam-pwquality`.

```
$ dpkg -l | grep libpam-pwquality
```

The password policies are defined in **/etc/pam.d/common-password** file. Before making any changes, backup this file.

```
$ sudo cp /etc/pam.d/common-password /etc/pam.d/common-password.bak
```

Configure password strength policy via `sudo vi /etc/pam.d/common-password`, specifically the below line:

```
$ sudo vi /etc/pam.d/common-password
<~~~>
25 password        requisite                       pam_pwquality.so retry=3
<~~~>
```

To set password minimum length to 10 characters, add below option to the above line.

```
minlen=10
```

To require password to contain at least an uppercase character and a numeric character:
 
```
ucredit=-1 dcredit=-1
```

To set a maximum of 3 consecutive identical characters:

```
maxrepeat=3
```

To reject the password if it contains `<username>` in some form:

```
reject_username
```

To set the number of changes required in the new password from the old password to 7:

```
difok=7
```

To implement the same policy on *root*:

```
enforce_for_root
```

Finally, it should look like the below:

```
password        requisite                       pam_pwquality.so retry=3 minlen=10 ucredit=-1 dcredit=-1 maxrepeat=3 reject_username difok=7 enforce_for_root
```

### Step 2: Creating a New User

Create new user via `sudo adduser <username>`.

```
$ sudo adduser <username>
```

Verify whether user was successfully created via `getent passwd <username>`.

```
$ getent passwd <username>
```

Verify newly-created user's password expiry information via `sudo chage -l <username>`.

```
$ sudo chage -l <username>
Last password change					: <last-password-change-date>
Password expires					: <last-password-change-date + PASS_MAX_DAYS>
Password inactive					: never
Account expires						: never
Minimum number of days between password change		: <PASS_MIN_DAYS>
Maximum number of days between password change		: <PASS_MAX_DAYS>
Number of days of warning before password expires	: <PASS_WARN_AGE>
```

### Step 3: Creating a New Group

Create new *user42* group via `sudo addgroup user42`.

```
$ sudo addgroup user42
```

Add user to *user42* group via `sudo adduser <username> user42`.

```
$ sudo adduser <username> user42
```

>Alternatively, add user to *user42* group via `sudo usermod -aG user42 <username>`.

>```
>$ sudo usermod -aG user42 <username>
>```

Verify whether user was successfully added to *user42* group via `getent group user42`.

```
$ getent group user42
```

## Script

I recommend you do the script in the host then using [virtualbox's guest additions](https://linuxize.com/post/how-to-install-virtualbox-guest-additions-on-debian-10/) copy paste the contents. Or even easier connect by SSH.

## *cron*

<sub>see https://phoenixnap.com/kb/set-up-cron-job-linux</sub>

### Setting Up a *cron* Job

Configure *cron* as *root* via `sudo crontab -u root -e`.

```
$ sudo crontab -u root -e
```

To schedule a shell script to run every 10 minutes, replace below line

```
23 # m h  dom mon dow   command
```

with:

```
23 */10 * * * * sh /path/to/script
```

Check *root*'s scheduled *cron* jobs via `sudo crontab -u root -l`.

```
$ sudo crontab -u root -l
```

## Useful commands

### SSH commands

check ssh status:

`sudo service ssh status`

`sudo systemctl status ssh`

restart ssh:

`service ssh restart`

ssh:
```
>ssh <username>@<ip-address> -p 4242
>logout
>exit
```

### What to check?

Check partitions:

`lsblk`

AppArmor status:

`sudo aa-status`

sudo and user42 group users:

`getent group sudo`

`getent group user42` 

ssh status:

`sudo service ssh status`

ufw status:

`sudo ufw status`

connect to VM through ssh:

`ssh username@ipadress -p 4242` 

sudo config file, You can `$ ls /etc/sudoers.d` first:

`nano /etc/sudoers.d/<filename>`

password expire policy:

`nano /etc/login.defs` 

password policy:

`nano /etc/pam.d/common-password`

cron schedule:

`sudo crontab -l`

### New user

creating new user:

```
$ sudo adduser username
$ sudo chage -l username 
$ sudo adduser username sudo |
$ sudo adduser username user42
```

### Groups

create group:

`sudo groupadd <group>`

Verify group:

`getent group`

adding user in a group:

`# adduser <username> <group>`

`# usermod -aG <group> <username>`

Verify if sucessfull:

`getent group <group>`

Check which groups user account belongs:

`groups`


### Change Hostname

Check current hostname

`hostnamectl`

Change the hostname

`hostnamectl set-hostname <new_hostname>`

Change /etc/hosts file:

`sudo nano /etc/hosts`

Change old_hostname with new_hostname:

```
127.0.0.1       localhost
127.0.0.1       new_hostname
```

Reboot and check the change
`sudo reboot`


### How to add and remove port ***x*** in UFW?
Allow:

`sudo ufw allow 8080`

Check: 

`sudo ufw status` 

Deny:

`sudo ufw deny 8080`

check UFW status:

`sudo ufw status numbered`

Delete:

`sudo ufw delete <number>`

To stop script running on boot you just need to remove or commit
@reboot /path/to/monitoring.sh

## Bonus

## Lighttpd
	
**Lighttpd** is an open-source web server known for being fast, secure and optimized for less memory consumption than its pairs. 

Now you can install lighttpd.

```sh
# aptitude install lighttpd
```

After installation is complete, you can use the following commands to start and enable lighttpd at startup. Don't forget to also check its status and current version. 

```sh
# lighttpd -v
# systemctl start lighttpd
# systemctl enable lighttpd
# systemctl status lighttpd
```

Now, you will need to allow HTTP traffic in you Firewall.
```sh
# ufw allow http
``` 
The default port for `http` traffic is `80`. Make sure it is already [included](screenshots/41.png) on your firewall settings. 
```sh
# ufw status
``` 

## MariaDB

**MariaDB** is an open source database management system that is a sort-of replacement for the MySQL database technology, being very much compatible and even sharing some of its own commands. It is SQL based and completely free. 

To install `MariaDB` on your server, you must do the following steps:

```sh
# aptitude install mariadb-server
```

Same thing as done in `lighttpd`, you must make sure to start and enable `MariaDB` on startup:
```sh
# systemctl start mariadb
# systemctl enable mariadb
# systemctl status mariadb
```

Then, you should make sure to secure MariaDB server with the following command:

```sh
# mysql_secure_installation
```
You should configure your MariaDB like:

```sh
# Switch to unix_socket authentication [Y/n]: Y
# Enter current password for root (enter for none): Enter
# Set root password? [Y/n]: Y
# New password: ************
# Re-enter new password: ************
# Remove anonymous users? [Y/n]: Y
# Disallow root login remotely? [Y/n]: Y
# Remove test database and access to it? [Y/n]:  Y
# Reload privilege tables now? [Y/n]:  Y
```

Then, you must restart `MariaDB` service:
```sh
# systemctl restart mariadb
```

Now that you already have a database management system installed, you will need to configure a Database to host your Wordpress site. 

```sh
# mysql -u root -p
```

You will be asked to enter your DB password. Then, you can create de Database for your Wordpress site. The final result should look like:

```
MariaDB [(none)]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| <database-name>    |
| information_schema |
+--------------------+
```

To do so, use the following comands on the MariaDB terminal:

```txt
MariaDB [(none)]> CREATE DATABASE wordpress;
MariaDB [(none)]> CREATE USER 'admin'@'localhost' IDENTIFIED BY 'WPadm1n';
MariaDB [(none)]> GRANT ALL ON wordpress.* TO 'admin'@'localhost' IDENTIFIED BY 'WPadm1n' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EXIT;
```

## PHP

**PHP** is a well-known and open-source scripting language for servers that is quite popular to develop web pages. You will need to install it in order to allow proper functioning of the Wordpress website you will try to create. For this activity, we will install the last available PHP version, which currently is `8.0`.

> If you're using Debian you you need to install some repositories in order to be able to install `php 8.0`. 
> ```sh
> # aptitude install -y lsb-release ca-certificates apt-transport-https software-properties-common
> # echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list
> # wget -qO - https://packages.sury.org/php/apt.gpg | sudo apt-key add -
> # aptitude update
> # aptitude install php8.0
> ```

You must install PHP and some of its modules that might be helpful to create a full operational Wordpress website. Only `php-cgi` `php-common` `php-cli` and `php-mysql` are in fact, fundamental to this project. However, I chose to download some other in order to, in the future, be able to expand my website's functionality. You may choose any packages you may find interesting. 

```sh
# aptitude install php-cgi php-common php-cli php-mysql php-gd php-imagick php-recode php-tidy php-xml php-xmlrpc php-fpm
```

It is ok if `php-recode` doesn't install.

After installing all the php packages, you will need to configure some extra details. First, you will need to make sure `Apache2`is not installed in your server. It might be so thanks to php dependencies or even a pre-installation option you might have accidentely flagged. If it is, remove it completely from it, as so not to create any clashes between the two http servers.

```sh
# aptitude purge apache2
```
Then, you will need to configure some php info:

```sh
# nano /etc/php/<version>/cgi/php.ini
```

make it look like:

![cgi.fix_pathinfo=1](https://imgur.com/6JZ89t7.png)

In nano you can use <kbd>Ctrl</kbd> + <kbd>W</kbd> to find `cgi.fix_pathinfo=1` and uncomment it.

Now, you must activate the modules for `fastcgi` using the following comands:

```sh
# lighty-enable-mod fastcgi
# lighty-enable-mod fastcgi-php
```

Do restart the service:

```
service lighttpd force-reload
```

Now you can check if your connection is working properly by creating an information file to be displayed at your local browser:
```sh
# nano /var/www/html/info.php
```
```
<?php phpinfo(); ?>
```

Then you can try and access it going to you `http://'your-ip-address'/info.php`. Your webpage should display something like:

![phpinfo](https://i.imgur.com/gVQM0DD.png)
After delete `info.php` as it is a security vulnerability. 

If everything is according to the plan, you can now install and create your Wordpress website. 

##	Wordpress

To install **Wordpress** into your computer, you must first make sure you have the `wget` and `tar` packages installed. 

```sh
# aptitude install wget
# aptitude install tar
```

After that, you can download the latest available release of Wordpress and unzip it:
```sh
# wget http://wordpress.org/latest.tar.gz
# tar -xzvf latest.tar.gz
# mv wordpress/* /var/www/html/
# rm -rf latest.tar.gz wordpress
```

Create a Wordpress configuration file from its downloaded sample, and then edit it:
```sh
# mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
# vim /var/www/html/wp-config.php
```

You must alter the 3 lines that specify the `DB name`, `DB user`, `DB password` and `DB host`.

Lastly, you must change your wordpress folders permitions:

```sh
# chown -R www-data:www-data /var/www/html/
# chmod -R 755 /var/www/html/
```

At last, restart `lighttpd` again and we are finally able to go to the computer's browser and type (might be different if using UTM):

```txt
http://127.0.0.1/
```
Make sure you have port forwarding `80 <--> 80` configured in the VirtualBox. 


The configuration menu for Wordpress should appear. You may configure it as you wish. Once it's all set, you may configure it as you wish: the sky is the limit!

##	Fail2ban


We decided to install, as part of the last bonus task, `Fail2Ban`, a service that gives an extra layer of protection to any other service that connects through password with your server. 

`Fail2Ban` finds failed login attempts using your service's `log` and blocks new attempts at login from those IPs. In doing so, it disencourages hackers and people with malicious intetions from accessing your server in full. 

We will install `Fail2Ban` and configure it so it blocks remote attempts from SSH connections that typed the wrong password more than a few times.

`Fail2Ban` can be found on the `EPEL` repository, which was already enabled previously on our machine. You can install it normally:

```sh
# aptitude install fail2ban
```
Then, you can start it. I chose **not** to enable it at startup:
```sh
# systemctl start fail2ban
```

You will need to create and edit the `/etc/fail2ban/jail.local` with some [new configuration settings](screenshots/60.png) regarding ssh service, in order to activate `fail2ban` on your computer. You must then restart the service.

```sh
# cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
# systemctl restart fail2ban
# systemctl status fail2ban
```

Since we're using a different port for ssh (port 4242), we will also need to edit the `/etc/fail2ban/jail.conf` to add the ssh port accordinly. You may choose to edit everything through this file, if you prefer. 

To find status of failed and banned IP address, and the log file for `fail2ban`:
```sh
# fail2ban-client status
# fail2ban-client status sshd
# tail -f /var/log/fail2ban.log
```

## File Transfer Protocol *(FTP)*

#### Step 1: Installing & Configuring FTP

Install FTP via `sudo apt install vsftpd`.

```
$ sudo apt install vsftpd
```

Verify whether *vsftpd* was successfully installed via `dpkg -l | grep vsftpd`.

```
$ dpkg -l | grep vsftpd
```

Allow incoming connections using Port 21 via `sudo ufw allow 21`.

```
$ sudo ufw allow 21
```

Configure *vsftpd* via `sudo vi /etc/vsftpd.conf`.

```
$ sudo vi /etc/vsftpd.conf
```

To enable any form of FTP write command, uncomment below line:

```
31 #write_enable=YES
```

To set root folder for FTP-connected user to `/home/<username>/ftp`, add below lines:

```
$ sudo mkdir /home/<username>/ftp
$ sudo mkdir /home/<username>/ftp/files
$ sudo chown nobody:nogroup /home/<username>/ftp
$ sudo chmod a-w /home/<username>/ftp
<~~~>
user_sub_token=$USER
local_root=/home/$USER/ftp
<~~~>
```

To prevent user from accessing files or using commands outside the directory tree, uncomment below line:

```
114 #chroot_local_user=YES
```

To whitelist FTP, add below lines:
 
```
$ sudo vi /etc/vsftpd.userlist
$ echo <username> | sudo tee -a /etc/vsftpd.userlist
<~~~>
userlist_enable=YES
userlist_file=/etc/vsftpd.userlist
userlist_deny=NO
<~~~>
```

#### Step 2: Connecting to Server via FTP

FTP into your virtual machine via `ftp <ip-address>`.

```
$ ftp <ip-address>
```

Terminate FTP session at any time via `CTRL + D`.

## Resources

[***Explanation of terms and whys***](https://reposhub.com/linux/miscellaneous/RyouYoo-Born2beroot.html)
[***Evaluator tools***](https://web.archive.org/web/20220105193028/https://github.com/HEADLIGHTER/Born2BeRoot-42/blob/main/evalknwoledge.txt)
[***Wordpress Website***](https://wordpress.com/)
[***Lighttpd Website***](https://www.lighttpd.net/)
[_**MariaDB Website**_](https://mariadb.org/)
[_**How to install WordPress with lighttpd on Debian 10?**_](https://www.osradar.com/install-wordpress-with-lighttpd-debian-10/)
[_**How to Install Lighttpd with PHP and MariaDB on CentOS/RHEL 8/7**_](https://www.tecmint.com/install-lighttpd-with-php-fpm-mariadb-on-centos/)
[_**How to Install PHP on Debian 11**_](https://computingforgeeks.com/how-to-install-php-on-debian-linux/)
