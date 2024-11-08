from bs4 import BeautifulSoup
import requests


print("hello, web.py here.")


links = [
    "https://istinye.edu.tr",
    "https://ku.edu.tr",
    "https://istinye.blackboard.com",
    "https://istanbul.com.tr"
]

def download_url(url):
    """
    Verilen URL adresindeki web sayfasının kaynak kodunu indirir.

    Args:
        url (str): İndirilecek sayfanın URL adresi.

    Returns:
        str: Sayfanın kaynak kodu.
    """

    try:
        response = requests.get(url)
        response.raise_for_status()  # Hata durumunda istisna fırlatır
        soup = BeautifulSoup(response.text, 'html.parser')
        return soup.prettify()
    except requests.exceptions.RequestException as e:
        print(f"Hata: {e}")
        return None

def download_file(url, save_path):
    """
    Verilen URL adresindeki içeriği belirtilen klasöre kaydeder.

    Args:
        url (str): İndirilecek içeriğin URL adresi.
        save_path (str): İçeriğin kaydedileceği dosya yolu.

    Returns:
        bool: İşlem başarılı olursa True, aksi halde False.
    """

    try:
        response = requests.get(url)
        response.raise_for_status()

        with open(save_path, 'wb') as f:
            f.write(response.content)

        return True
    except requests.exceptions.RequestException as e:
        print(f"İndirme sırasında hata oluştu: {e}")
        return False


def analyze_page(url):
    """
    Verilen URL adresindeki web sayfasını analiz eder ve istenen bilgileri döndürür.

    Args:
        url (str): İndirilecek sayfanın URL adresi.

    Returns:
        dict: Analiz sonuçlarını içeren bir sözlük.
    """

    try:
        response = requests.get(url)
        response.raise_for_status()
        soup = BeautifulSoup(response.text, 'html.parser')

        print("extracting scripts")
        # JavaScript scriptleri
        scripts = soup.find_all('script')
        script_src = [script.get('src') for script in scripts if script.get('src')]

        print("extracting css")
        # CSS dosyaları
        stylesheets = soup.find_all('link', rel='stylesheet')
        stylesheet_href = [stylesheet.get('href') for stylesheet in stylesheets]

        print("extracting images")
        # Görseller
        images = soup.find_all('img')
        image_src = [image.get('src') for image in images]


        # Sayfa başlığı
        title = soup.title.string if soup.title else None

        print("extracting links")
        # Tüm linkler
        links = soup.find_all('a')
        link_href = [link.get('href') for link in links]

        print("extracting inputs")
        # Tüm giriş alanları (inputlar)
        inputs = soup.find_all('input')

        return {
            'scripts': script_src,
            'stylesheets': stylesheet_href,
            'images': image_src,
            'title': title,
            'links': link_href,
            'inputs': inputs
        }

    except requests.exceptions.RequestException as e:
        print(f"Hata: {e}")
        return None
    
# Örnek kullanım:
# url = "https://ku.edu.tr"
url = "https://thehackernews.com/"

# kaynak_kodu = download_url(url)
# if kaynak_kodu:
#     print(kaynak_kodu)
# else:
#     print("Kaynak kodu indirilemedi.")


analizler = analyze_page(url)

if analizler:
    # 'scripts': script_src,
    # 'stylesheets': stylesheet_href,
    # 'images': image_src,
    # 'title': title,
    # 'links': link_href,
    # 'inputs': inputs
    # for script in analizler["scripts"]:
    #     print(script)
    print("script sayisi: " + str(len(analizler["scripts"])))
    print("gorsel sayisi: " + str(len(analizler["images"])))
    print("css sayisi: " + str(len(analizler["stylesheets"])))
    print("link sayisi: " + str(len(analizler["links"])))
    print("giris sayisi: " + str(len(analizler["inputs"])))

    # https://ali.com/zehra.jpg
    # [ "https:", "", "ali.com", "zehra.jpg"]
    ad = 1
    for image in analizler["images"]:
        print("indiriliyor:")
        # print(image)
        if image.startswith("http"):
            # bu full adres, direk indir
            temp = image.split("/")
            download_file(image, temp[len(temp) - 1])
        elif image.startswith("data:"):
            # gorsel verisi
            print("kaydet")
        else:
            temp = image.split("/")
            download_file(url + image, temp[len(temp) - 1])
        print("indirme bitti")   
        ad = ad + 1
    # print(analizler)
else:
    print("Analiz gerceklesemedi")
