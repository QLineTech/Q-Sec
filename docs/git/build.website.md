Here's a concise guide on how to create a GitHub-hosted website:

1. Create a GitHub account
   - Sign up at github.com if you haven't already

2. Create a new repository
   - Name it `<username>.github.io`, replacing `<username>` with your GitHub username

3. Clone the repository locally
   ```
   git clone https://github.com/<username>/<username>.github.io.git
   ```

4. Create an index.html file
   ```html
   <!DOCTYPE html>
   <html>
   <body>
     <h1>Hello World</h1>
     <p>I'm hosted with GitHub Pages.</p>
   </body>
   </html>
   ```

5. Commit and push your changes
   ```
   git add .
   git commit -m "Initial commit"
   git push -u origin main
   ```

6. Enable GitHub Pages
   - Go to your repository settings
   - Scroll to "GitHub Pages" section
   - Select "main" as the source branch

7. Visit your site
   - Your site will be live at `https://<username>.github.io`

Would you like me to elaborate on any of these steps or provide more information about customizing your GitHub Pages site?