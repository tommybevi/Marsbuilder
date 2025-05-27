<?php
require_once(__DIR__ . "/utils.php");

class Citta{
    var $id;
    var $nome;
    var $propietario;

    /*public static function createNewCity($pid){
        $conn = dbConnect();
        
        $query = "";

        $c = new Citta();

        if($c->id == -1){
            $query = "INSERT INTO citta VALUES(null, 'Base Marziana', $pid)"; 
        }
        
        $res = $conn->query($query);

        return $res;
    }*/

    static function createNewCity($pid){
        $conn=dbConnect();

        $query="";

        $query= "INSERT INTO citta VALUES(null,'Base Marziana',$pid)";

        $res=$conn->query($query);
        
        $query = "SELECT id FROM citta WHERE propietario=$pid";

        $id = $conn->query($query);

        if($id->num_rows > 0){
            $row = $id->fetch_assoc();
            $id = $row["id"];
        }

        Citta::addResources($id);

        return $res;
    }

    static function addResources($id){
        $conn=dbConnect();

        $query="";

        $query= "INSERT INTO risorsecitta VALUES($id,1,100)";

        $conn->query($query);

        $query= "INSERT INTO risorsecitta VALUES($id,2,100)";

        $conn->query($query);

        $query= "INSERT INTO risorsecitta VALUES($id,3,100)";

        $conn->query($query);
    }

    public static function loadFromPlayer($pid){
        $conn = dbConnect();
        
        $query = "";

        $query = "SELECT * FROM citta WHERE propietario = $pid"; 
    
        $res = $conn->query($query);

        if($res->num_rows > 0){
            $row = $res->fetch_assoc();
            $citta = new Citta();
            $citta->id = $row["id"];
            $citta->nome = $row["nome"];
            $citta->propietario = $row["propietario"];
            return $citta;
        }

        return null;
    }

    public static function updateResources($cID,$rID,$qta,$nEdifici){

        $query = "SELECT * FROM risorsecitta WHERE citta=$cID AND risorsa=$rID";

        $conn = dbConnect();

        $res = $conn->query($query);

        $row = $res->fetch_assoc();

        $qtaAttuale = $row["qta"];
        
        $qtaAttuale = $qtaAttuale + $qta * $nEdifici;
        
        $query = "UPDATE risorsecitta SET qta=$qtaAttuale WHERE citta=$cID AND risorsa=$rID";

        $res2 = $conn->query($query);
        
    }


    public static function addBuilding($build,$player,$pos){
        $conn = dbConnect();

        $query = "SELECT giocatori.id as gID, nickname,citta.id as cID,citta.nome as cNome,citta.propietario as cP FROM giocatori JOIN citta ON giocatori.id = citta.propietario WHERE giocatori.nickname="."'$player'";

        $result = $conn->query($query);

        $res = array();

        if($result->num_rows > 0){
            
            $row = $result->fetch_assoc();

            $cID = $row["cID"];

            $query = "SELECT * FROM risorsecitta WHERE citta=$cID";

            $risorse = $conn->query($query);

            $r = array();

            $index = 1;
            if($risorse->num_rows > 0){
                while($row = $risorse->fetch_assoc()){
                    $r["$index"] = $row["qta"];
                    $index++;
                }
            }
            
            $risorse_necessarie = array();

            if(isset($build)){
                
                $query = "SELECT * FROM edificicostruzione WHERE edificio=$build";
            
                $tmp = $conn->query($query);

                if($tmp->num_rows > 0){
                    while($row = $tmp->fetch_assoc()){
                        $i = $row["risorsa"];
                        $risorse_necessarie["$i"] = $row["qta"];
                    }
                }
            }

            for($i = 0; $i < count($r); $i++){
                $y = $i + 1;
                if(array_key_exists("$y",$risorse_necessarie)){
                    if($risorse_necessarie["$y"] < $r["$y"]){
                        $r["$y"] = $r["$y"]-$risorse_necessarie["$y"];
                    }
                    else{
                        return '{"code":3, "desc":"risorse insufficienti"}';
                        break;
                    }
                }
            }

            $query = "SELECT * FROM edificicitta WHERE posizione=$pos";

            $isEmpty = $conn->query($query);

            if($isEmpty->num_rows > 0){
                $row = $isEmpty->fetch_assoc();
                if(($row["edificio"]==6 && $row["edificio"]==$build) || ($row["edificio"]==5 && $row["edificio"]==$build)){

                    while($isEmpty->num_rows > 0){
                        $pos+=100;
                        $query = "SELECT * FROM edificicitta WHERE posizione=$pos AND edificio=$build";
                        $isEmpty = $conn->query($query);
                    }

                    $query = "INSERT INTO edificicitta VALUES(null,".$cID.",'$build',1,'$pos',0,null)";

                    $resultQuery = $conn->query($query);

                    for($i = 0; $i < count($r);$i++){
                        $y = $i+1;
                        $query = "UPDATE risorsecitta SET qta=".$r["$y"]." WHERE risorsa=$y AND citta=$cID";
                        $conn->query($query);
                    }
                    return $cID;
                }
                else{
                    return '{"code":"2","desc":"posizione occupata"}';
                }
            }
            else{

                $query = "INSERT INTO edificicitta VALUES(null,".$cID.",'$build',1,'$pos',0,null)";

                $resultQuery = $conn->query($query);

                for($i = 0; $i < count($r);$i++){
                    $y = $i+1;
                    $query = "UPDATE risorsecitta SET qta=".$r["$y"]." WHERE risorsa=$y AND citta=$cID";
                    $conn->query($query);
                }
                return $cID;
           }
        }
        else{
            return '{"code":"0","desc":"error"}';
        } 
    }
}
?>
