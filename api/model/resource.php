<?php
class Resource{
    var $name;
    var $qta;

    static function getReosurces($cID){
        require_once(__DIR__ . "/utils.php");

        $conn = dbConnect();

        $query = "SELECT * FROM risorsecitta WHERE citta = $cID";

        $res = $conn->query($query);

        $risorse = array();

        if($res->num_rows > 0){
            while($row = $res->fetch_assoc()){
                $r = new Resource();
                $name = "";
                if($row["risorsa"]==1){
                    $name = "Alluminio";
                }
                else if($row["risorsa"]==2){
                    $name = "Cibo";
                }
                else if($row["risorsa"]==3){
                    $name = "Energia";
                }
                $r->name = $name;
                $r->qta = $row["qta"];
                $risorse[] = $r;
            }
        }

        return $risorse;
    }
}

?>