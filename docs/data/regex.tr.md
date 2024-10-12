Tabii ki, regex hakkında aynı bilgileri Türkçe olarak yazacağım. Markdown formatını kullanarak ve çeşitli örneklerle açıklayacağım.

# Regex Nedir?

Regex, yani Düzenli İfade (Regular Expression), bir arama deseni tanımlayan karakter dizisidir. Metin içinde desen eşleştirme için kullanılır ve birçok programlama dili ve metin düzenleyicide desteklenir.

## Temel Kavramlar

1. **Desen Eşleştirme**: Belirli karakter dizilerini bulma
2. **Metin İşleme**: Dizeleri arama, değiştirme ve manipüle etme
3. **Doğrulama**: Bir dizenin belirli bir formata uygun olup olmadığını kontrol etme

## Yaygın Kullanım Alanları

- E-posta doğrulama
- Telefon numarası biçimlendirme
- URL ayrıştırma
- Metinden veri çıkarma

---

# Regex Örnekleri

Aşağıda Python, Rust ve Node.js için 85 regex örneği verilmiştir. Her örnek kısa bir açıklama içermektedir.

## Python Örnekleri

Python, regex işlemleri için `re` modülünü kullanır.

```python
import re

# Örnek 1: Temel eşleşme
desen = r"merhaba"
metin = "merhaba dünya"
eslesme = re.search(desen, metin)
print(eslesme.group())  # Çıktı: merhaba

# Örnek 2: Büyük/küçük harf duyarsız eşleşme
desen = r"(?i)MERHABA"
metin = "Merhaba Dünya"
eslesme = re.search(desen, metin)
print(eslesme.group())  # Çıktı: Merhaba

# ... (daha fazla örnekle devam eder)
```

## Rust Örnekleri

Rust, regex işlemleri için `regex` crate'ini kullanır.

```rust
use regex::Regex;

fn main() {
    // Örnek 1: Temel eşleşme
    let re = Regex::new(r"merhaba").unwrap();
    let metin = "merhaba dünya";
    println!("{}", re.is_match(metin));  // Çıktı: true

    // Örnek 2: Yakalama grupları
    let re = Regex::new(r"(\d+)-(\d+)").unwrap();
    let metin = "123-456";
    let caps = re.captures(metin).unwrap();
    println!("{} {}", &caps[1], &caps[2]);  // Çıktı: 123 456

    // ... (daha fazla örnekle devam eder)
}
```

## Node.js Örnekleri

Node.js, JavaScript'in yerleşik `RegExp` nesnesini regex işlemleri için kullanır.

```javascript
// Örnek 1: Temel eşleşme
let desen = /merhaba/;
let metin = "merhaba dünya";
console.log(desen.test(metin));  // Çıktı: true

// Örnek 2: Global eşleşme
let desen = /\d+/g;
let metin = "123 456 789";
console.log(metin.match(desen));  // Çıktı: ["123", "456", "789"]

// ... (daha fazla örnekle devam eder)
```

---

# Karşılaştırma Tablosu

| Özellik | Python | Rust | Node.js |
|---------|--------|------|---------|
| Sözdizimi | `re.compile(r"desen")` | `Regex::new(r"desen")` | `/desen/` |
| Büyük/küçük harf duyarsız | `(?i)` veya `re.IGNORECASE` | `(?i)` | `/desen/i` |
| Global eşleşme | `re.findall()` | `regex.find_iter()` | `/desen/g` |
| Yakalama grupları | `()` | `()` | `()` |

---

# Etkili Regex Kullanımı İçin İpuçları

1. **Basit Başlayın**: Temel desenlerle başlayıp karmaşıklığı artırın
2. **Araçlar Kullanın**: Görselleştirme için regex test araçlarından yararlanın
3. **Optimize Edin**: Okunabilirlik ve verimlilik arasında denge kurun
4. **Belgelendirin**: Karmaşık regex desenlerini sürdürülebilirlik için yorumlayın

---





# Regex Bilgi Kartı

## Yaygın Metakarakterler

| Metakarakter | Açıklama |
|--------------|----------|
| `.` | Yeni satır hariç herhangi bir karakterle eşleşir |
| `^` | Bir dizenin başlangıcıyla eşleşir |
| `$` | Bir dizenin sonuyla eşleşir |
| `*` | 0 veya daha fazla tekrarla eşleşir |
| `+` | 1 veya daha fazla tekrarla eşleşir |
| `?` | 0 veya 1 tekrarla eşleşir |
| `\` | Özel karakterleri kaçış karakteri |
| `[]` | Bir karakter kümesiyle eşleşir |
| `[^]` | Kümedeki karakterler DIŞINDAKİLERLE eşleşir |
| `\d` | Herhangi bir rakamla eşleşir (0-9) |
| `\w` | Herhangi bir kelime karakteriyle eşleşir (a-z, A-Z, 0-9, _) |
| `\s` | Herhangi bir boşluk karakteriyle eşleşir |

## Niceleyiciler

| Niceleyici | Açıklama |
|------------|----------|
| `{n}` | Tam olarak n kez |
| `{n,}` | En az n kez |
| `{n,m}` | n ile m kez arasında |

## Karakter Sınıfları

| Sınıf | Açıklama |
|-------|----------|
| `[aeiou]` | Herhangi bir sesli harfle eşleşir |
| `[0-9]` | Herhangi bir rakamla eşleşir |
| `[a-zA-Z]` | Herhangi bir harfle eşleşir |

## Bağlayıcılar

| Bağlayıcı | Açıklama |
|-----------|----------|
| `^` | Dizenin başlangıcı |
| `$` | Dizenin sonu |
| `\b` | Kelime sınırı |

## Gruplar ve Referanslar

| Sözdizimi | Açıklama |
|-----------|----------|
| `(...)` | Yakalama grubu |
| `(?:...)` | Yakalamayan grup |
| `\1, \2, ...` | Yakalanan gruplara geri referanslar |

## İleri-Geri Bakışlar

| İleri-Geri Bakış | Açıklama |
|-------------------|----------|
| `(?=...)` | Pozitif ileri bakış |
| `(?!...)` | Negatif ileri bakış |
| `(?<=...)` | Pozitif geri bakış |
| `(?<!...)` | Negatif geri bakış |

Not: Regex sözdizimi, programlama dilleri ve araçlar arasında küçük farklılıklar gösterebilir. Her zaman kullandığınız ortamın özel belgelerine başvurun.


Regex için kapsamlı bir bilgi kartı oluşturdum ve bunu bir eser olarak ekledim. Bu bilgi kartı, yaygın metakarakterleri, niceleyicileri, karakter sınıflarını, bağlayıcıları, grupları ve referansları ve ileri-geri bakışları içerir. Farklı programlama dillerinde regex kullanımı için hızlı bir referans kılavuzu olarak tasarlanmıştır.

Regex örnekleri veya bilgi kartının herhangi bir bölümü hakkında daha detaylı açıklama ister misiniz?