<?php
//in qualche modo il web server può registrare tutti i dati in una variabile $_SESSION 
    session_start();// $_SESSION viene popolata nel momento in cui ho fatto la login

    header('Content-type: application/json; charset=utf-8');

    require_once(__DIR__ . "/model/giocatore.php");

    //se dentro il post c'è un parametro data allora creo il giocatore
    if(array_key_exists("data",$_POST)){
        $login = json_decode($_POST["data"]);
        //echo $login;
        $g = Giocatore::login($login->email,$login->password);
        if($g == null){
            echo '{"code":0, "desc": "L\'utente non esiste"}';
        }
        else{
            $_SESSION["giocatore"] = $g;
            require_once(__DIR__ . "/model/citta.php");
            $c = Citta::loadFromPlayer($g->id);// loadFromPlayer è un factory method
            if($c == null){
                echo '{"code":1, "desc": Errore nel caricamento nel server"}';
            }
            else{
                $_SESSION["citta_id"] =$c->id;
                echo '{"code":1, "desc": "Login effetuato con successo."}';
            }
        }
    }

    
?>