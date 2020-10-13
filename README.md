
  <h3 align="center">CMS</h3>

  <p align="center">
    Contact Management System
  </p>



<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
  * [Built With](#built-with)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
* [Usage](#usage)
* [Contact](#contact)



<!-- ABOUT THE PROJECT -->
## About The Project

This project is a system that manages the contact data of users


### Built With

* Bootstrap
* JQuery
* Java
* Spring Boot



<!-- GETTING STARTED -->
## Getting Started

Follow the succeeding steps to locally run a copy of the system.

### Prerequisites

You must have these tools installed to run the system locally
* Java
https://docs.oracle.com/javase/8/docs/technotes/guides/install/install_overview.html
* Maven
https://maven.apache.org/install.html
* MySQL
https://dev.mysql.com/doc/mysql-installation-excerpt/8.0/en/

### Installation

1. Clone the repo
```sh
git clone https://github.com/harveyteofilo/CMS.git
```
2. Create and Initialize the database by running the sql scripts inside the scripts directory
```sh
NOTE: Change the DB credentials accordingly

mysql -u <USERNAME> -p<PASSWORD> -e "SOURCE create_db.sql"
mysql -u <USERNAME> -p<PASSWORD> -e "SOURCE init_db.sql"
```
3. Update the application's database configuration accordingly
```sh
/CMS/src/main/resources/application.properties

jdbc.driverClassName=com.mysql.jdbc.Driver
jdbc.url=jdbc:mysql://localhost/cms_db?serverTimezone=UTC
jdbc.username=root
jdbc.password=root123
git clone https://github.com/harveyteofilo/CMS.git
```
4. Build and run the application
```sh
mvn clean package spring-boot:run
```

<!-- USAGE EXAMPLES -->
## Usage

Visit the application's Home page
http://localhost:8080/cms/home

<!-- CONTACT -->
## Contact

Your Name - Paul Harvey Teofilo (harveyteofilo@gmail.com)

Project Link: [https://github.com/harveyteofilo/CMS.git]

