# store_app

Welcome to the Store App repository! 🛒🍔

Explore our store/restaurant app designed to make your culinary journey delightful. Discover a variety of mouthwatering dishes, place orders effortlessly, and create an account to enhance your experience.

## Setup Guide

This app uses PostgreSQL as a Database Host, Elixir 1.15.7/Phoenix 1.7.9 for Full-Stack development (API and Front-End), and Docker Compose for containerizing. After cloning the repository, by running:
`git clone https://github.com/JoeHn01/store_app.git`
you can setup the app locally by navigating to the project directory:
`cd /store_app/store/`
and running:
`docker-compose up --build`.
Then it will create the containers, start setting up all the dependencies and project files, then it will start the server, which you can access on [`localhost:4000`](http://localhost:4000). If it shows that there are pending migrations, click the button that says "Run Migrations". This is to set up the PostgreSQL database, which will be running on port `5432`. Please start by registering an account, as the hosted database will be empty. Add the necessary information, then it will automatically log you in and display the home page. You can log in and out and explore the app as you like.

