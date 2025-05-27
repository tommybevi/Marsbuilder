<?php
//prende il contenuto da uno script e se chiedo il file più di una volta lo tiene inserito sempre una volta, mentre require lo potrebbe fare
//__DIR__ fa riferimento alla cartella in cui mi trovo VA MESSO
require_once(__DIR__ . "/utils.php");

class Giocatore{
    var $id;
    var $nickname;
    var $email;
    var $password;
    var $avatar;
    private static $key = '8eaee977ba2cfbdf2541aa937e90dd05e4b00214529402a32fad0fa24bbde1c1';

    //costruttore della classe
    public function __construct(){
        $this->id = -1;
        $this->nickname;
        $this->email;
        $this->avatar;
    }

    public function save(){
        $conn = dbConnect();
        
        $query = "";

        if($this->id == -1){
            $query = "INSERT INTO giocatori VALUES(null," . 
            "'" . $this->nickname . "', " .
             "AES_ENCRYPT('" . $this->email ."','". self::$key . "')," .
              "'" . $this->avatar ."', " .
               "AES_ENCRYPT('" . $this->password ."','". self::$key . "'))";
        }
        else{
            $query = "UPDATE giocatori SET" .
             "avatar = '" . $this->avatar . "', " .
              "' password AES_ENCRYPT('" . $this->password ."','". self::$key . "'))". 
              " WHERE id=" . $this->id;
        }

        $res = $conn->query($query);


        if($res){
            $this->id = mysqli_insert_id($conn);
        }

        return $res;
    }

    public static function createFromJSON($json){
        $g = new Giocatore();
        //trasformo in un oggetto php l'oggetto json data che si trova in POST
        $data = json_decode($json);

        $g->id = $data->id;
        $g->nickname = $data->nickname;
        $g->email = $data->email;
        $g->password = $data->password;
        $g->avatar = $data->avatar;

        return $g;
    }

    public static function login($email, $password){
        $conn = dbConnect();
        
        $query = "";

        /*$query = "SELECT id, nickname, AES_DECRYPT(email," . self::$key . ") as email, avatar FROM giocatori" . 
        "WHERE email=AES_ENCRYPT('$email','" . self::$key . "') AND password=AES_ENCRYPT('$password','" . self::$key . "')";*/

        $query = "SELECT id, nickname, AES_DECRYPT(email,'" . self::$key . "') as email, avatar FROM giocatori " .
             "WHERE AES_DECRYPT(email,'" . self::$key . "') = '" . $email . "' " .
             "AND AES_DECRYPT(password,'" . self::$key . "') = '" . $password . "'";

        //echo $query;

        $result = $conn->query($query);

        $res = new Giocatore();

        if($result->num_rows > 0){
            //fetc_assoc definisce l'iteratore che prende una riga alla volta del risultato e la restituisce un array associativo
            $row = $result->fetch_assoc();
            $res = new Giocatore();
            $res->id = $row["id"];
            $res->nickname = $row["nickname"];
            $res->email = $row["email"];
            $res->avatar = $row["avatar"];
        }
        //echo $res;
        return $res;
    }


}
?>