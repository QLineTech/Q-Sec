# ReactJS Bağımlılıklarının Yönetimi

## Mevcut Bağımlılıkları Kontrol Etme

ReactJS projenizin mevcut bağımlılıklarını kontrol etmek için:

1. Terminal'de projenizin kök dizinini açın.
2. Aşağıdaki komutu çalıştırın:

```bash
npm list --depth=0
```

Bu, doğrudan bağımlılıklarınızı ve sürümlerini bir ağaç yapısında gösterecektir.

Daha detaylı bir görünüm için şunu kullanabilirsiniz:

```bash
npm list
```

> **İpucu**: JSON çıktısı için `--json` bayrağını ekleyin: `npm list --json`

## Bağımlılık Ekleme <sub>(Adding Dependencies)</sub>

ReactJS projenize yeni bir bağımlılık eklemek için:

```bash
npm install <paket-adı>
```

Örnek:
```bash
npm install react-router-dom
```

| Bayrak | Açıklama | Örnek |
|--------|----------|-------|
| `--save-prod` | Üretim bağımlılığı olarak ekle (varsayılan) | `npm install --save-prod axios` |
| `--save-dev` | Geliştirme bağımlılığı olarak ekle | `npm install --save-dev jest` |
| `--no-save` | package.json'a eklemeden kur | `npm install --no-save lodash` |

## Bağımlılıkları Kaldırma <sub>(Removing Dependencies)</sub>

ReactJS projenizden bir bağımlılığı kaldırmak için:

```bash
npm uninstall <paket-adı>
```

Örnek:
```bash
npm uninstall moment
```

> **İpucu**: Paketin `package.json`'dan da kaldırıldığından emin olmak için `--save` veya `--save-dev` bayraklarını kullanın.

## Bağımlılıkları Yükseltme <sub>(Upgrading Dependencies)</sub>

Belirli bir bağımlılığı yükseltmek için:

```bash
npm update <paket-adı>
```

Tüm bağımlılıkları en son sürümlerine yükseltmek için:

```bash
npm update
```

Büyük sürüm yükseltmeleri için:

```bash
npm install <paket-adı>@latest
```

## Bağımlılıkları Düşürme <sub>(Downgrading Dependencies)</sub>

Bir bağımlılığı belirli bir sürüme düşürmek için:

```bash
npm install <paket-adı>@<sürüm>
```

Örnek:
```bash
npm install react-router-dom@5.2.0
```

---

### Bağımlılık Ağacını Görselleştirme

Bağımlılık ağacınızın görsel bir temsilini elde etmek için `npm-dependency-tree` paketini kullanabilirsiniz:

1. Global olarak kurun:
   ```bash
   npm install -g npm-dependency-tree
   ```

2. Proje dizininizde çalıştırın:
   ```bash
   npm-dependency-tree
   ```

Bu, bağımlılıklarınızın grafiksel bir temsilini oluşturacaktır.

---

`package.json` dosyanızda değişiklik yaptıktan sonra her zaman `npm install` komutunu çalıştırmayı unutmayın. Bu, `node_modules` dizininizin beyan ettiğiniz bağımlılıklarla senkronize olmasını sağlar.