<?php

function dbconnect(){

    $hostname = "db";
    $usernamedb = "cogip";
    $passworddb = "password";
    $dbname = "cogip";

    $conn = mysqli_connect($hostname, $usernamedb, $passworddb, $dbname) or die ("unable to connect");
    return $conn;
}
?>
