# SED: Akış Düzenleyici <sub>(Stream Editor)</sub>

`sed` (Akış Düzenleyici <sub>Stream Editor</sub>), metin işleme ve dönüştürme için kullanılan güçlü bir araçtır. Unix benzeri işletim sistemlerinde metin manipülasyonu görevleri için yaygın olarak kullanılır.

## sed nedir?

`sed`, metni satır satır işleyen etkileşimli olmayan bir komut satırı yardımcı programıdır. Arama, bulma ve değiştirme, ekleme ve silme gibi çeşitli işlemleri gerçekleştirebilir.

## Parametreler

İşte yaygın `sed` parametrelerinin bir tablosu:

| Parametre | Açıklama |
|-----------|----------|
| `-n`      | Desen alanının otomatik yazdırılmasını bastırır |
| `-e`      | Betiği yürütülecek komutlara ekler |
| `-f`      | Betik dosyasının içeriğini yürütülecek komutlara ekler |
| `-i`      | Dosyaları yerinde düzenler |
| `-r`      | Genişletilmiş düzenli ifadeler kullanır |

## Nasıl Yüklenir

### Unix benzeri sistemlerde (Linux, macOS)

`sed` genellikle çoğu Unix benzeri sistemde önceden yüklüdür. Eğer mevcut değilse, paket yöneticinizi kullanarak yükleyebilirsiniz:

Debian/Ubuntu için:
```bash
sudo apt-get install sed
```

macOS için (Homebrew kullanarak):
```bash
brew install gnu-sed
```

### Windows'ta

Windows için şunları kullanabilirsiniz:

1. Windows Subsystem for Linux (WSL)
2. Cygwin
3. Git Bash (Git for Windows ile birlikte gelir)

## Kullanım Örnekleri

İşte 30'dan fazla açıklamalı `sed` komut örneği:

1. Belirli satırları yazdırma:
   ```bash
   sed -n '1p' dosya.txt  # İlk satırı yazdır
   ```

2. Belirli satırları silme:
   ```bash
   sed '1d' dosya.txt  # İlk satırı sil
   ```

3. Metin değiştirme:
   ```bash
   sed 's/eski/yeni/' dosya.txt  # 'eski'nin ilk geçtiği yeri 'yeni' ile değiştir
   ```

4. Tüm geçişleri değiştirme:
   ```bash
   sed 's/eski/yeni/g' dosya.txt  # 'eski'nin tüm geçişlerini 'yeni' ile değiştir
   ```

5. Belirli satırlarda değiştirme:
   ```bash
   sed '1,5s/eski/yeni/g' dosya.txt  # 1-5 satırları arasında değiştir
   ```

6. Büyük/küçük harf duyarsız değiştirme:
   ```bash
   sed 's/eski/yeni/gI' dosya.txt  # Büyük/küçük harf duyarsız değiştirme
   ```

7. Boş satırları silme:
   ```bash
   sed '/^$/d' dosya.txt  # Boş satırları sil
   ```

8. Bir desene uyan satırları silme:
   ```bash
   sed '/desen/d' dosya.txt  # 'desen' içeren satırları sil
   ```

9. Bir satırdan önce metin ekleme:
   ```bash
   sed '2i\Eklenen metin' dosya.txt  # 2. satırdan önce metin ekle
   ```

10. Bir satırdan sonra metin ekleme:
    ```bash
    sed '2a\Eklenen metin' dosya.txt  # 2. satırdan sonra metin ekle
    ```

11. Tüm satırı değiştirme:
    ```bash
    sed '3c\Yeni satır içeriği' dosya.txt  # 3. satırı değiştir
    ```

12. Birden fazla sed komutu kullanma:
    ```bash
    sed -e 's/eski/yeni/' -e 's/foo/bar/' dosya.txt
    ```

13. Komutları bir dosyadan okuma:
    ```bash
    sed -f komutlar.sed dosya.txt
    ```

14. Bir desene uyan satırları yazdırma:
    ```bash
    sed -n '/desen/p' dosya.txt
    ```

15. Bir desene uymayan satırları yazdırma:
    ```bash
    sed -n '/desen/!p' dosya.txt
    ```

16. Geri referansla değiştirme:
    ```bash
    sed 's/\(foo\)bar/\1baz/' dosya.txt  # 'foobar'ı 'foobaz' ile değiştir
    ```

17. Birden fazla geri referansla değiştirme:
    ```bash
    sed 's/\(foo\)\(bar\)/\2\1/' dosya.txt  # 'foo' ve 'bar'ı yer değiştir
    ```

18. Adres aralıkları kullanma:
    ```bash
    sed '2,4d' dosya.txt  # 2-4 satırları sil
    ```

19. Adreste düzenli ifadeler kullanma:
    ```bash
    sed '/başlangıç/,/bitiş/d' dosya.txt  # 'başlangıç'tan 'bitiş'e kadar sil
    ```

20. Satırları çoğaltma:
    ```bash
    sed 'p' dosya.txt  # Her satırı çoğalt
    ```

21. Baştaki boşlukları kaldırma:
    ```bash
    sed 's/^[ \t]*//' dosya.txt
    ```

22. Sondaki boşlukları kaldırma:
    ```bash
    sed 's/[ \t]*$//' dosya.txt
    ```

23. Yorumları kaldırma:
    ```bash
    sed 's/#.*$//' dosya.txt  # # ile başlayan yorumları kaldır
    ```

24. Satır numarası ekleme:
    ```bash
    sed = dosya.txt | sed 'N;s/\n/\t/'
    ```

25. DOS'tan Unix satır sonlarına dönüştürme:
    ```bash
    sed 's/\r$//' dosya.txt
    ```

26. Sadece belirli uzunluktaki satırları yazdırma:
    ```bash
    sed -n '/^.\{20\}$/p' dosya.txt  # Tam 20 karakterli satırları yazdır
    ```

27. Belirli sütunda değiştirme:
    ```bash
    sed 's/\(.\{10\}\)eski/\1yeni/' dosya.txt  # 11. karakterden başlayarak 'eski'yi 'yeni' ile değiştir
    ```

28. Satırların sırasını tersine çevirme:
    ```bash
    sed '1!G;h;$p' dosya.txt
    ```

29. Yinelenen satırları kaldırma (sırayı koruyarak):
    ```bash
    sed '$!N; /^\(.*\)\n\1$/!P; D'
    ```

30. Büyük harfe dönüştürme:
    ```bash
    sed 's/\(.*\)/\U\1/' dosya.txt
    ```

31. Küçük harfe dönüştürme:
    ```bash
    sed 's/\(.*\)/\L\1/' dosya.txt
    ```

32. Sadece desen bulunursa değiştirme:
    ```bash
    sed '/foo/s/bar/baz/' dosya.txt  # Sadece 'foo' içeren satırlarda 'bar'ı 'baz' ile değiştir
    ```

Bu örnekler, `sed`'in çok yönlülüğünü ve gücünü göstermektedir. `sed -i` ile yerinde düzenlemeler yapmadan önce her zaman dosyalarınızı yedeklemeyi unutmayın.