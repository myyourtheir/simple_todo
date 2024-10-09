from flask import Flask, render_template, make_response
from flask import request
import psycopg2
import json

# Connect to your postgres DB

conn = psycopg2.connect(
    database="todo", user="todo", password="todo", host="db_todo", port="5432"
)


app = Flask(__name__, template_folder="templates")


@app.route("/")
def hello_world():
    return render_template("index.html")


@app.route("/add/")
def add_task():
    return render_template("add.html")


@app.route("/add/<int:id>")
def edit_task(id):
    return render_template("add.html")


@app.route("/tasks", methods=["GET", "POST"])
def tasks():
    if request.method == "POST":
        title = request.form["title"]
        description = request.form["description"]
        with conn.cursor() as cur:
            cur.execute(
                "INSERT INTO tasks (title, description) VALUES (%s, %s);",
                (title, description),
            )
            conn.commit()
            cur.execute("SELECT * FROM tasks;")
            tasks = cur.fetchall()
            resp = make_response(tasks, 201)
    if request.method == "GET":
        with conn.cursor() as cur:
            cur.execute("SELECT * FROM tasks Order By created_at DESC;")
            tasks = cur.fetchall()
            prep_tasks = []
            for task in tasks:
                id, title, description, created_at = task
                task = {
                    "id": id,
                    "title": title,
                    "description": description,
                }
                prep_tasks.append(task)
            tasks = json.dumps(prep_tasks)
            resp = make_response(tasks if tasks else [], 200)
    return resp


@app.route("/tasks/<int:id>", methods=["DELETE", "PUT"])
def delete_task(id):
    with conn.cursor() as cur:
        if request.method == "DELETE":
            cur.execute("DELETE FROM tasks WHERE id = %s;", (id,))
            conn.commit()
            cur.execute("SELECT * FROM tasks;")
            tasks = cur.fetchall()
            resp = make_response(tasks, 200)
        if request.method == "PUT":
            title = request.form["title"]
            description = request.form["description"]
            cur.execute(
                "UPDATE tasks SET title = %s, description = %s WHERE id = %s;",
                (title, description, id),
            )
            conn.commit()
    return resp
