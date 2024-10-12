İşte Linux'ta farklı türde yüklenebilir uygulama paketleri ve bunların nasıl kurulacağına dair bilgiler:

1. .deb (Debian Package)
   Dağıtım: Debian, Ubuntu, Linux Mint
   Kurulum: `sudo dpkg -i paket_adı.deb` veya `sudo apt install ./paket_adı.deb`

2. .rpm (Red Hat Package Manager)
   Dağıtım: Fedora, CentOS, RHEL
   Kurulum: `sudo rpm -i paket_adı.rpm` veya `sudo dnf install paket_adı.rpm`

3. .tar.gz (Compressed Tarball)
   Dağıtım: Herhangi bir Linux dağıtımı
   Kurulum: 
   ```
   tar -xzvf paket_adı.tar.gz
   cd paket_adı
   ./configure
   make
   sudo make install
   ```

4. .tar.xz (XZ Compressed Tarball)
   Dağıtım: Herhangi bir Linux dağıtımı
   Kurulum: 
   ```
   tar -xJvf paket_adı.tar.xz
   cd paket_adı
   ./configure
   make
   sudo make install
   ```

5. .tar.bz2 (Bzip2 Compressed Tarball)
   Dağıtım: Herhangi bir Linux dağıtımı
   Kurulum:
   ```
   tar -xjvf paket_adı.tar.bz2
   cd paket_adı
   ./configure
   make
   sudo make install
   ```

6. .AppImage (AppImage)
   Dağıtım: Herhangi bir Linux dağıtımı
   Kurulum: Çalıştırılabilir yapın ve çalıştırın: `chmod +x paket_adı.AppImage && ./paket_adı.AppImage`

7. .flatpak (Flatpak)
   Dağıtım: Flatpak destekleyen herhangi bir dağıtım
   Kurulum: `flatpak install paket_adı.flatpak`

8. .snap (Snap Package)
   Dağıtım: Snap destekleyen herhangi bir dağıtım
   Kurulum: `sudo snap install paket_adı.snap`

9. .pkg.tar.zst (Arch Linux Package)
   Dağıtım: Arch Linux, Manjaro
   Kurulum: `sudo pacman -U paket_adı.pkg.tar.zst`

10. .tgz (Gzipped Tarball)
    Dağıtım: Herhangi bir Linux dağıtımı
    Kurulum: Tar.gz ile aynı adımları izleyin

11. .run (Run File)
    Dağıtım: Herhangi bir Linux dağıtımı
    Kurulum: `chmod +x paket_adı.run && ./paket_adı.run`

12. .sh (Shell Script)
    Dağıtım: Herhangi bir Linux dağıtımı
    Kurulum: `chmod +x paket_adı.sh && ./paket_adı.sh`

13. .bin (Binary File)
    Dağıtım: Herhangi bir Linux dağıtımı
    Kurulum: `chmod +x paket_adı.bin && ./paket_adı.bin`

14. .bundle (Ruby Bundle)
    Dağıtım: Ruby yüklü herhangi bir Linux dağıtımı
    Kurulum: `ruby paket_adı.bundle`

15. .gem (Ruby Gem)
    Dağıtım: Ruby yüklü herhangi bir Linux dağıtımı
    Kurulum: `gem install paket_adı.gem`

16. .py (Python Script)
    Dağıtım: Python yüklü herhangi bir Linux dağıtımı
    Kurulum: `python paket_adı.py`

17. .pkg (PackageMaker Package)
    Dağıtım: Bazı özel Linux dağıtımları
    Kurulum: Genellikle çift tıklama ile kurulur veya özel bir komut gerektirir

18. .eopkg (Solus Package)
    Dağıtım: Solus
    Kurulum: `sudo eopkg install paket_adı.eopkg`

19. .pisi (Pardus Package)
    Dağıtım: Pardus
    Kurulum: `sudo pisi install paket_adı.pisi`

20. .txz (XZ Compressed Tarball)
    Dağıtım: Herhangi bir Linux dağıtımı
    Kurulum: Tar.xz ile aynı adımları izleyin

Bu liste, Linux'ta karşılaşabileceğiniz yaygın paket türlerini ve bunların nasıl kurulacağını göstermektedir. Bazı paketler belirli dağıtımlara özgü olsa da, çoğu genel amaçlı ve birçok dağıtımda kullanılabilir.