from flask import Flask, render_template, flash, request, session, url_for, redirect
from wtforms import Form, TextField, validators
from flask_bootstrap import Bootstrap
import pathlib
from chibchas.tools import main
import uuid
import tempfile
import shutil 

# App config.
DEBUG = True
app = Flask(__name__, template_folder=str(
    pathlib.Path(__file__).parent.absolute()) + '/templates/')
app.config.from_object(__name__)
app.config['SECRET_KEY'] = str(uuid.uuid1())

Bootstrap(app)

gdrive_path = ""

class WebForm(Form):
    name = TextField('Usuario:', validators=[validators.required()])
    password = TextField('Contraseña:', validators=[
                         validators.required(), validators.Length(min=3, max=35)])


@app.route("/", methods=['GET', 'POST'])
def index():
    form = WebForm(request.form)

    print(form.errors)
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        print(username, " ", password)

        session.clear()
        session['username'] = username
        session['password'] = password
        return redirect(url_for('processing'))
        #main(username,password,tmp_path)
        #shutil.copytree(tmp_path, gdrive_path,dirs_exist_ok=True) 

    if form.validate():
        # Save the comment here.
        flash('Thanks for registration ' + name)
    else:
        flash('Error: All the form fields are required. ')

    return render_template('login.html', form=form)


@app.route("/processing", methods=['GET', 'POST'])
def processing():
    if not "username" in session.keys() and not "password" in session.keys() :
        return redirect(url_for('index'))
    return render_template('processing.html')

@app.route("/executor", methods=['GET', 'POST'])
def executor():
    if not "username" in session.keys() and not "password" in session.keys() :
        return redirect(url_for('index'))
    print(session)
    username = session['username'] 
    password = session['password']
    tmp_path = tempfile.mkdtemp()
    print("Saving data on temporal folder {}".format(tmp_path))
    main(username,password,tmp_path)
    shutil.copytree(tmp_path, gdrive_path,dirs_exist_ok=True) 
    return redirect(url_for('index'))


def run_server(ip,port,gdrive_path_):  # to do ip and port
    global gdrive_path
    gdrive_path = gdrive_path_
    app.run(host=ip,port=port)
