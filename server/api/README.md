# Team Gamma AI API
COS 301 Team Gamma AI API built using the Django framework on python.

-------------

### Installation Instructions
- _(Recommended)_ Create a new Python 3 virtual environment
    - Create it: `python3 -m venv ./environment`
    - Activate it: `source ./environment/bin/activate`
- Install Django **3.0.4** and other packages [python 3.5+ required]
    - `pip3 install -r ./requirements.txt`
- Apply Database Migrations
    - `python3 manage.py migrate`
- Create root user
    - `python3 manage.py createsuperuser` 
- Run the server
    - `python3 manage.py runserver`
