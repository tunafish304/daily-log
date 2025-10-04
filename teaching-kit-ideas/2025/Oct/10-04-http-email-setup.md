
# 🧑‍🎓 CS210 Student Guide: Verified Email Setup with GitHub, Namecheap, and Brevo

## 🧩 What You’ll Need
- A GitHub account  
- A free `.me` domain via GitHub Student Developer Pack  
- A Namecheap account (created during domain claim)  
- A Brevo account ([brevo.com](https://www.brevo.com))  
- Basic Python skills to use `mailer.py`

---

## ✅ Step 1: Claim Your Free `.me` Domain

1. Go to [https://nc.me/landing/github](https://nc.me/landing/github)  
2. Scroll to **“Namecheap offer FAQ”**  
3. Click **“Get started right here.”**  
4. Search for a domain ending in `.me` (e.g., `cs210yourname.me`)  
5. Sign in with GitHub and authorize Namecheap  
6. Complete the free checkout — Namecheap will email your login info

---

## ✅ Step 2: Create Two GitHub Repositories

| Repo Name           | Purpose                          |
|---------------------|----------------------------------|
| `cs210-root-verify` | Verifies `cs210yourname.me`      |
| `cs210-mail-verify` | Verifies `mail.cs210yourname.me` |

In each repo, add a simple `index.html`:

```html
<!DOCTYPE html>
<html>
  <head><title>Verified</title></head>
  <body><h1>This domain is verified</h1></body>
</html>
```

---

## ✅ Step 3: Enable GitHub Pages

For each repo:
1. Go to **Settings > Pages**
2. Under **Source**, select `main` branch and `/root`
3. GitHub will generate a public URL

---

## ✅ Step 4: Point Your Domain to GitHub Pages

In **Namecheap > Domain List > Manage > Advanced DNS**, add these records:

| Type   | Host   | Value                        | TTL       | Purpose                          |
|--------|--------|------------------------------|-----------|----------------------------------|
| CNAME  | `@`    | `yourusername.github.io`     | Automatic | Root domain (`cs210yourname.me`) |
| CNAME  | `mail` | `yourusername.github.io`     | Automatic | Subdomain (`mail.cs210yourname.me`) |

**Replace `yourusername` with your actual GitHub username.**  
Do not include `https://` or trailing slashes.

---

## ✅ Step 5: Create a Brevo Account and Add Your Domain

1. Go to [brevo.com](https://www.brevo.com) and sign up  
2. Go to **Settings > Senders & Domains > Domains**  
3. Click **Add a Domain**  
4. Enter your full domain (e.g., `cs210yourname.me`)  
5. Brevo will generate DNS records for verification

---

## ✅ Step 6: Add Brevo DNS Records in Namecheap

In **Advanced DNS**, add the following records exactly as shown:

| Type   | Host                  | Value                                              | TTL     | Purpose                        |
|--------|-----------------------|----------------------------------------------------|---------|--------------------------------|
| TXT    | `@`                   | `brevo-code:4e2b86039e6ddd1892eb0fd3a660d8ce`       | Automatic | Brevo domain verification      |
| CNAME  | `brevo1._domainkey`   | `b1.cs210microblog-me.dkim.brevo.com.`             | 30 min   | DKIM record 1                  |
| CNAME  | `brevo2._domainkey`   | `b2.cs210microblog-me.dkim.brevo.com.`             | 30 min   | DKIM record 2                  |
| TXT    | `_dmarc`              | `v=DMARC1; p=none; rua=mailto:rua@dmarc.brevo.com` | Automatic | DMARC policy                   |

**Tips:**
- Host field must match exactly (e.g., `_dmarc`, not `@_dmarc`)
- Value field must be pasted without extra spaces
- TTL can be left as “Automatic” or set to “30 min” for consistency

---

## ✅ Step 7: Verify Your Domain in Brevo

After adding the records:
1. Return to Brevo’s **Domains** section  
2. Click **Verify** next to your domain  
3. Wait for DNS propagation (usually under 1 hour)

---

## ✅ Step 8: Get Your Brevo API Key

1. Go to **SMTP & API > API Keys**  
2. Click **Create a New API Key**  
3. Name it (e.g., `cs210-mailer`)  
4. Choose **v3 (recommended)**  
5. Click **Generate** and **copy the key immediately**

---

## ✅ Step 9: Send Email with `mailer.py`

Here’s a basic Python script using Brevo’s HTTP API:

```python
import requests

headers = {
    "api-key": "your_api_key_here",
    "Content-Type": "application/json"
}

data = {
    "sender": {"name": "CS210", "email": "your_verified@cs210yourname.me"},
    "to": [{"email": "student@example.com"}],
    "subject": "Welcome to CS210",
    "htmlContent": "<h1>Hello from CS210!</h1>"
}

response = requests.post("https://api.brevo.com/v3/smtp/email", headers=headers, json=data)
print(response.status_code, response.text)
```

---

## 🧠 Troubleshooting Tips

- DNS changes can take up to 24 hours  
- Use [whatsmydns.net](https://www.whatsmydns.net) to check TXT and CNAME propagation  
- Double-check spelling and spacing in DNS records  
- GitHub Pages may take a few minutes to issue SSL  
- Brevo won’t verify until all records are correct and visible

