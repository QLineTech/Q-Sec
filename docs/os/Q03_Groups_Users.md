### Linux'ta Grup ve Kullanıcı Yönetimi Rehberi

Bu rehber, Linux sistemlerinde **kullanıcı (user)** ve **grup (group)** yönetimi için temel komutları kapsar. İşlemler **root** yetkisi veya `sudo` ile gerçekleştirilmelidir. Komutlar Debian/Ubuntu (APT) ve Red Hat/CentOS (YUM/DNF) tabanlı sistemlerde genel olarak uyumludur; farklar belirtilmiştir.

---

#### **1. Kullanıcı (User) İşlemleri**

| İşlem | Komut | Açıklama |
|-------|-------|----------|
| **Kullanıcı listeleme** | `cat /etc/passwd` <br> `getent passwd` | Tüm kullanıcıları gösterir. Her satır: `kullanici:x:UID:GID:yorum:ev_dizini:shell` |
| | `id kullanci_adi` | Belirli kullanıcının UID, GID ve gruplarını gösterir. |
| | `cut -d: -f1 /etc/passwd` | Sadece kullanıcı adlarını listeler. |
| **Kullanıcı ekleme** | `sudo useradd kullanci_adi` | Yeni kullanıcı oluşturur (varsayılan ayarlarla). |
| | `sudo useradd -m -s /bin/bash kullanci_adi` | Ev dizini (`-m`) ve shell (`-s`) ile oluşturur. |
| | `sudo passwd kullanci_adi` | Kullanıcıya şifre atar. |
| **Kullanıcı silme** | `sudo userdel kullanci_adi` | Kullanıcıyı siler (ev dizini kalır). |
| | `sudo userdel -r kullanci_adi` | Kullanıcıyı ve ev dizinini siler. |
| **Kullanıcı güncelleme** | `sudo usermod -L kullanci_adi` | Kullanıcıyı kilitler (giriş engellenir). |
| | `sudo usermod -U kullanci_adi` | Kullanıcının kilidini açar. |
| | `sudo usermod -aG grup_adi kullanci_adi` | Kullanıcıyı ek gruba ekler. |
| | `sudo usermod -s /bin/zsh kullanci_adi` | Kullanıcının shell'ini değiştirir. |

---

#### **2. Grup (Group) İşlemleri**

| İşlem | Komut | Açıklama |
|-------|-------|----------|
| **Grup listeleme** | `cat /etc/group` <br> `getent group` | Tüm grupları gösterir. Her satır: `grup:x:GID:uye1,uye2,...` |
| | `groups kullanci_adi` | Kullanıcının ait olduğu grupları gösterir. |
| | `cut -d: -f1 /etc/group` | Sadece grup adlarını listeler. |
| **Grup ekleme** | `sudo groupadd grup_adi` | Yeni grup oluşturur. |
| | `sudo groupadd -g 1005 grup_adi` | Belirli GID ile grup oluşturur. |
| **Grup silme** | `sudo groupdel grup_adi` | Grubu siler (boş olmalıdır). |
| **Grup güncelleme** | `sudo groupmod -n yeni_ad eski_ad` | Grup adını değiştirir. |
| | `sudo gpasswd -A kullanci_adi grup_adi` | Kullanıcıyı grup yöneticisi yapar. |
| | `sudo gpasswd -d kullanci_adi grup_adi` | Kullanıcıyı gruptan çıkarır. |

---

#### **3. Kullanıcıyı Gruba Ekleme / Çıkarma (Kısa Yöntemler)**

| İşlem | Komut | Açıklama |
|-------|-------|----------|
| **Kullanıcıyı gruba ekleme** | `sudo usermod -aG grup_adi kullanci_adi` | `-a` (append) olmadan önceki gruplar silinir! |
| | `sudo adduser kullanci_adi grup_adi` *(Debian tabanlı)* | Kullanıcıyı gruba ekler. |
| **Kullanıcıyı gruptan çıkarma** | `sudo gpasswd -d kullanci_adi grup_adi` | Kullanıcıyı gruptan çıkarır. |

---

#### **4. Önemli Dosyalar**

| Dosya | Açıklama |
|-------|----------|
| `/etc/passwd` | Kullanıcı bilgileri (şifre hash'leri burada **değildir**). |
| `/etc/shadow` | Şifre hash'leri (sadece root okur). |
| `/etc/group` | Grup bilgileri ve üyeler. |
| `/etc/sudoers` | `sudo` yetkileri (visudo ile düzenleyin). |

---

#### **5. Pratik Örnekler**

```bash
# Yeni kullanıcı oluştur ve şifre ata
sudo useradd -m -s /bin/bash ahmet
sudo passwd ahmet

# Kullanıcıyı "developers" grubuna ekle
sudo groupadd developers
sudo usermod -aG developers ahmet

# Kullanıcının gruplarını kontrol et
groups ahmet

# Kullanıcıyı gruptan çıkar
sudo gpasswd -d ahmet developers

# Kullanıcıyı tamamen sil
sudo userdel -r ahmet
```

---

#### **6. Güvenlik ve En İyi Uygulamalar**

- **Her zaman `-aG` kullanın**: `usermod -G` ile ek grup atarken `-a` olmadan mevcut gruplar silinir.
- **GID/UID çakışmasını önleyin**: Aynı ID'ler güvenlik riski oluşturur.
- **Şifre politikası**: `chage` komutu ile şifre yaşlandırma ayarlayın.
- **Sistem gruplarını silmeyin**: `wheel`, `sudo`, `adm` gibi gruplar kritik olabilir.

---

Bu rehber, temel yönetim işlemlerini kapsar. Gelişmiş senaryolar için `man useradd`, `man groupadd` gibi manuel sayfaları inceleyin.
