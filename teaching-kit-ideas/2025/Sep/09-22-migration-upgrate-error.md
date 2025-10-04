

##  Fixing a Broken Migration (Chapter 6)

If your app crashes with `no such column: user.about_me`, follow these five steps to recover:

###  Step 1: Downgrade the Database
```bash
flask db downgrade
```

###  Step 2: Delete the Faulty Migration
Delete the `.py` file in `migrations/versions/` that added `about_me` and `last_seen`.

The file should be named something like this:
<revision_id>_new_fields_in_user_model.py

###  Step 3: Confirm Your Model Is Correct
In `app/models.py`, make sure these fields exist:

```python
about_me: so.Mapped[Optional[str]] = so.mapped_column(sa.String(140))
last_seen: so.Mapped[Optional[datetime]] = so.mapped_column(
    default=lambda: datetime.now(timezone.utc)
)
```

###  Step 4: Recreate the Migration
```bash
flask db migrate -m "Add about_me and last_seen to User"
```

###  Step 5: Apply the Migration
```bash
flask db upgrade
```

Then restart your app:
```bash
flask run
```

---


