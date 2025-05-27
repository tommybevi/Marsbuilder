<?php

require_once(__DIR__ . "/utils.php");

class EdificioCitta{
    //derivano da Edifici Citta
    var $id;
    var $citta;
    var $edificio;
    var $livello;
    var $quantita;
    var $posizione;

    //Derivano da Edifici
    var $tipo;
    var $modello3D;
    var $capacita;


    public static function loadEdifici($citta){
        $conn = dbConnect();
        
        $query = "";

        $query="SELECT ec.*, e.tipo, e.modello3d, e.capacita FROM edificicitta ec JOIN edifici e ON ec.edificio=e.id WHERE citta=$citta";
    
        $result = $conn->query($query);//iteratore remoto, va a iterare gli elementi sul dbms

        $res = array();

        if($result->num_rows > 0){
            while($row=$result->fetch_assoc()){
                $tmp = new EdificioCitta();
                $tmp->id = $row["id"];
                $tmp->citta = $row["citta"];
                $tmp->edificio = $row["edificio"];
                $tmp->livello = $row["livello"];
                $tmp->quantita = $row["qta_prodotta"];
                $tmp->posizione = $row["posizione"];
                
                
                $tmp->tipo = $row["tipo"];
                $tmp->modello3D = $row["modello3d"];
                $tmp->capacita = $row["capacita"];

                $res[] = $tmp;
            }
            
            
            return $res;
        }
        return $res;
    }
}

?>