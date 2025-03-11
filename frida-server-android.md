```markdown
Frida’yı bir Android emülatörüne kurmak için, öncelikle ana makinenizde frida-tools’un yüklü olması gerekir. Ardından, emülatör üzerinde frida-server bileşenini kurmanız gerekiyor. Aşağıda bunu gerçekleştirmek için adım adım talimatlar yer alıyor. Bu adımlar, bir Android emülatörünün çalıştığını (örneğin, Android Studio’nun AVD’si aracılığıyla) ve ana makinenizde Android Debug Bridge (ADB) aracının mevcut olduğunu varsayar.

### Ön Koşullar
- **Frida-tools yüklü:** Ana makinenizde frida-tools’u zaten kurmuşsunuzdur (örneğin, `pip install frida-tools` ile).
- **Android emülatörü:** Emülatörünüzün çalıştığından emin olun. İdeal olarak, kök erişimine sahip bir emülatör kullanın (örneğin, Google Play hizmetleri devre dışı bırakılmış Android 9 veya daha eski bir imaj ya da köklü bir özel imaj). Kök erişimi süreci kolaylaştırır, ancak Frida köklü olmayan emülatörlerde de bazı ek adımlarla çalışabilir (burada kısalık adına bu adımlar ele alınmamıştır).
- **ADB:** ADB’nin yüklü ve yapılandırılmış olduğundan emin olun (genellikle Android Studio’nun SDK’sının bir parçasıdır). Terminalde `adb devices` komutunu çalıştırarak emülatörünüzün listelendiğini doğrulayabilirsiniz.

### Android Emülatörüne Frida’yı Kurma Adımları

#### 1. Emülatörünüzün Mimarisini Kontrol Edin
Terminal açın ve emülatörünüze bağlanın:
```
adb shell
```
Emülatörün CPU mimarisini belirlemek için şu komutu çalıştırın:
```
getprop ro.product.cpu.abi
```
Yaygın çıktılar arasında `x86`, `x86_64`, `armeabi-v7a` veya `arm64-v8a` yer alır. Bunu not edin, çünkü eşleşen frida-server ikili dosyasını indirmeniz gerekecek.

#### 2. Doğru Frida-Server İkili Dosyasını İndirin
- GitHub’daki Frida yayınlar sayfasına gidin.
- En son sürüme gidin ve emülatörünüzün mimarisine uygun Android için frida-server ikili dosyasını bulun (örneğin, `x86_64` emülatör için `frida-server-<sürüm>-android-x86_64.xz`).
- `.xz` dosyasını ana makinenize indirin.
- Dosyayı çıkarmak için bir araç kullanın; örneğin Linux/macOS’ta: `xz -d frida-server-<sürüm>-android-<mimari>.xz` veya Windows’ta 7-Zip gibi bir dosya arşivleyici. Bu işlem size `frida-server-<sürüm>-android-<mimari>` adında bir dosya verecektir.

#### 3. Frida-Server’ı Emülatöre Yükleyin
Çıkarılan ikili dosyanın adını kolaylık için daha basit bir şekilde değiştirin, örneğin:
```
mv frida-server-<sürüm>-android-<mimari> frida-server
```
ADB kullanarak ikili dosyayı emülatörde yazılabilir bir dizine (örneğin, `/data/local/tmp`) yükleyin:
```
adb push frida-server /data/local/tmp/
```

#### 4. İzinleri Ayarlayın ve Frida-Server’ı Çalıştırın
Emülatörün kabuğuna bağlanın:
```
adb shell
```
İkili dosyanın yüklendiği dizine gidin:
```
cd /data/local/tmp
```
Dosyayı çalıştırılabilir hale getirin:
```
chmod 755 frida-server
```
Eğer emülatörünüz köklü ise, kök ayrıcalıklarına geçin (isteğe bağlı ama önerilir):
```
adb root
```
Ardından kabuğa tekrar bağlanın:
```
adb shell
```
Frida-server’ı arka planda çalıştırın:
```
./frida-server &
```
Kabuktan çıkın:
```
exit
```

#### 5. Frida’nın Çalıştığını Doğrulayın
Ana makinenizde şu komutu çalıştırarak emülatördeki işlemleri listeleyin:
```
frida-ps -U
```
`-U` bayrağı, Frida’ya bir USB cihazına veya emülatöre bağlanmasını söyler. Eğer her şey doğru ayarlanmışsa, emülatörde çalışan işlemlerin bir listesini görmelisiniz (örneğin, PID, İsim).
Hata alırsanız, frida-server’ın emülatörde çalıştığından ve ana makinedeki frida-tools sürümünün frida-server sürümüyle eşleştiğinden emin olun (`frida --version` ile kontrol edin ve gerekirse eşleşen server sürümünü indirin).

### Sorun Giderme İpuçları
- **Emülatör algılanmıyor:** `adb devices` komutunu çalıştırarak emülatörün bağlı olduğunu doğrulayın. Gerekirse emülatörü veya ADB’yi yeniden başlatın (`adb kill-server && adb start-server`).
- **İzin reddedildi:** Emülatörün köklü olduğundan emin olun veya dosyayı `/sdcard/` gibi başka bir dizine yüklemeyi deneyin ve izinleri buna göre ayarlayın.
- **Sürüm uyuşmazlığı:** Frida-server sürümü, frida-tools sürümüyle eşleşmelidir. Her ikisini de `frida --version` ile kontrol edin ve gerekirse yeniden indirin.
- **Frida-server çöküyor:** Eski Android sürümleri veya uyumsuz mimariler çökmelere neden olabilir. En iyi sonuçlar için Android 9 emülatörü ve eşleşen bir mimari kullanın.

### İsteğe Bağlı: Süreci Otomatikleştirin
Emülatör her yeniden başladığında frida-server’ı manuel olarak yeniden başlatmamak için şu tek satırlık komutu kullanabilirsiniz:
```
adb push frida-server /data/local/tmp/ && adb shell "chmod 755 /data/local/tmp/frida-server && /data/local/tmp/frida-server &"
```

Frida-server emülatörde çalışmaya başladıktan sonra, ana makinenizden frida-tools’u (örneğin, `frida`, `frida-trace`, `frida-ps`) kullanarak emülatördeki uygulamalarla etkileşime geçebilirsiniz. Örneğin, bir uygulamayı kancalamak için:
```
frida -U -n <uygulama_paket_adı>
```
```
