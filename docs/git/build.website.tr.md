GitHub üzerinde bir web sitesi oluşturmak için kısa bir rehber:

1. GitHub hesabı oluşturun
   - Henüz yapmadıysanız github.com'da kaydolun

2. Yeni bir depo (repository) oluşturun
   - Adını `<kullanıcıadı>.github.io` olarak belirleyin, `<kullanıcıadı>` yerine GitHub kullanıcı adınızı yazın

3. Depoyu yerel bilgisayarınıza klonlayın
   ```
   git clone https://github.com/<kullanıcıadı>/<kullanıcıadı>.github.io.git
   ```

4. Bir index.html dosyası oluşturun
   ```html
   <!DOCTYPE html>
   <html>
   <body>
     <h1>Merhaba Dünya</h1>
     <p>GitHub Pages ile barındırılıyorum.</p>
   </body>
   </html>
   ```

5. Değişikliklerinizi commit edin ve push'layın
   ```
   git add .
   git commit -m "İlk commit"
   git push -u origin main
   ```

6. GitHub Pages'i etkinleştirin
   - Depo ayarlarınıza gidin
   - "GitHub Pages" bölümüne kaydırın
   - Kaynak dal olarak "main"i seçin

7. Sitenizi ziyaret edin
   - Siteniz `https://<kullanıcıadı>.github.io` adresinde yayında olacak
