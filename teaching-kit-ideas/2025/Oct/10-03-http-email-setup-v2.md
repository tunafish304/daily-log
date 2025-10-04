I hear you — and I appreciate your patience. Let’s make this crystal clear for your students. Here’s a **clean, corrected student guide** that includes the exact steps to claim a free domain, with no misleading instructions.

---

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
2. **Scroll down** to the section titled **“Namecheap offer FAQ”**
3. Click the link that says **“Get started right here.”**
4. You’ll land on a page that says **“Claim your free domain”**
5. Type a domain name ending in `.me` (e.g., `cs210yourname.me`) and click **Search**
6. If the domain is available, you’ll be prompted to **sign in with GitHub**
7. Authorize Namecheap to access your GitHub account
8. Complete the checkout (it’s free) — Namecheap will create an account and email you login info

---

## ✅ Step 2: Create Two GitHub Repositories

Create two public repos on GitHub:

| Repo Name               | Purpose                          |
|-------------------------|----------------------------------|
| `cs210-root-verify`     | Verifies `cs210yourname.me`      |
| `cs210-mail-verify`     | Verifies `mail.cs210yourname.me` |

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

## ✅ Step 3: Enable GitHub Pages

For each repo:
1. Go to **Settings > Pages**
2. Under **Source**, select `main` branch and `/root`
3. GitHub will give you a public URL

---

## ✅ Step 4: Point Your Domain to GitHub Pages

Log into [Namecheap](https://www.namecheap.com) and:

1. Go to **Domain List > Manage**
2. Click the **Advanced DNS** tab
3. Add two **CNAME records**:

| Host | Value                        | Purpose                      |
|------|------------------------------|------------------------------|
| `@`  | `yourusername.github.io`     | Root domain (`cs210yourname.me`) |
| `mail` | `yourusername.github.io`   | Subdomain (`mail.cs210yourname.me`) |

---

## ✅ Step 5: Create a Brevo Account

1. Go to [brevo.com](https://www.brevo.com)
2. Sign up and log in
3. Go to **Settings > Senders & Domains > Domains**
4. Click **Add a Domain**
5. Enter your domain name (e.g., `cs210yourname.me`)
6. Brevo will display **DNS records** (SPF, DKIM, DMARC)

---

## ✅ Step 6: Add DNS Records in Namecheap

Back in **Advanced DNS** in Namecheap:

1. Click **Add New Record**
2. Choose **TXT Record**
3. Paste each record from Brevo:
   - SPF
   - DKIM
   - DMARC

Brevo will verify these automatically once DNS propagation completes.

---

## ✅ Step 7: Get Your Brevo API Key (for HTTP)

1. In Brevo, go to **SMTP & API** (top-right menu or under Settings)
2. Click **API Keys**
3. Click **Create a New API Key**
4. Name it (e.g., `cs210-mailer`)
5. Choose **v3 (recommended)** if prompted
6. Click **Generate**
7. **Copy the key immediately** — it won’t be shown again

Use this key in your Python script to send emails via HTTP.

---

## ✅ Step 8: Send Email with `mailer.py`

Here’s a basic example using the Brevo API:

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

- DNS changes can take time — wait up to 24 hours
- Double-check spelling and spacing in DNS records
- Make sure GitHub Pages is enabled and `index.html` is in the root folder
- If SSL doesn’t show up, wait a few hours — GitHub will issue it automatically

---

Let me know if you’d like this turned into a printable handout or formatted for slides. I’ll make sure it’s classroom-ready.
