import * as THREE from 'three';
import {GLTFLoader} from 'three/addons/loaders/GLTFLoader.js';

class Hud extends THREE.Group{
    constructor(buildings,resource) {
        super();
        document.getElementById("risorse").innerHTML = resource[0].name+": "+resource[0].qta+"<br>"+resource[1].name+": "+resource[1].qta+"<br>"+resource[2].name+": "+resource[2].qta;
        this.loader = new GLTFLoader();
        this.geometry = new THREE.BoxGeometry( 4000, 200, -1000 );
        this.material = new THREE.MeshBasicMaterial( { color: 0x663300 } ); 
        this.box = new THREE.Mesh( this.geometry, this.material );
        this.add(this.box);

        this.l = new THREE.DirectionalLight(0xFFFFFF, 10);
        this.l.position.set(1000,-100,-200);
        this.l.lookAt(0,0,0);
        this.add(this.l);
        for(let i = 0; i < buildings.length; i++){
            this.loader.load(buildings[i].modello3D,    
            (gltf) => {
                this.build = gltf.scene;
                this.build.scale.set(30,30,30);
                this.build.position.set(1650+100*(-i),-90,200);
                this.build.code = buildings[i].id;
                this.build.rotateY(Math.PI/6);
                this.add(this.build);
            }
        );
        }
        
    }


}

export { Hud }
