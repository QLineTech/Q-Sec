# Grep Komut Kılavuzu: 60 Kullanım Örneği
<sub>(Grep Command Guide: 60 Usage Examples)</sub>

## İçindekiler
<sub>(Table of Contents)</sub>

1. [Giriş](#giriş)
2. [Temel Kullanım](#temel-kullanım)
3. [Düzenli İfadeler](#düzenli-i̇fadeler)
4. [Dosya ve Dizin İşlemleri](#dosya-ve-dizin-i̇şlemleri)
5. [Bağlam Kontrolü](#bağlam-kontrolü)
6. [Çıktı Özelleştirme](#çıktı-özelleştirme)
7. [Performans Optimizasyonu](#performans-optimizasyonu)
8. [İleri Teknikler](#i̇leri-teknikler)
9. [Karmaşık Grep İşlemleri için Bash Betiği](#karmaşık-grep-i̇şlemleri-için-bash-betiği)

## Giriş
<sub>(Introduction)</sub>

`grep` (Global Regular Expression Print) düz metin veri kümelerinde düzenli ifadelerle eşleşen satırları aramak için kullanılan güçlü bir komut satırı aracıdır. Unix benzeri işletim sistemlerinde metin işleme ve veri analizi için temel bir araçtır.

## Temel Kullanım
<sub>(Basic Usage)</sub>

1. **Basit dize araması**
   <sub>(Simple string search)</sub>
   ```bash
   grep "desen" dosya.txt
   ```

2. **Büyük/küçük harf duyarsız arama**
   <sub>(Case-insensitive search)</sub>
   ```bash
   grep -i "desen" dosya.txt
   ```

3. **Satır numaralarını göster**
   <sub>(Display line numbers)</sub>
   ```bash
   grep -n "desen" dosya.txt
   ```

4. **Eşleşen satırları say**
   <sub>(Count matching lines)</sub>
   ```bash
   grep -c "desen" dosya.txt
   ```

5. **Eşleşmeyi tersine çevir (eşleşmeyen satırları göster)**
   <sub>(Invert match)</sub>
   ```bash
   grep -v "desen" dosya.txt
   ```

## Düzenli İfadeler
<sub>(Regular Expressions)</sub>

6. **Satır başı eşleştirme**
   <sub>(Match beginning of line)</sub>
   ```bash
   grep "^desen" dosya.txt
   ```

7. **Satır sonu eşleştirme**
   <sub>(Match end of line)</sub>
   ```bash
   grep "desen$" dosya.txt
   ```

8. **Herhangi bir tek karakteri eşleştirme**
   <sub>(Match any single character)</sub>
   ```bash
   grep "d.sen" dosya.txt
   ```

9. **Sıfır veya daha fazla tekrar**
   <sub>(Match zero or more occurrences)</sub>
   ```bash
   grep "des*en" dosya.txt
   ```

10. **Bir veya daha fazla tekrar**
    <sub>(Match one or more occurrences)</sub>
    ```bash
    grep "des\+en" dosya.txt
    ```

11. **Belirli sayıda tekrar**
    <sub>(Match a specific number of occurrences)</sub>
    ```bash
    grep "des\{3\}en" dosya.txt
    ```

12. **Tekrar aralığı**
    <sub>(Match a range of occurrences)</sub>
    ```bash
    grep "des\{2,4\}en" dosya.txt
    ```

13. **Karakter kümesinde eşleştirme**
    <sub>(Match characters in a set)</sub>
    ```bash
    grep "[aeiou]" dosya.txt
    ```

14. **Karakter kümesi dışında eşleştirme**
    <sub>(Match characters not in a set)</sub>
    ```bash
    grep "[^aeiou]" dosya.txt
    ```

15. **Kelime sınırlarını eşleştirme**
    <sub>(Match word boundaries)</sub>
    ```bash
    grep "\<kelime\>" dosya.txt
    ```

## Dosya ve Dizin İşlemleri
<sub>(File and Directory Operations)</sub>

16. **Birden fazla dosyada arama**
    <sub>(Search multiple files)</sub>
    ```bash
    grep "desen" dosya1.txt dosya2.txt dosya3.txt
    ```

17. **Bir dizindeki tüm dosyalarda arama**
    <sub>(Search all files in a directory)</sub>
    ```bash
    grep "desen" *
    ```

18. **Dosyalarda özyinelemeli arama**
    <sub>(Search files recursively)</sub>
    ```bash
    grep -r "desen" .
    ```

19. **Sadece belirli dosya türlerinde arama**
    <sub>(Search only specific file types)</sub>
    ```bash
    grep --include=\*.{cpp,h} -r "desen" .
    ```

20. **Belirli dosya türlerini hariç tutma**
    <sub>(Exclude specific file types)</sub>
    ```bash
    grep --exclude=\*.o -r "desen" .
    ```

21. **Desenleri içeren bir dosya kullanma**
    <sub>(Use a file containing patterns)</sub>
    ```bash
    grep -f desenler.txt dosya.txt
    ```

## Bağlam Kontrolü
<sub>(Context Control)</sub>

22. **Eşleşmeden önceki satırları göster**
    <sub>(Show lines before match)</sub>
    ```bash
    grep -B 3 "desen" dosya.txt
    ```

23. **Eşleşmeden sonraki satırları göster**
    <sub>(Show lines after match)</sub>
    ```bash
    grep -A 3 "desen" dosya.txt
    ```

24. **Eşleşmeden önce ve sonraki satırları göster**
    <sub>(Show lines before and after match)</sub>
    ```bash
    grep -C 3 "desen" dosya.txt
    ```

25. **Sadece eşleşme olan dosya adlarını göster**
    <sub>(Show only filenames with matches)</sub>
    ```bash
    grep -l "desen" *
    ```

## Çıktı Özelleştirme
<sub>(Output Customization)</sub>

26. **Eşleşmeleri vurgula**
    <sub>(Highlight matches)</sub>
    ```bash
    grep --color "desen" dosya.txt
    ```

27. **Sadece eşleşen kısımları göster**
    <sub>(Show only matched parts)</sub>
    ```bash
    grep -o "desen" dosya.txt
    ```

28. **Hata mesajlarını bastır**
    <sub>(Suppress error messages)</sub>
    ```bash
    grep -s "desen" dosya.txt
    ```

29. **Özel çıktı formatı kullan**
    <sub>(Use custom output format)</sub>
    ```bash
    grep -H "desen" dosya.txt
    ```

30. **Her satırın başına dosya adını ekle**
    <sub>(Prefix each line with filename)</sub>
    ```bash
    grep -H "desen" *
    ```

## Performans Optimizasyonu
<sub>(Performance Optimization)</sub>

31. **Sabit dizeler kullan (düzenli ifade yok)**
    <sub>(Use fixed strings (no regex))</sub>
    ```bash
    grep -F "desen" dosya.txt
    ```

32. **Birden fazla desen kullan**
    <sub>(Use multiple patterns)</sub>
    ```bash
    grep -e "desen1" -e "desen2" dosya.txt
    ```

33. **Büyük dosyalar için optimize et**
    <sub>(Optimize for large files)</sub>
    ```bash
    LC_ALL=C grep "desen" buyuk_dosya.txt
    ```

34. **Paralel işleme kullan**
    <sub>(Use parallel processing)</sub>
    ```bash
    parallel grep "desen" ::: dosya1.txt dosya2.txt dosya3.txt
    ```

35. **İlk eşleşmeden sonra dur**
    <sub>(Stop after first match)</sub>
    ```bash
    grep -m 1 "desen" dosya.txt
    ```

## İleri Teknikler
<sub>(Advanced Techniques)</sub>

36. **Perl uyumlu düzenli ifadeler kullan**
    <sub>(Use Perl-compatible regex)</sub>
    ```bash
    grep -P "\d{3}-\d{2}-\d{4}" dosya.txt
    ```

37. **İkili dosya araması**
    <sub>(Binary file search)</sub>
    ```bash
    grep -a "desen" ikili_dosya
    ```

38. **Sıkıştırılmış dosyalarda arama**
    <sub>(Search compressed files)</sub>
    ```bash
    zgrep "desen" dosya.gz
    ```

39. **Genişletilmiş düzenli ifadeler kullan**
    <sub>(Use extended regex)</sub>
    ```bash
    grep -E "desen1|desen2" dosya.txt
    ```

40. **Null ile ayrılmış çıktı**
    <sub>(Null-separated output)</sub>
    ```bash
    grep -Z "desen" dosya.txt
    ```

41. **Sadece tam kelimeleri eşleştir**
    <sub>(Match whole words only)</sub>
    ```bash
    grep -w "kelime" dosya.txt
    ```

42. **İkili dosyaları yoksay**
    <sub>(Ignore binary files)</sub>
    ```bash
    grep -I "desen" *
    ```

43. **Boş satırları ara**
    <sub>(Search for empty lines)</sub>
    ```bash
    grep "^$" dosya.txt
    ```

44. **ASCII olmayan karakterleri ara**
    <sub>(Search for non-ASCII characters)</sub>
    ```bash
    grep -P "[^\x00-\x7F]" dosya.txt
    ```

45. **İleriye dönük iddiaları kullan**
    <sub>(Use lookahead assertions)</sub>
    ```bash
    grep -P "(?=.*desen1)(?=.*desen2)" dosya.txt
    ```

46. **Geriye dönük iddiaları kullan**
    <sub>(Use lookbehind assertions)</sub>
    ```bash
    grep -P "(?<=desen1)desen2" dosya.txt
    ```

47. **IP adreslerini ara**
    <sub>(Search for IP addresses)</sub>
    ```bash
    grep -E "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" dosya.txt
    ```

48. **E-posta adreslerini ara**
    <sub>(Search for email addresses)</sub>
    ```bash
    grep -E "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b" dosya.txt
    ```

49. **URL'leri ara**
    <sub>(Search for URLs)</sub>
    ```bash
    grep -E "https?://[^\s]+" dosya.txt
    ```

50. **Onaltılık renk kodlarını ara**
    <sub>(Search for hexadecimal color codes)</sub>
    ```bash
    grep -E "#[0-9A-Fa-f]{6}" dosya.txt
    ```

51. **Bir desenin tekrar sayısını say**
    <sub>(Count occurrences of a pattern)</sub>
    ```bash
    grep -o "desen" dosya.txt | wc -l
    ```

52. **Tam kelime sayısına sahip satırları bul**
    <sub>(Find lines with exact word count)</sub>
    ```bash
    grep -E "^(\S+\s+){4}\S+$" dosya.txt
    ```

53. **Belirli uzunluk aralığındaki satırları ara**
    <sub>(Search for lines with specific length range)</sub>
    ```bash
    grep -E "^.{10,20}$" dosya.txt
    ```

54. **Tekrarlanan satırları bul**
    <sub>(Find duplicate lines)</sub>
    ```bash
    grep -n "^.*$" dosya.txt | sort | uniq -d
    ```

55. **Sadece sayı içeren satırları ara**
    <sub>(Search for lines containing only numbers)</sub>
    ```bash
    grep -E "^[0-9]+$" dosya.txt
    ```

56. **Büyük harfli kelimeler içeren satırları bul**
    <sub>(Find lines with uppercase words)</sub>
    ```bash
    grep -E "\b[A-Z]+\b" dosya.txt
    ```

57. **Belirli tarih formatına sahip satırları ara**
    <sub>(Search for lines with specific date format)</sub>
    ```bash
    grep -E "\b\d{4}-\d{2}-\d{2}\b" dosya.txt
    ```

58. **Belirli saat formatına sahip satırları ara**
    <sub>(Find lines with specific time format)</sub>
    ```bash
    grep -E "\b\d{2}:\d{2}:\d{2}\b" dosya.txt
    ```

59. **Belirli dosya uzantılarını içeren satırları ara**
    <sub>(Search for lines containing specific file extensions)</sub>
    ```bash
    grep -E "\.(jpg|png|gif)$" dosya.txt
    ```

60. **Dengeli parantezlere sahip satırları bul**
    <sub>(Find lines with balanced parentheses)</sub>
    ```bash
    grep -P "^[^()]*(\([^()]*\)[^()]*)*$" dosya.txt
    ```

## Karmaşık Grep İşlemleri için Bash Betiği
<sub>(Bash Script for Complex Grep Operations)</sub>

İşte birden fazla grep işlemini birleştiren gelişmiş metin analizi için bir bash betiği:

```bash
#!/bin/bash

# Kullanım bilgisini gösteren fonksiyon
kullanim() {
    echo "Kullanım: $0 <dosya> [seçenekler]"
    echo "Seçenekler:"
    echo "  -d, --desen DESEN       DESEN için arama y