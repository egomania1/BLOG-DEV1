<?php
  // Clever Cloud injecte MYSQL_ADDON_* quand l'add-on MySQL est lié à l'app ;
  // MYSQL* reste pour Railway, puis les valeurs XAMPP en local.
  $host     = getenv('MYSQL_ADDON_HOST')     ?: getenv('MYSQLHOST')     ?: 'localhost';
  $dbname   = getenv('MYSQL_ADDON_DB')       ?: getenv('MYSQLDATABASE') ?: 'blog_mvc';
  $username = getenv('MYSQL_ADDON_USER')     ?: getenv('MYSQLUSER')     ?: 'root';
  $password = getenv('MYSQL_ADDON_PASSWORD') ?: getenv('MYSQLPASSWORD') ?: '';
  $port     = getenv('MYSQL_ADDON_PORT')     ?: getenv('MYSQLPORT')     ?: '3306';

  try {
      $pdo = new PDO(
          "mysql:host=$host;port=$port;dbname=$dbname;charset=utf8mb4",
          $username,
          $password
      );
      $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  } catch (PDOException $e) {
      die('Erreur de connexion : ' . $e->getMessage());
  }
  ?>
