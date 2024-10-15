import os
import subprocess

def get_bash_scripts(dizin='scripts'):
    """
    Belirtilen dizindeki tüm .sh dosyalarını listeler.
    
    :param dizin: Aranacak dizin (varsayılan 'scripts')
    :return: .sh dosya adlarının listesi
    """
    sh_dosyalari = []
    for dosya in os.listdir(dizin):
        if dosya.endswith('.sh'):
            sh_dosyalari.append(dosya)
    return sh_dosyalari

def run_bash_script(path):
    """
    Python kullanarak bir shell betiğini çalıştırır.
    
    :param betik_yolu: Shell betiğinin yolu
    :return: Betik çalıştırmanın çıktısı
    """
    result = subprocess.run(['sh', path], capture_output=True, text=True)
    return result.stdout

def run_bash_command(komut):
    """
    Python kullanarak bir bash komutunu çalıştırır.
    
    :param komut: Çalıştırılacak bash komutu
    :return: Komut çalıştırmanın çıktısı
    """
    result = subprocess.run(komut, shell=True, capture_output=True, text=True)
    return result.stdout


while True:
    print("-------------------------------")
    print("------_QTOOL")
    print("-------------------------------")

    scripts = get_bash_scripts()

    for i in range(len(scripts)):
        print(str(i) + "." + scripts[i])
    print("q. cikis")
    
    secilen= input()

    if secilen == "q":
        break
    
    try:
        secilen = int(secilen)
        
        if secilen >= 0 and secilen < len(scripts):
            sonuc = run_bash_script("scripts/" + scripts[secilen])
            print("------------------------")
            print(sonuc)
            print("------------------------")
            input()
        else:
            print("YANLIS SECIM")
            
            
            
            
    except Exception as e:
        print("YANLIS SECENEK")
        print(e)

# result = run_bash_script("scripts/git_yukleme.sh")
# print("komut calisma sonrasi sonuc:")
# print(result)