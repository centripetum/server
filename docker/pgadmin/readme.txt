use pgadmin in broweser:

1. make sure you are at this folder
    pwd
2. make a .env file, modify to use your login email and password
    cp template.env .env
3. start this docker compose:
    docker-compose up -d
4. open broweser, type url:
    http://localhost:5050/
    use your email and password to login
5. create new server to connect your host's port 5432
    use the host name: db
    use the user name: postgres
    fill your postgres password