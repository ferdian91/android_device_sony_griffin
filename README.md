### TWRP for XPERIA 1 & 5 (KUMANO)

- What's working?
  - Decrypt Internal Storage
  - Flashing .zip and .img
  - Backup and Restore (system,vendor,data,oem etc)
  - USB-OTG
  - Reboot Slot A/B
  - ADB & MTP mode
  - Screen Brightness
  - Vibration
  - exFat/NTFS
  - support for X5
  - etc.

- Bugs and Issues?
  - restore modem
###
NULL FSCRYPT.
extractTarFork() process ended with ERROR: 255
##
* tested install rom (.img) and gapps (.zip)
* tested on stock rom a11 and XperiaUI a13.
* tested backup and restore partition /data
* tested using lock pattern, if the phone is locked. TWRP also automatically asks for a password
##
if you want to install rom from twrp, don't forget to disable vbmeta verification.
