# Flask Mega-Tutorial Midterm (Student Version — No Answers)

## Multiple Choice (15 questions)  
Choose the best answer for each question.

1. What command initializes a new Flask application?  
   - A. `flask create-app`  
   - B. `flask init`  
   - C. No command is needed; just create an app instance  
   - D. `flask run`  

2. Which file typically contains the Flask app instance in the microblog tutorial?  
   - A. `init.py`  
   - B. `app.py`  
   - C. `config.py`  
   - D. `run.py`  

3. What does the `@app.route` decorator do?  
   - A. Registers a URL route  
   - B. Creates a form  
   - C. Initializes the app  
   - D. Defines a database model  

4. Which extension is used for form handling in Flask?  
   - A. Flask-Migrate  
   - B. Flask-Login  
   - C. Flask-Mail  
   - D. Flask-WTF  

5. What is the purpose of CSRF protection in forms?  
   - A. To prevent cross-site request forgery  
   - B. To validate user input  
   - C. To encrypt form data  
   - D. To prevent SQL injection  

6. What does `url_for('login')` return?  
   - A. The login form  
   - B. The login route URL  
   - C. The login template  
   - D. The login user object  

7. Which method checks if a user is authenticated?  
   - A. `user.is_logged_in()`  
   - B. `current_user.authenticated()`  
   - C. `current_user.is_authenticated`  
   - D. `login_manager.check()`  

8. What does `flash()` do in Flask?  
   - A. Sends email  
   - B. Displays messages to the user  
   - C. Logs errors  
   - D. Redirects to another page  

9. What is the purpose of `@login_required`?  
   - A. Validates form input  
   - B. Restricts access to authenticated users  
   - C. Sends login emails  
   - D. Creates a login form  

10. Which command initializes a migration repository?  
	- A. `flask db init`  
	- B. `flask migrate start`  
	- C. `flask db create`  
	- D. `flask init-db`  

11. What does `current_user` represent in Flask-Login?  
	- A. The user currently logged in  
	- B. The user being registered  
	- C. The admin user  
	- D. The anonymous user  

12. What does `form.validate_on_submit()` check?  
	- A. That the form was submitted and is valid  
	- B. That the form is complete  
	- C. That the form is secure  
	- D. That the form is rendered  

13. What does `db.session.commit()` do?  
	- A. Cancels the transaction  
	- B. Saves changes to the database  
	- C. Starts a new session  
	- D. Rolls back the session  

14. What does `lazy='dynamic'` do in a relationship?  
	- A. Loads related objects immediately  
	- B. Loads related objects only when accessed  
	- C. Allows query filtering on the relationship  
	- D. Disables the relationship  

15. What does `get_or_404()` return?  
	- A. A list of objects  
	- B. A 404 error  
	- C. An object or a 404 error  
	- D. A redirect  

---

## Short Answer (10 questions)  
Answer in 1–3 sentences.

16. What is the role of `init.py` in a Flask app?  
17. Why is CSRF protection important?  
18. How does Flask-Migrate help manage database changes?  
19. What does `current_user` represent?  
20. How does pagination improve user experience?  
21. What does `@app.before_request` do?  
22. What does `form.hidden_tag()` do?  
23. What does `db.session.commit()` do?  
24. Why use `lazy='dynamic'` in relationships?  
25. What does the `follow()` method do in the User model?

---

## Match the Concept (5 questions)  
Match each item in Column A with the correct item in Column B.

26. Match each function to its role:  
Column A | Column B  
---------|----------  
A. `render_template()` | 1. Renders HTML  
B. `redirect()`        | 2. Sends user to another route  
C. `url_for()`         | 3. Generates route URL  
D. `flash()`           | 4. Displays messages  

---

## Fill in the Blank (10 questions)  
Complete each sentence with the correct term.

27. To define a relationship in SQLAlchemy, use `db.__________()`.  
28. The `flash()` function is used to display __________ to the user.  
29. The `form.validate_on_submit()` method returns `True` only if the request method is __________ and the form is valid.  
30. The `url_for()` function generates a URL for a given __________.  
31. The `render_template()` function returns a rendered __________ to the browser.  
32. The `@app.errorhandler(404)` decorator handles __________ errors.  
33. The `paginate()` method returns a __________ object.  
34. The `form.validate_on_submit()` method checks both form validity and __________ method.  
35. The `login_user()` function logs in a __________.  
36. The `get_or_404()` method returns an object or raises a __________ error.

---

## Code Debugging (5 questions)  
Identify and explain the issue in each code snippet.

37. 
```html
 user.username 
{% if user.is_authenticated %}
  Welcome!
{% endif %}
```

38. 
```python
user = User.query.get(id)
if user == None:
	abort(404)
```

39. 
```python
@app.route('/register', methods=['POST'])
def register():
	form = RegistrationForm()
	if form.validate_on_submit():
		# create user
```

40. 
```python
@app.route('/login', methods=['GET'])
def login():
	form = LoginForm()
	if form.validate_on_submit():
		# log in user
```

41. 
```python
user = User.query.filter_by(username=username)
```

---

## Ordering Steps (5 questions)  
Put the steps in the correct order.

42. Sending email:  
   - A. Create message  
   - B. Configure mail settings  
   - C. Call `send_email()`  
   - D. Import Flask-Mail  

43. Creating a form:  
   - A. Define form class  
   - B. Render form in template  
   - C. Validate form  
   - D. Handle submission logic  

44. Creating a new model:  
   - A. Define model class  
   - B. Add to session  
   - C. Commit session  
   - D. Create migration  

45. User registration:  
   - A. Validate form input  
   - B. Hash password  
   - C. Create user object  
   - D. Add to database  

46. Handling a login request:  
   - A. Create login form  
   - B. Validate form  
   - C. Authenticate user  
   - D. Redirect to next page  

---

## True/False + Justify (4 questions)  
Write True or False and briefly explain your reasoning.

47. Flask automatically commits database changes.  
48. Jinja2 templates can execute Python code directly.  
49. Flask-WTF includes CSRF protection by default.  
50. SQLAlchemy models must inherit from `db.Model`.