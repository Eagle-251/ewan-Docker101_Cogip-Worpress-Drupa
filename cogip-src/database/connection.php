<?php

function dbconnect(){

    $hostname = "db";
    $usernamedb = "cogip";
    $passworddb = "ohv9vee1joleepa7eepudaitho6aecae6uXee0Juataeth7koocie0ahva7po5la";
    $dbname = "cogip";

    $conn = mysqli_connect($hostname, $usernamedb, $passworddb, $dbname) or die ("unable to connect");
    return $conn;
}
?>
