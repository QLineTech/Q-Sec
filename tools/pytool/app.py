import os
import subprocess
import json
import logging
import traceback
import shlex

scripts=[]
# python_scripts=[]

def get_scripts_list(dir='scripts'):
    """
    Belirtilen dizindeki tüm .sh dosyalarını listeler.
    
    :param dizin: Aranacak dizin (varsayılan 'scripts')
    :return: .sh dosya adlarının listesi
    """
    
    for file in os.listdir(dir) or file.endswith('.py'):
        if file.endswith('.sh'):
            scripts.append(file)       

def load_scripts():
    global scripts
    with open('scripts.json', 'r') as f:
        scripts = json.load(f)

def run_sh_script(script, *args):
    """
    Python kullanarak bir shell betiğini çalıştırır.
    
    :param betik_yolu: Shell betiğinin yolu
    :return: Betik çalıştırmanın çıktısı
    """
    result = subprocess.run(['sh', "scripts/" + script] + list(args), capture_output=True, text=True)
    return result.stdout

def run_sh_script2(script, *args):
    """
    Python kullanarak bir shell betiğini çalıştırır ve çıktıyı canlı olarak gösterir.
    
    :param script: Shell betiğinin adı
    :param args: Betik için opsiyonel argümanlar
    :return: Betik çalıştırmanın tam çıktısı
    """
    full_command = ['bash', f"scripts/{script}"] + list(args)
    process = subprocess.Popen(
        full_command,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        bufsize=1,
        universal_newlines=True
    )
    
    output = []
    for line in process.stdout:
        print(line, end='')  # Canlı çıktı
        output.append(line)  # Çıktıyı sakla
    
    process.wait()
    return ''.join(output)

def run_command(command):
    """
    Python kullanarak bir bash komutunu çalıştırır.
    
    :param komut: Çalıştırılacak bash komutu
    :return: Komut çalıştırmanın çıktısı
    """
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    return result.stdout
    
    
    
# ANA KOD BURADA BASLAMAKTA

logger = logging.getLogger(__name__)
logging.basicConfig(filename='logs.log', encoding='utf-8', level=logging.DEBUG)

# logger.debug('This message should go to the log file')
# logger.info('So should this')
# logger.warning('And this, too')
# logger.error('And non-ASCII stuff, too, like Øresund and Malmö')


load_scripts()

while True:
    
    os.system('cls' if os.name == 'nt' else 'clear')
    print("------ PyTool -----")

    print(f"--- Categories: {len(scripts)}")
    
    i=0
    for category in scripts:
        print(f"{i}. {category}")
        i+=1
        
    print("q. quit")
    
    user_selection = input()
    
    if user_selection == "q":
        break
    else:
        try:
            user_input = int(user_selection)
            if user_input < 0 or user_input > i:
                logger.warning(f"[*] Wrong Choice....")
                input()
                continue
            
            # Dogru Secenek
            print("---------------------")
            i = 0
            category = ""
            for script in scripts[list(scripts.keys())[user_input]]:
                print(f"{i}. {script['title']}")
                i += 1
            
            user_script = input()
            user_script = int(user_script)
            if user_script < 0 or user_script > i:
                # logger.warning(f"[*] Wrong Choice....")
                print("WRONG CHOICE----")
                input()
                continue
            
            category = list(scripts.keys())[user_input]

            
            print("-----------------")
            print(f"-------{category}")
            print("-----------------")
            params = []
            if len(scripts[category][user_script]["parameters"]) > 0:
                for param in range(len(scripts[category][user_script]["parameters"])):
                   print(f"Enter Param [{scripts[category][user_script]["parameters"][param]["title"]}]") 
                   temp = input()
                   params.append(temp)
                   
            print("Running Script")
            output = run_sh_script2(scripts[category][user_script]["script"], *params)
            print("------------------------")
            print(output)
            input()
        except Exception as e:
            # logger.error('[*] Wrong Choice...')
            logger.error(f"[*] Error in {__file__} at line {traceback.extract_tb(e.__traceback__)[-1].lineno}: {e}")
            input()