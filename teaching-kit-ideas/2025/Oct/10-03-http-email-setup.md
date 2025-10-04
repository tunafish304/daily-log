

## ✅ Verified Setup Guide for Students (GitHub + Namecheap + Brevo)

### 🧩 What Each Student Needs
- A GitHub account
- A free `.me` domain from [nc.me](https://nc.me/landing/github)
- A Brevo account ([brevo.com](https://www.brevo.com))

---

### 🔹 Step 1: Claim a Free Domain
1. Go to [https://nc.me/landing/github](https://nc.me/landing/github)
2. Sign in with GitHub
3. Choose a domain like `cs210studentname.me`
4. Namecheap will create an account for you — check your email for login info

---

### 🔹 Step 2: Create Two GitHub Repos
Create two public repositories:

| Repo Name               | Purpose                          |
|-------------------------|----------------------------------|
| `cs210-root-verify`     | Verifies `cs210studentname.me`   |
| `cs210-mail-verify`     | Verifies `mail.cs210studentname.me` |

In each repo:
- Add a simple `index.html` file:
```html
<!DOCTYPE html>
<html>
  <head><title>Verified</title></head>
  <body><h1>This domain is verified</h1></body>
</html>
```

---

### 🔹 Step 3: Enable GitHub Pages
For each repo:
1. Go to **Settings > Pages**
2. Under **Source**, select `main` branch and `/root`
3. GitHub will give you a public URL

---

### 🔹 Step 4: Point Your Domain to GitHub Pages
Log into [Namecheap](https://www.namecheap.com) and:

1. Go to **Domain List > Manage** next to your `.me` domain
2. Click the **Advanced DNS** tab
3. Add two **CNAME records**:

| Host | Value                        | Purpose                      |
|------|------------------------------|------------------------------|
| `@`  | `yourusername.github.io`     | Root domain (`cs210studentname.me`) |
| `mail` | `yourusername.github.io`   | Subdomain (`mail.cs210studentname.me`) |

---

### 🔹 Step 5: Create a Brevo Account
1. Go to [https://www.brevo.com](https://www.brevo.com)
2. Sign up and log in
3. Go to **Settings > Senders & Domains > Domains**
4. Click **Add a Domain**
5. Enter your domain name (e.g., `cs210studentname.me`)
6. Brevo will give you **DNS records** (SPF, DKIM, DMARC)

---

### 🔹 Step 6: Add DNS Records in Namecheap
Back in **Advanced DNS** in Namecheap:

1. Click **Add New Record**
2. Choose **TXT Record**
3. Paste each record from Brevo:
   - SPF
   - DKIM
   - DMARC

Brevo will verify these automatically once they’re live.

---

### 🔹 Step 7: Wait for SSL
GitHub will issue a free SSL certificate once your domain is pointed correctly. This may take a few hours. You’ll know it’s working when your site loads with `https://` and shows a lock icon.

---

## 🧠 Recovery Tips
- If DNS records don’t verify, double-check spelling and spacing
- If GitHub Pages doesn’t show your site, make sure `index.html` is in the root folder and Pages is enabled
- If SSL doesn’t show up, wait a few hours and try again

