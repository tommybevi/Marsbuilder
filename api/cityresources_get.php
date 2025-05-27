<?php
session_start();
require_once(__DIR__ . "/model/resource.php");

$r = Resource::getReosurces($_SESSION["citta_id"]);

echo json_encode($r);

?>