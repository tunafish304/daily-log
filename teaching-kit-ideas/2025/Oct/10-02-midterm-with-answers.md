
# Flask Mega-Tutorial Midterm (Instructor Version — With Answers)

## Multiple Choice (15 questions)

1. What command initializes a new Flask application?  
   **Answer**: C — No command is needed; just create an app instance  
   **Explanation**: Flask apps start by instantiating `Flask(__name__)`.

2. Which file typically contains the Flask app instance in the microblog tutorial?  
   **Answer**: A — `__init__.py`  
   **Explanation**: This supports modular structure and package initialization.

3. What does the `@app.route` decorator do?  
   **Answer**: A — Registers a URL route  
   **Explanation**: It binds a view function to a URL.

4. Which extension is used for form handling in Flask?  
   **Answer**: D — Flask-WTF  
   **Explanation**: Flask-WTF integrates WTForms for validation and rendering.

5. What is the purpose of CSRF protection in forms?  
   **Answer**: A — To prevent cross-site request forgery  
   **Explanation**: It blocks unauthorized form submissions from other sites.

6. What does `url_for('login')` return?  
   **Answer**: B — The login route URL  
   **Explanation**: It generates the URL for the `login` endpoint.

7. Which method checks if a user is authenticated?  
   **Answer**: C — `current_user.is_authenticated`  
   **Explanation**: This property is provided by Flask-Login.

8. What does `flash()` do in Flask?  
   **Answer**: B — Displays messages to the user  
   **Explanation**: It stores messages for display after a redirect.

9. What is the purpose of `@login_required`?  
   **Answer**: B — Restricts access to authenticated users  
   **Explanation**: It protects routes from unauthenticated access.

10. Which command initializes a migration repository?  
    **Answer**: A — `flask db init`  
    **Explanation**: This sets up Alembic migration tracking.

11. What does `current_user` represent in Flask-Login?  
    **Answer**: A — The user currently logged in  
    **Explanation**: It’s a proxy for the authenticated user.

12. What does `form.validate_on_submit()` check?  
    **Answer**: A — That the form was submitted and is valid  
    **Explanation**: It checks for POST and valid input.

13. What does `db.session.commit()` do?  
    **Answer**: B — Saves changes to the database  
    **Explanation**: It finalizes staged transactions.

14. What does `lazy='dynamic'` do in a relationship?  
    **Answer**: C — Allows query filtering on the relationship  
    **Explanation**: It returns a query object instead of a list.

15. What does `get_or_404()` return?  
    **Answer**: C — An object or a 404 error  
    **Explanation**: It retrieves the object or aborts.

---

## Short Answer (10 questions)

16. What is the role of `__init__.py` in a Flask app?  
   **Answer**: It initializes the app package and registers blueprints and extensions.

17. Why is CSRF protection important?  
   **Answer**: It prevents unauthorized form submissions from external sites.

18. How does Flask-Migrate help manage database changes?  
   **Answer**: It uses Alembic to track and apply schema migrations.

19. What does `current_user` represent?  
   **Answer**: The currently authenticated user object.

20. How does pagination improve user experience?  
   **Answer**: It breaks large datasets into smaller pages for readability and performance.

21. What does `@app.before_request` do?  
   **Answer**: Runs a function before each request, often for authentication or logging.

22. What does `form.hidden_tag()` do?  
   **Answer**: Renders hidden fields including the CSRF token.

23. What does `db.session.commit()` do?  
   **Answer**: Saves all staged changes to the database permanently.

24. Why use `lazy='dynamic'` in relationships?  
   **Answer**: It allows query filtering and chaining on relationship attributes.

25. What does the `follow()` method do in the User model?  
   **Answer**: Adds another user to the current user's followed list.

---

## Match the Concept (5 questions)

26. Match each function to its role:  
Column A | Column B  
---------|----------  
A. `render_template()` | 1. Renders HTML  
B. `redirect()`        | 2. Sends user to another route  
C. `url_for()`         | 3. Generates route URL  
D. `flash()`           | 4. Displays messages  

**Answer**:  
A → 1  
B → 2  
C → 3  
D → 4

---

## Fill in the Blank (10 questions)

27. What SQLAlchemy method defines relationships between models?  
   **Answer**: `db.relationship()`

28. What function displays temporary messages to the user?  
   **Answer**: `flash()`

29. What HTTP method must be used for `validate_on_submit()` to return `True`?  
   **Answer**: `POST`

30. What function generates a URL for a given endpoint?  
   **Answer**: `url_for()`

31. What function renders a template into HTML?  
   **Answer**: `render_template()`

32. What error does `@app.errorhandler(404)` handle?  
   **Answer**: `Not Found`

33. What object does `paginate()` return?  
   **Answer**: `Pagination`

34. What two things does `validate_on_submit()` check?  
   **Answer**: Request method and form validity

35. What does `login_user()` do?  
   **Answer**: Logs in a user

36. What does `get_or_404()` do if no object is found?  
   **Answer**: Raises a 404 error

---

## Code Debugging (5 questions)

37.  
```html
{{ user.username }}
{% if user.is_authenticated %}
  Welcome!
{% endif %}
```  
**Issue**: `user.is_authenticated` should be `current_user.is_authenticated`.

38.  
```python
user = User.query.get(id)
if user == None:
    abort(404)
```  
**Issue**: Use `is None` instead of `== None`.

39.  
```python
@app.route('/register', methods=['POST'])
def register():
    form = RegistrationForm()
    if form.validate_on_submit():
        # create user
```  
**Issue**: Missing `'GET'` in methods list; form won't render on initial visit.

40.  
```python
@app.route('/login', methods=['GET'])
def login():
	form = LoginForm()
	if form.validate_on_submit():
		# log in user
```
Issue: `validate_on_submit()` will never return `True` because the route only accepts `GET`.

41.  
```python
user = User.query.filter_by(username=username)
```
Issue: Missing `.first()` or `.one()` — this returns a query object, not a user.

user = User.query.filter_by(username=username).first() (or .one)
---

## Ordering Steps (5 questions)

42. Sending email:  
   - A. Create message  
   - B. Configure mail settings  
   - C. Call `send_email()`  
   - D. Import Flask-Mail  
   **Answer**: D → B → A → C

43. Creating a form:  
   - A. Define form class  
   - B. Render form in template  
   - C. Validate form  
   - D. Handle submission logic  
   **Answer**: A → B → C → D

44. Creating a new model:  
   - A. Define model class  
   - B. Add to session  
   - C. Commit session  
   - D. Create migration  
   **Answer**: A → D → B → C

45. User registration:  
   - A. Validate form input  
   - B. Hash password  
   - C. Create user object  
   - D. Add to database  
   **Answer**: A → B → C → D

46. Handling a login request:  
   - A. Create login form  
   - B. Validate form  
   - C. Authenticate user  
   - D. Redirect to next page  
   **Answer**: A → B → C → D

---

## True/False + Justify (4 questions)

47. Flask automatically commits database changes.  
   **Answer**: False — You must call `db.session.commit()` explicitly.

48. Jinja2 templates can execute Python code directly.  
   **Answer**: False — Jinja2 supports expressions and control structures, not arbitrary Python.

49. Flask-WTF includes CSRF protection by default.  
   **Answer**: True — CSRF is enabled unless explicitly disabled.

50. SQLAlchemy models must inherit from `db.Model`.  
   **Answer**: True — This provides the ORM functionality.


