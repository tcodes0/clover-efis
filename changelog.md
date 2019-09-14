## sep 13

config-asus - config I was able to boot with before (args-device-smbios)
config.plist - bare olarila config
config-args-device - has args and devices from asus but no smbios
config-device - has device but no args or smbios from asus
config-asus-shutdown - asus + EC ACPI patch rename + slide=o (needs EmuVariable-Uefi-64.efi or OsxAptioFix2Drv-free2000)

branch update/clover-5070 has clover 70 and efis on 3e50b570b3a363df0bcd1585931b292a4127028e folder EFI
efi-vanilla has old ass clover
efi-old, whatever stuff was in ther before
efi-shuwdown has clover 5070 with mem fix drivers
efi has 5070 release (shutdown too)

## sep 8

Got in good shape with asus graphic patch, but stopped working after two boots.

Config.plist is the closest state to working
