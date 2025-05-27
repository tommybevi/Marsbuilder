<?php

require_once(__DIR__ . "/utils.php");

class Edificio{
    //derivano da Edifici Citta
    var $id;
    var $tipo;
    var $modello3D;
    var $capacita;


    public static function loadEdifici(){
        $conn = dbConnect();
        
        $query = "";

        $query="SELECT * FROM edifici";
    
        $result = $conn->query($query);//iteratore remoto, va a iterare gli elementi sul dbms

        $res = array();

        if($result->num_rows > 0){
            while($row=$result->fetch_assoc()){
                $tmp = new Edificio();
                $tmp->id = $row["id"];
                $tmp->tipo = $row["tipo"];
                $tmp->modello3D = $row["modello3d"];
                $tmp->capacita = $row["capacita"];
                
                $res[] = $tmp;
            }
            
            
            return json_encode($res);
        }

        return $res;
    }

    public static function findEdificio($id){
        $conn = dbConnect();
        
        print_r("nome:");
        print_r($name);

        $query = "";

        $tmp = NULL;

        $query="SELECT * FROM edifici WHERE id=$id";
    
        $result = $conn->query($query);//iteratore remoto, va a iterare gli elementi sul dbms

        $res = array();
        print_r("num rows");
        print_r($result->num_rows);
        if($result->num_rows > 0){
            $row=$result->fetch_assoc();
                $tmp = new Edificio();
                $tmp->id = $row["id"];
                $tmp->tipo = $row["tipo"];
                $tmp->modello3D = $row["modello3d"];
                $tmp->capacita = $row["capacita"];
                return $row["id"];   
        }
                
        else{
            return '{"code":"0","desc":"error"}';
        } 


        //return $res;
    }

    public static function findFarmingBuildings(){
        require_once(__DIR__ . "/utils.php");
        $conn = dbConnect();
        $query = "SELECT *,COUNT(*) as nEdifici FROM edificiproduzione JOIN edificicitta ON edificiproduzione.edificio = edificicitta.edificio GROUP BY edificicitta.edificio";
        $result = $conn->query($query);
        $res = array();
        if($result->num_rows > 0){
            while($row=$result->fetch_assoc()){
                $res[] = array(
                    "edificio"=> $row["edificio"],
                    "risorsa"=> $row["risorsa"],
                    "qta"=> $row["qta"],
                    "nEdifici"=> $row["nEdifici"]
                );
            }
        }
        return json_encode($res);
    }
}

?>