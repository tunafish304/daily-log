# Chapter 10 adapted to http email

## Introduction to Flask-Mail (along with configuration for http email)


The flask-mail extension:
```bash
(venv) $ pip install flask-mail
```
The password reset links will have a secure token in them. To generate these tokens, I'm going to use JSON Web Tokens, which also have a popular Python package:
```bash
(venv) $ pip install pyjwt
```
Like most Flask extensions, you need to create an instance right after the Flask application is created. In this case this is an object of class Mail, and we will configure for smtp mail alongside configuring for http mail. For \_\_init\_\_.py we don't require any http mail configuration:
```python
# app/__init__.py
# ...
from flask_mail import Mail

app = Flask(__name__)
# ...
mail = Mail(app)
```
Here are the environment variables in ~projects/microblog/.env for smtp email as well as http email:

```python
# --- SMTP Settings ---
MAIL_SERVER=smtp.example.com
MAIL_PORT=587
MAIL_USE_TLS=True
MAIL_USERNAME=your_email@example.com
MAIL_PASSWORD=your_password

# --- Email Backend Switch ---
EMAIL_BACKEND=http  # or 'smtp'

#Brevo sender
ADMIN_EMAIL='noreply@cs210microblog.me'

# --- Database ---
DB_USER=your_db_user
DB_PASSWORD=your_db_password
DB_HOST=your_db_host
DB_NAME=your_db_name

#Brevo set up
BREVO_API_KEY='your Brevo API key'
PYTHONWARNINGS=ignore::SyntaxWarning
```
The environment variables can be accessed from ~projects/microblog/config.py:
```python
import os
basedir = os.path.abspath(os.path.dirname(__file__))


class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'you-will-never-guess'
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL') or \
        'sqlite:///' + os.path.join(basedir, 'app.db')

    #smtp variables
    MAIL_SERVER = os.environ.get('MAIL_SERVER')
    MAIL_PORT = int(os.environ.get('MAIL_PORT') or 25)
    MAIL_USE_TLS = os.environ.get('MAIL_USE_TLS') is not None
    MAIL_USERNAME = os.environ.get('MAIL_USERNAME')
    MAIL_PASSWORD = os.environ.get('MAIL_PASSWORD')
    #ADMINS = ['your-email@example.com']

    #ADMINS and other variables for for http
    ADMINS = [os.environ.get("ADMIN_EMAIL")]
    SERVER_NAME = 'localhost:5000'
    PREFERRED_URL_SCHEME = 'http'

    POSTS_PER_PAGE = 3
```
## Flask-Mail Usage
```bash
# this is an example of smtp email which doesn't apply for http email

>>> from flask_mail import Message
>>> from app import mail
>>> msg = Message('test subject', sender=app.config['ADMINS'][0],
... recipients=['your-email@example.com'])
>>> msg.body = 'text body'
>>> msg.html = '<h1>HTML body</h1>'
>>> mail.send(msg)
```
## A Simple Email Framework

Helper functions that send smtp email and http email:
```python
# app/email.py Email sending wrapper for smtp email
from flask_mail import Message
from app import mail

def send_email(subject, sender, recipients, text_body, html_body):
    msg = Message(subject, sender=sender, recipients=recipients)
    msg.body = text_body
    msg.html = html_body
    mail.send(msg)

```
```python
# app/mailer.py for http email

import threading
import requests
import os
from app import app

# load and sanitize API key
BREVO_API_KEY = os.getenv("BREVO_API_KEY")
BREVO_API_KEY = BREVO_API_KEY.strip() if BREVO_API_KEY else None
if __name__ == "main":
	print(f"[DEBUG] BREVO_API_KEY 0805: {BREVO_API_KEY}")

BREVO_API_URL = "https://api.brevo.com/v3/smtp/email"


def send_email(subject, sender, recipients, text_body, html_body):
	"""Launch email send in a background thread to avoid blocking the main app."""
	print("are we in send_email?")
	thread = threading.Thread(
		target=send_async_email,
		args=(subject, sender, recipients, text_body, html_body),
	)
	print(f"[DEBUG] starting thread: {BREVO_API_KEY}")
	thread.start()


def build_payload(subject, sender, recipients, text_body, html_body):
	"""Construct the JSON payload for Brevo API."""
	return {
		"sender": {"name": sender.split("@")[0], "email": sender},
		"to": [{"email": r} for r in recipients],
		"subject": subject,
		"htmlContent": html_body,
		"textContent": text_body,
	}


def send_async_email(subject, sender, recipients, text_body, html_body):
	print("[Email Thread] Started send_async_email", flush=True)

	if not BREVO_API_KEY:
		print("[Email Thread] BREVO_API_KEY is missing.")
		raise RuntimeError("BREVO_API_KEY environment variable not set")

	headers = {
		"accept": "application/json",
		"api-key": BREVO_API_KEY,
		"content-type": "application/json",
	}

	payload = build_payload(subject, sender, recipients, text_body, html_body)
	print("entering try statement")

	try:
		response = requests.post(BREVO_API_URL, headers=headers, json=payload)
		print(f"[Email Thread] Status: {response.status_code}")

		if response.status_code >= 400:
			print(
				f"[Email Thread] Warning: Received error status {response.status_code}"
			)

		try:
			print(f"[Email Thread] Response: {response.json()}")
		except ValueError:
			print(f"[Email Thread] Non-JSON response: {response.text}")

	except Exception as e:
		print(f"[Email Thread] Error sending email: {e}")
  
from flask import render_template

def send_password_reset_email(user):
    token = user.get_reset_password_token()
    print("are we in send_password_reset_email?")
    send_email(
        subject="[Microblog] Reset Your Password",
        sender=app.config["ADMINS"][0],
        recipients=[user.email],
        text_body=render_template("email/reset_password.txt", user=user, token=token),
        html_body=render_template("email/reset_password.html", user=user, token=token),
    )
```
## Requesting a Password Reset

Add a link to the login page:
```html
# app/templates/login.html: Password reset link in login form
<p>
    Forgot Your Password?
    <a href="{{ url_for('reset_password_request') }}">Click to Reset It</a>
</p>
```
When the user clicks the link, a new web form will appear that requests the user's email address as a way to initiate the password reset process. Here is the form class:
```python
# app/forms.py: Reset password request form.

class ResetPasswordRequestForm(FlaskForm):
    email = StringField('Email', validators=[DataRequired(), Email()])
    submit = SubmitField('Request Password Reset')
```
And here is the corresponding HTML template:
```html
# app/templates/reset_password_request.html: Reset password request template.

{% extends "base.html" %}

{% block content %}
    <h1>Reset Password</h1>
    <form action="" method="post">
        {{ form.hidden_tag() }}
        <p>
            {{ form.email.label }}<br>
            {{ form.email(size=64) }}<br>
            {% for error in form.email.errors %}
            <span style="color: red;">[{{ error }}]</span>
            {% endfor %}
        </p>
        <p>{{ form.submit() }}</p>
    </form>
{% endblock %}
```
We also need a view function to handle this form:
```python
# app/routes.py: Reset password request view function.

from app.forms import ResetPasswordRequestForm
#from app.email import send_password_reset_email
from app.mailer import send_password_reset_email

@app.route('/reset_password_request', methods=['GET', 'POST'])
def reset_password_request():
    if current_user.is_authenticated:
        return redirect(url_for('index'))
    form = ResetPasswordRequestForm()
    if form.validate_on_submit():
        user = db.session.scalar(
            sa.select(User).where(User.email == form.email.data))
        if user:
            send_password_reset_email(user)
        flash('Check your email for the instructions to reset your password')
        return redirect(url_for('login'))
    return render_template('reset_password_request.html',
                           title='Reset Password', form=form)
```
## Password Reset Tokens

A token will be added to the password request link. HEre is a shell example to illustrate how tokens work:
```bash
>>> import jwt
>>> token = jwt.encode({'a': 'b'}, 'my-secret', algorithm='HS256')
>>> token
'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhIjoiYiJ9.dvOo58OBDHiuSHD4uW88nfJik_sfUHq1mDi4G0'
>>> jwt.decode(token, 'my-secret', algorithms=['HS256'])
{'a': 'b'}
```
Since these tokens belong to users, I'm going to write the token generation and verification functions as methods in the User model:
```python
# app/models.py: Reset password token methods.

from time import time
import jwt
from app import app

class User(UserMixin, db.Model):
    # ...

    def get_reset_password_token(self, expires_in=600):
        return jwt.encode(
            {'reset_password': self.id, 'exp': time() + expires_in},
            app.config['SECRET_KEY'], algorithm='HS256')

    @staticmethod
    def verify_reset_password_token(token):
        try:
            id = jwt.decode(token, app.config['SECRET_KEY'],
                            algorithms=['HS256'])['reset_password']
        except:
            return
        return db.session.get(User, id)
```


## Sending a Password Reset Email

We will illutrate the send_password_reset_email() function for email.py (for smtp). The complete http send_password_reset_email() function was illustrated above (see **A Simple Email Framework**):

```python
# app/email.py: Send password reset email function for smtp.

from flask import render_template
from app import app

# ...

def send_password_reset_email(user):
    token = user.get_reset_password_token()
    send_email('[Microblog] Reset Your Password',
               sender=app.config['ADMINS'][0],
               recipients=[user.email],
               text_body=render_template('email/reset_password.txt',
                                         user=user, token=token),
               html_body=render_template('email/reset_password.html',
                                         user=user, token=token))
```
To distinguish email templates from regular HTML templates, let's create an email subdirectory inside templates:
```bash
(venv) $ mkdir app/templates/email
```
Here is the text template for the reset password email:
```html
# app/templates/email/reset_password.txt: Text for password reset email.

Dear {{ user.username }},

To reset your password click on the following link:

{{ url_for('reset_password', token=token, _external=True) }}

If you have not requested a password reset simply ignore this message.

Sincerely,

The Microblog Team
```
And here is the nicer HTML version of the same email:
```html
app/templates/email/reset_password.html: HTML for password reset email.

<!doctype html>
<html>
    <body>
        <p>Dear {{ user.username }},</p>
        <p>
            To reset your password
            <a href="{{ url_for('reset_password', token=token, _external=True) }}">
                click here
            </a>.
        </p>
        <p>Alternatively, you can paste the following link in your browser's address bar:</p>
        <p>{{ url_for('reset_password', token=token, _external=True) }}</p>
        <p>If you have not requested a password reset simply ignore this message.</p>
        <p>Sincerely,</p>
        <p>The Microblog Team</p>
    </body>
</html>
```
## Resetting a User Password

When the user clicks on the email link, a second route associated with this feature is triggered. Here is the password request view function:
```python
# app/routes.py: Password reset view function.

from app.forms import ResetPasswordForm

@app.route('/reset_password/<token>', methods=['GET', 'POST'])
def reset_password(token):
    if current_user.is_authenticated:
        return redirect(url_for('index'))
    user = User.verify_reset_password_token(token)
    if not user:
        return redirect(url_for('index'))
    form = ResetPasswordForm()
    if form.validate_on_submit():
        user.set_password(form.password.data)
        db.session.commit()
        flash('Your password has been reset.')
        return redirect(url_for('login'))
    return render_template('reset_password.html', form=form)
```
Here is the ResetPasswordForm class:
```python
app/forms.py: Password reset form.

class ResetPasswordForm(FlaskForm):
    password = PasswordField('Password', validators=[DataRequired()])
    password2 = PasswordField(
        'Repeat Password', validators=[DataRequired(), EqualTo('password')])
    submit = SubmitField('Request Password Reset')
```
And here is the corresponding HTML template:
```html
app/templates/reset_password.html: Password reset form template.

{% extends "base.html" %}

{% block content %}
    <h1>Reset Your Password</h1>
    <form action="" method="post">
        {{ form.hidden_tag() }}
        <p>
            {{ form.password.label }}<br>
            {{ form.password(size=32) }}<br>
            {% for error in form.password.errors %}
            <span style="color: red;">[{{ error }}]</span>
            {% endfor %}
        </p>
        <p>
            {{ form.password2.label }}<br>
            {{ form.password2(size=32) }}<br>
            {% for error in form.password2.errors %}
            <span style="color: red;">[{{ error }}]</span>
            {% endfor %}
        </p>
        <p>{{ form.submit() }}</p>
    </form>
{% endblock %}
```
## Asynchronous Emails

Python has support for running asynchronous tasks, actually in more than one way. The threading and multiprocessing modules can both do this. Starting a background thread for email being sent is much less resource intensive than starting a new process, so I'm going to go with that approach.

Here is the asynchronous code for email.py which is for smtp email. For http email (mailer.py) see mailer.py in **A Simple Email Framework**: 
```python
# app/email.py: Send emails asynchronously.

from threading import Thread
# ...

def send_async_email(app, msg):
    with app.app_context():
        mail.send(msg)


def send_email(subject, sender, recipients, text_body, html_body):
    msg = Message(subject, sender=sender, recipients=recipients)
    msg.body = text_body
    msg.html = html_body
    Thread(target=send_async_email, args=(app, msg)).start()
```
The send_async_email function now runs in a background thread, invoked via the Thread class in the last line of send_email(). With this change, the sending of the email will run in the thread, and when the process completes the thread will end and clean itself up. If you have configured a real email server, you will definitely notice a speed improvement when you press the submit button on the password reset request form.


