<?php

if (!empty($_GET['q'])) {
  switch ($_GET['q']) {
    case 'info':
      phpinfo();
      exit;
      break;
  }
}

// Функция для подключения к базе данных
function connect()
{
  $mydb = pg_connect("host=localhost port=5433 dbname=mag user=postgres password=root");
  if (!$mydb) {
    echo "An error occurred.\n";
    exit;
  }
  return $mydb;
}

function getContactINFO($uid = 1)
{
  $mydb = pg_connect("host=localhost port=5433 dbname=mag user=postgres password=root");
  $pg = pg_query($mydb, "select get_client($uid)");
  pg_close($mydb);
  return $pg;
}
?>
<!DOCTYPE html>
<html>

<head>
  <title>Мой салон</title>

  <link href="https://fonts.googleapis.com/css?family=Karla:400" rel="stylesheet" type="text/css">

  <style>
    html,
    body {
      height: 100%;
    }

    body {
      margin: 0;
      padding: 0;
      width: 100%;
      display: table;
      font-weight: 100;
      font-family: 'Karla';
    }

    .container {
      text-align: center;
      display: table-cell;
      vertical-align: middle;
    }

    .content {
      text-align: center;
      display: inline-block;
    }

    .title {
      font-size: 56px;
    }

    .opt {
      margin-top: 30px;
    }

    .opt a {
      text-decoration: none;
      font-size: 150%;
    }

    a:hover {
      color: red;
    }
  </style>
</head>

<body>
  <div class="container">
    <div class="content">
      <div class="title" title="Saloon">Мой салон</div>
      <form action="" method="GET">
        <input type="text" value="<?= $_GET['uidus'] ?? '' ?>" name="uidus" placeholder="UID клиента...">
        <input type="submit" class="btn">
        <div>
          <span>Результат: </span>
          <?php
          if (!empty($_GET)) {
            $result = getContactINFO((int)$_GET['uidus']);
            while ($row = pg_fetch_array($result)) {
              echo 'Клиент: ' . $row[0];
            }
          } else {
            "false";
          } ?>
        </div>
      </form>
    </div>

  </div>
</body>

</html>