<?php
    header('Content-type: application/json; charset=utf-8');

    require_once(__DIR__ . "/model/giocatore.php");

    //se dentro il post c'è un parametro data allora creo il giocatore
    if(array_key_exists("data",$_POST)){
        // i due punti mi servono per chiamare la funzione senza creare un nuovo oggetto
        $giocatore = Giocatore::createFromJSON($_POST["data"]);

        if($giocatore->save()){
            require_once(__DIR__ . "/model/citta.php");
            Citta::createNewCity($giocatore->id);
            echo '{"code": 1, "desc": "Giocatore salvato con successo"}';
        }
        else{
            echo '{"code": 0, "desc": "Dati di registrazione errati"}';
        }
    }
    //Se non c'è do errore
    else{
        echo '{"code": 0, "desc": "Malformed Request."}';
    }

    
?>