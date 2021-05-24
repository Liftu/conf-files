# Themes

## Backups

```bash
sudo cp /etc/default/grub /etc/default/grub.bak
```

## Gnome Shell

- Orchis : https://github.com/vinceliuice/Orchis-theme

### Nautilus :

- Right click -> New file : https://github.com/angela-d/nautilus-right-click-new-file
- Copy path (remove "Copy URI"): https://github.com/chr314/nautilus-copy-path

## GTK Applications

- Orchis : https://github.com/vinceliuice/Orchis-theme

## Icons

- Tela : https://github.com/vinceliuice/Tela-icon-theme
- Tela circular : https://github.com/vinceliuice/Tela-circle-icon-theme

## Cursors

- Vimix (`sudo ./install && sudo update-alternatives --config x-cursor-theme`): https://github.com/vinceliuice/Vimix-cursors

## Grub

- BigSur : https://github.com/Teraskull/bigsur-grub2-theme

## Splash screen

- Plymouth : `sudo sed 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/g' /etc/default/grub -i`
