from flask import Flask, render_template, flash, request
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
def login():
    form = WebForm(request.form)

    print(form.errors)
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        print(username, " ", password)

        tmp_path = tempfile.mkdtemp()
        print("Saving data on temporal folder")
        main(username,password,tmp_path)
        shutil.copytree(tmp_path, gdrive_path,dirs_exist_ok=True) 

    if form.validate():
        # Save the comment here.
        flash('Thanks for registration ' + name)
    else:
        flash('Error: All the form fields are required. ')

    return render_template('login.html', form=form)


def run_server(ip,port,gdrive_path_):  # to do ip and port
    global gdrive_path
    gdrive_path = gdrive_path_
    app.run(host=ip,port=port)
