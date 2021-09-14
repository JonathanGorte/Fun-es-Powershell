# Powershell Functions
Those are just some functions i made for personal use, they are mostly for file processing.\
I recommend adding those to a PowerShell profile.\
**Warning:** The comments are all in portuguese, however the variables and most of the text shown in console are in english. In case anyone ever comes by this and wants the file with english comments just ask.


## magickConvertAll:
Makes use of the tool [imageMagick](https://imagemagick.org) to convert all png and jpg files in a folder and subfolders to jpgs utilizing a specific quality. It can be easily converted to work with other formats or for similar purposes.\
This code is not completely otimized and could use some improvements.\
**WARNING:** The use of this function will REPLACE all the affected files, in case you are not sure about what you are doing make a backup first.

Usage:
> magickConvertAll "C:\CAMINHO\DA\PASTA" imageQuality imageSizeInMB

The following example converts all png and jpg files that are 2MB or larger into jpgs with 80% quality:
> magickConvertAll "C:\Users\Default\Pictures" 80 2

This process can be slow, using a Ryzen 5 3500X it took about 1 hour to finish.\
I haven't noticed any excessive RAM or CPU usage with files up to 30MB~, however i did not try anything beyond that. It is worth saying that the disk usage can be quite high, so systems running on HDD might experience slowness during the operation.
 
