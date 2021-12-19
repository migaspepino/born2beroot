# #Born2beroot

**Version 1 of the Born2beroot exercise**
<sub>Thanks to [hanshazairi](https://github.com/hanshazairi/42-born2beroot)!</sub>

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
