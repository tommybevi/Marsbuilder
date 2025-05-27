import * as THREE from 'three';
import {GLTFLoader} from 'three/addons/loaders/GLTFLoader.js';
import { Hud } from './hud.js';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';


let renderer = null;      // Il motore di render

let scene = null;         // la scena radice
let camera = null;        // la camera da cui renderizzare la scena
let audiolistener = null; // L'oggetto per sentire i suoni del gioco  
let clock = null;         // Oggetto per la gestione del timinig della scena
let raycaster = null;
let oldIntersects = null;
let hudScene = null;
let cameraHud = null;
let selection = null;
let buildings = null;
let oldSelectIntersects = null;
let resource = null;
let controls = null;
let position = null;


let jsonMap = '{"row": 10, "col": 10, "data": ' +
               '['+
                '[{"cat": 5, "rot":1}, {"cat": 3, "rot":1}, {"cat": 3, "rot":1}, {"cat": 3, "rot":1}, {"cat": 3, "rot":1}, {"cat": 3, "rot":1}, {"cat": 3, "rot":1}, {"cat": 3, "rot":1}, {"cat": 3, "rot":1}, {"cat": 4, "rot":1}],' +
                '[{"cat": 3, "rot":2}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}],' +
                '[{"cat": 3, "rot":2}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}],' +
                '[{"cat": 3, "rot":2}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}],' +
                '[{"cat": 3, "rot":2}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}],' +
                '[{"cat": 3, "rot":2}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}],' +
                '[{"cat": 3, "rot":2}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}],' +
                '[{"cat": 3, "rot":2}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}],' +
                '[{"cat": 3, "rot":2}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}],' +
                '[{"cat": 4, "rot":1}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 1, "rot":0}, {"cat": 2, "rot":1}]' +
               ']}';


/**
 * L'array delle mesh delle pedine che costituiscono la board
 */
let meshBoard = [];

/**
 * Il set dei valori che rappresentano la board
 */
let board = [];

/**
 * Luce direzionale, al momento non è utile
 */
let dl = null;

let eventListener = null;

let r = null;

/*
 * Inizializza il motore
 */ 
function initScene(){

  raycaster = new THREE.Raycaster();

  document.getElementById("intro").style.display = "none";
  document.getElementById("threejs").style.display = "block";
  document.getElementById("message").style.display = "block";

  if (renderer != null) return;

  let canv = document.getElementById("threejs");

  let width = canv.clientWidth;
  let height = canv.clientHeight;
  canv.width = canv.clientWidth;
  canv.height = canv.clientHeight;

  renderer = new THREE.WebGLRenderer({antialias: "true", powerPreference: "high-performance", canvas: canv});
  renderer.autoClear = false;
  renderer.setSize(width, height);
  renderer.setClearColor("black", 1);
  renderer.shadowMap.enabled = true;

  camera = new THREE.PerspectiveCamera(50, width/height, 0.1, 500);
  camera.position.set(4.5, 4.80, 0);
  camera.lookAt(4.5, 0, 4.5);
  

  cameraHud = new THREE.OrthographicCamera( width / - 2, width / 2, height / 2,height / - 2, 1, 1000 );
  cameraHud.position.set(0,0,-6);
  cameraHud.lookAt(0,0,0);

  hudScene = new THREE.Scene();

  audiolistener = new THREE.AudioListener();
  camera.add(audiolistener);

  clock = new THREE.Clock();

  scene = new THREE.Scene();
  scene.background = new THREE.Color(0x555555);

  dl = new THREE.DirectionalLight(0xFFFFFF, 1);
  scene.add(dl);

  createBoard(15, 15); 
  getCityData();;
  getHudElements();
  controls = new OrbitControls(camera, renderer.domElement);
  controls.update();
  renderer.setAnimationLoop(animate);
  setInterval(updateResources, 3000);
}

/**
 * Crea la board di gioco
 * @param {Number} max Il numero di elementi complessivi della board; deve essere un numero divisibile per 4
 * @param {Number} size Le dimensioni della geometria 
 */
async function createBoard(width, height){
  //console.log(jsonMap);
  let map = JSON.parse(jsonMap);

  let loader = new GLTFLoader();
  
  meshBoard = new Array();
  for(let i = 0; i < map.row; i++){
    meshBoard[i] = new Array();
    for(let j = 0; j < map.col; j++){
      let file = './assets/space_bits/gltf/terrain_low.gltf';
      switch (map.data[i][j].cat) {
        case 1:
          file = './assets/space_bits/gltf/terrain_low.gltf';
          break;
        case 2:
          file = './assets/space_bits/gltf/terrain_low_curved.gltf';
          break;
        case 3:
          file = './assets/space_bits/gltf/terrain_slope.gltf';
          break;
        case 4:
          file = './assets/space_bits/gltf/terrain_slope_outer_corner.gltf';
          break;
        case 5:
          file = './assets/space_bits/gltf/terrain_slope_inner_corner.gltf';
          break;
        default:
          break;
      }

      loader.load(file,(gltf)=>{     //Loads everything
        meshBoard[i][j] = gltf.scene.children[0];
        meshBoard[i][j].position.set((j-5)*2, 0, (i-5)*2);
        meshBoard[i][j].rotateY(Math.PI*0.5*map.data[i][j].rot);
        meshBoard[i][j].row = i;
        meshBoard[i][j].col = j;
        scene.add(meshBoard[i][j]);
      });
    }
  }


  dl.position.set((map.col*2*0.5) + 80, 80, (map.row*2*0.5) + 0);

  camera.position.set((map.col*2*0.5) + 20, 20, (map.row*2*0.5) + 10);
  camera.lookAt((map.col*2*0.5), 0, (map.row*2*0.5));
  
  eventListener = document.addEventListener("mousedown", selectBuild);
  //addEventListener("keydown", build);
}

/**
 * Anima la scena e la renderizza
 */
function animate(){
    let dt = clock.getDelta();
    controls.update();
    renderer.clear();
    renderer.render(scene, camera);
    renderer.render(hudScene, cameraHud);
}



function onMouseDown(event) {
  //coordinate del mouse rispetto allo schermo
  const mouseX = (event.clientX / window.innerWidth) * 2 - 1;
  const mouseY = -(event.clientY / (document.getElementsByTagName("canvas")[0].clientHeight)) * 2 + 1.1;
  //vettore per rappresentare il mouse
  const mouseVector = new THREE.Vector3(mouseX, mouseY, 0);

  raycaster.setFromCamera(mouseVector, camera);
  const intersects = raycaster.intersectObjects(scene.children);

  if (intersects.length > 0) {
    intersects[0].object.material.color.r = 255;
    intersects[0].object.material.color.g = 255;

    if(oldIntersects != null && oldIntersects!=intersects[0]){
      oldIntersects.object.material.color.r = 1;
      oldIntersects.object.material.color.g = 1;
    }
    oldIntersects = intersects[0];

    let row = intersects[0].object.row;
    let col = intersects[0].object.col;
    row = row.toString();
    col = col.toString();
    position = col + row;
    position = parseInt(position);
    setTimeout(()=>{
      build(position);
    }, 500);
  }
}

function selectBuild(){
  const mouseX = (event.clientX / window.innerWidth) * 2 - 1;
  const mouseY = -(event.clientY / (document.getElementsByTagName("canvas")[0].clientHeight)) * 2 + 1.1;
  //vettore per rappresentare il mouse
  const mouseVector = new THREE.Vector3(mouseX, mouseY, 0);

  raycaster.setFromCamera(mouseVector, cameraHud);
  const intersects = raycaster.intersectObjects(hudScene.children);

  if (intersects.length > 0 && intersects[0].object.name != "") {
      intersects[0].object.material.color.r = 255;
      intersects[0].object.material.color.g = 255;
      selection = intersects[0];
    }
  if(oldSelectIntersects != null && oldSelectIntersects!=intersects[0] && oldSelectIntersects.object.name != ""){
    oldSelectIntersects.object.material.color.r = 1;
    oldSelectIntersects.object.material.color.g = 1;
    }
    oldSelectIntersects = intersects[0];
    eventListener = document.addEventListener("mousedown", onMouseDown);
}

async function build(intPosition){

  let id = 0;
  if(selection != null){
    if(selection.object.parent.code != null){
      id = selection.object.parent.code;
    }
    else if(selection.object.parent.parent.code){
      id = selection.object.parent.parent.code;
    }

    let data = {
      id: id,
      position: intPosition
    };

    let formData = new FormData();
    formData.append("data", JSON.stringify(data));
    formData.append("player",JSON.stringify(player));

    let res = await fetch("./api/buildingscity_add.php",{
      method:"POST",
      body: formData
    });
    res = await res.json();
    getCityData();
    oldIntersects.object.material.color.r = 1;
    oldIntersects.object.material.color.g = 1;

    if(res.code == 0){
        alert("Errore");
    }
    else if(res.code == 2){
      alert("Posizione occupata");
    }
    else if(res.code == 3){
      alert("Risorse insufficienti");
    }
    else{
      resource = await fetch("./api/cityresources_get.php");
      resource = await resource.json();
      document.getElementById("risorse").innerHTML = resource[0].name+": "+resource[0].qta+"<br>"+resource[1].name+": "+resource[1].qta+"<br>"+resource[2].name+": "+resource[2].qta;
      alert("Edificio aggiunto");
    }
    selection = null;
}
}

/****************************************************/
/*               LETTURA DATI GIOCATORE             */
/****************************************************/

let player = null;

async function getPlayerData(){

    let res = await fetch("./api/player_get.php",{
        method: "POST", /*tipo di richiesta*/
    });

    player = await res.json();

    if(player ==  null){
        window.location.href = "./login.html";
    }

    document.getElementById("welcome_message").innerHTML = "Bentornato " + player.nickname;
}

async function getCityData(){
  let res = await fetch("./api/buildingscity_get.php");

  buildings = await res.json();


  let loader = new GLTFLoader();

  for (let i = 0; i < buildings.length; i++){
    let b = buildings[i];
    loader.load("./" + b.modello3D,(gltf)=>{  //Loads everything
      //carica la mesh
      let mesh = gltf.scene.children[0];
      mesh.code = b.edificioID;
      //Calcola la posizione nella griglia tridimensionale
      let p = Math.floor(b.posizione / 100); //piano dell'oggetto
      let r = Math.floor(b.posizione % 100 / 10); //la colonna dell'oggetto
      let c = (b.posizione % 100) % 10; //la colonna dell'oggetto
      //posiziona l'oggetto
      mesh.position.set((r-5)*2,p*0.5,(c-5)*2);
      //aggiunge alla scena
      scene.add(mesh);
    });
  }
}




async function updateResources(){
  let res = await fetch("./api/farmerbuildings_get.php");

  res = await res.json();

  for(let i = 0; i < res.length; i++){
      let formData = new FormData();
      formData.append("data", JSON.stringify(res[i]));
      let res2 = await fetch("./api/updateResources.php",{
        method: "POST",
        body: formData
      });
      res2 = await res2.text();
  }

  resource = await fetch("./api/cityresources_get.php");
  resource = await resource.json();
  document.getElementById("risorse").innerHTML = resource[0].name+": "+resource[0].qta+"<br>"+resource[1].name+": "+resource[1].qta+"<br>"+resource[2].name+": "+resource[2].qta;
  
}

async function getHudElements(){
  let res = await fetch("./api/buildings_get.php");

  res = await res.json();
  resource = await fetch("./api/cityresources_get.php");
  resource = await resource.json();
  
  let hud = new Hud(res,resource);
  hud.position.set(-750,375,0);
  hudScene.add(hud);
  document.getElementById("edifici").innerHTML = "Edifici disponibili:";
}


//window.onload = initScene;
document.getElementById("bPlay").addEventListener("click", ()=>setTimeout(initScene, 100), false);
getPlayerData();