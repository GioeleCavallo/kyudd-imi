# Progetto Kyudd-imi

## Abstract
<font size="4">
  
_For this project, it was required to create a local website to display the open and closed windows of the building. In addition, classrooms with open windows and statistics on the opening and closing of individual windows and status history are also to be displayed. 
Since the website is to be used by janitors to close open windows, it needs to be responsive so that it can be used from both mobile devices and computers.
Also wanted is separate users between admin and standard users who will be able to perform different operations.
The database will be hosted on a raspberry, as the website, and will be populated with minimal information such as: transaction number, time change status, information about the ESP32 device that collected the information, name and window/classroom number, the status of the window._

</font>
<br>

## Installation

<font size="4">
  
To install the site in a local enviroment, first of all you have to install node using:

> **_NOTE:_**  Look at the [original documentation](https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions) for the right version.


```shell
$ curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -
$ sudo apt update
$ sudo apt install nodejs
```

<br>

After that you have to clone the repo into the home directory using those commands:


```shell
$ cd ~
~$ sudo git clone http://gitsam.cpt.local/lavoro_finale_lpi_2023/progetto-kyudd-imi.git
```
<br>

Once all is installed use this command to install all dependencies:

```properties
npm install
```  

<br>
<br>
<br>

After that create the database and use the file into _6_Database/_ to insert data. You can copy and paste the _sql.sql_ file content into myql console. Or you can use:


```shell
$ mysql -u yourusername -p 
Enter password: _   
mysql> CREATE DATABASE kyudd_imi;
mysql> exit;
$ mysql -u root -p kyudd_imi < path/to/6_Database/sql.sql
```

> **_NOTE:_**  Remember to change the creation of the database and the name in the sql.sql file.


<br>


Now create the .env file and set those variables into the site folder:

```shell
$ nano .env
```

- PUBLIC_DIR="~/path/to/5_Applictivo/site/public"
- DB_USER="user"
- DB_HOST="127.0.0.1"
- DB_PASSWORD="password"
- DB_DATABASE="kyudd_imi"

<br>

It's all done! Enojoy.

```shell
$ node server.js
server stared on port 80
...
```

<br>
<br>
<br>

> **_IMPORTANT:_**  If you are running the server from a different path from where is located (like ` node /var/site/server.js`), remember to change the dotenv require to: `require('dotenv').config({ path: '/custom/path/to/.env' })`.
>
> Change it to both server.js and database.js 


</font>
