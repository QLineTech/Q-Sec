Here's an explanation of branches in Git, their usage, commands, and a real-world example in English and Turkish:

### English

# Git Branches

## What are branches?

Branches in Git are lightweight, movable pointers to commits. They allow you to diverge from the main line of development and work on different features or experiments without affecting the main codebase.

## How do developers use branches?

Developers use branches to:
1. Develop features isolated from each other
2. Collaborate with other team members without interfering with each other's work
3. Maintain different versions of a project (e.g., production, development, feature branches)
4. Experiment with new ideas without affecting the stable codebase

## Commonly used commands and parameters

1. Create a new branch:
   ```
   git branch <branch-name>
   ```

2. Switch to a branch:
   ```
   git checkout <branch-name>
   ```

3. Create and switch to a new branch:
   ```
   git checkout -b <branch-name>
   ```

4. List all branches:
   ```
   git branch
   ```

5. Merge a branch into the current branch:
   ```
   git merge <branch-name>
   ```

6. Delete a branch:
   ```
   git branch -d <branch-name>
   ```

## Real usage sample

Let's say you're working on a website and want to add a new feature:

1. Create and switch to a new feature branch:
   ```
   git checkout -b add-contact-form
   ```

2. Make changes and commit them:
   ```
   git add contact.html
   git commit -m "Add contact form"
   ```

3. Switch back to the main branch:
   ```
   git checkout main
   ```

4. Merge the feature branch:
   ```
   git merge add-contact-form
   ```

5. Delete the feature branch after merging:
   ```
   git branch -d add-contact-form
   ```

This workflow allows you to develop the contact form feature separately and then integrate it into the main codebase when it's ready.

### Turkish

# Git Dalları (Branches)
# Git Branches

## Dallar nedir?
## What are branches?

Git'te dallar, commit'lere işaret eden hafif ve taşınabilir göstergelerdir. Ana geliştirme çizgisinden ayrılmanıza ve ana kod tabanını etkilemeden farklı özellikler veya denemeler üzerinde çalışmanıza olanak tanır.

## Geliştiriciler dalları nasıl kullanır?
## How do developers use branches?

Geliştiriciler dalları şu amaçlarla kullanır:
1. Özellikleri birbirinden izole olarak geliştirmek
2. Diğer takım üyelerinin çalışmalarını etkilemeden işbirliği yapmak
3. Bir projenin farklı versiyonlarını tutmak (örn. üretim, geliştirme, özellik dalları)
4. Kararlı kod tabanını etkilemeden yeni fikirler denemek

## Sık kullanılan komutlar ve parametreleri
## Commonly used commands and parameters

1. Yeni bir dal oluşturma:
   ```
   git branch <dal-adı>
   ```

2. Bir dala geçiş yapma:
   ```
   git checkout <dal-adı>
   ```

3. Yeni bir dal oluşturma ve geçiş yapma:
   ```
   git checkout -b <dal-adı>
   ```

4. Tüm dalları listeleme:
   ```
   git branch
   ```

5. Bir dalı mevcut dala birleştirme:
   ```
   git merge <dal-adı>
   ```

6. Bir dalı silme:
   ```
   git branch -d <dal-adı>
   ```

## Gerçek kullanım örneği
## Real usage sample

Diyelim ki bir web sitesi üzerinde çalışıyorsunuz ve yeni bir özellik eklemek istiyorsunuz:

1. Yeni bir özellik dalı oluşturun ve geçiş yapın:
   ```
   git checkout -b iletisim-formu-ekle
   ```

2. Değişiklikleri yapın ve commit edin:
   ```
   git add iletisim.html
   git commit -m "İletişim formu eklendi"
   ```

3. Ana dala geri dönün:
   ```
   git checkout main
   ```

4. Özellik dalını birleştirin:
   ```
   git merge iletisim-formu-ekle
   ```

5. Birleştirmeden sonra özellik dalını silin:
   ```
   git branch -d iletisim-formu-ekle
   ```

Bu iş akışı, iletişim formu özelliğini ayrı olarak geliştirmenize ve hazır olduğunda ana kod tabanına entegre etmenize olanak tanır.