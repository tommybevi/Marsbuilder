/****************************************************/
/*               FUNZIONI DI NAVIGAZIONE            */
/****************************************************/

function goToGoogle(){
    window.location = "https://www.google.com"
}

/****************************************************/
/*               FUNZIONI DI REGISTRAZIONE          */
/****************************************************/

async function register(){
    let data = {
        id: -1,
        email: document.getElementById("r-email").value,
        nickname: document.getElementById("r-nickname").value,
        avatar: "",
        password: document.getElementById("r-password").value
    };

    let formData = new FormData(); /*è un form virtuale*/
    formData.append("data", JSON.stringify(data));/*abbiamo trasformato i dati in una stringa json*/

    res = await fetch("./api/register.php",{
        method: "POST", /*tipo di richiesta*/
        body: formData /*cosa invio*/
    });

    //mi butto il risultato del fetch e se il testo è un errore allora lo noto subito
    //console.log(await res.text());
    
    res = await res.json();

    if(res.code == 1){
        alert(res.desc);
        window.location.reload;
    }
    else{
        alert("Errore di salvataggio: " + res.desc);
    }

    document.getElementById("r-email").value = "";
    document.getElementById("r-password").value = "";
    document.getElementById("r-cpassword").value = "";
    document.getElementById("r-nickname").value = "";
}

function clear_fields(){
    document.getElementById("l-email").value = "";
    document.getElementById("l-password").value = "";
}

async function login(){
    let data = {
        email: document.getElementById("l-email").value,
        password: document.getElementById("l-password").value
    };

    let formData = new FormData(); /*è un form virtuale*/
    formData.append("data", JSON.stringify(data));/*abbiamo trasformato i dati in una stringa json*/

    res = await fetch("./api/login.php",{
        method: "POST", /*tipo di richiesta*/
        body: formData /*cosa invio*/
    });

    //mi butto il risultato del fetch e se il testo è un errore allora lo noto subito
    //console.log(await res.text());
    res = await res.json();
    
    if(res.code == 1){
        alert("Utente riconosciuto");
        window.location.href = "./game.html";
        //document.getElementById("welcome_message").innerHTML = 
    }
    else{
        alert("Errore di salvataggio: " + res.desc);
    }
    
}

function check(){

}