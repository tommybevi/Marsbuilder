<?php
session_start();
require_once(__DIR__ . "/model/edificio.php");
$res = Edificio::findFarmingBuildings($_SESSION["citta_id"]);
echo $res;
?>