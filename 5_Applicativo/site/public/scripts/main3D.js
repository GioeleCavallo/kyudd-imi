import * as THREE from 'three';
import { GLTFLoader } from 'three/addons/loaders/GLTFLoader.js';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';


const ObjectPath = "models/scuola.gltf";

const raycaster = new THREE.Raycaster();


const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);



let object;

let controls;

const loader = new GLTFLoader();


//Load the file
loader.load(
  ObjectPath,
  function (gltf) { 

    //If the file is loaded, add it to the scene
    object = gltf.scene;
    
    object.position.set(-32,0,-8);
    console.log(object);
    
    scene.add(object);
    //console.log(object);
  },
  function(xhr){
      // print loading progress
      console.log((xhr.loaded / xhr.total * 100) + " % loaded")
  },
  function(error){
      console.log(error)
  }
);


//Instantiate a new renderer and set its size
const renderer = new THREE.WebGLRenderer({ alpha: true , antialias: true }); //Alpha: true allows for the transparent background
renderer.setSize(window.innerWidth, window.innerHeight);
//4ECDC4renderer.setClearColor(0x097969);
renderer.setClearColor(0x4ECDC4);
renderer.outputEncoding = THREE.sRGBEncoding;
//Add the renderer to the DOM
document.getElementById("main").appendChild(renderer.domElement);

//Set how far the camera will be from the 3D model
camera.position.z = 25;
camera.position.y = 25;
camera.position.x = -25;


// Beginning of the statement of the lights //

let directionalLight = new THREE.DirectionalLight(0xffffff, 1);
console.log(directionalLight);
directionalLight.position.set(10, 10, 10);
directionalLight.castShadow = false;
scene.add(directionalLight);

let directionalLight1 = new THREE.DirectionalLight(0xffffff, 1);
directionalLight1.position.set(1, -10, 10);
directionalLight1.castShadow = false;
scene.add(directionalLight1);

let directionalLight2 = new THREE.DirectionalLight(0xffffff, 1);
directionalLight2.position.set(-10, 10, 1);
directionalLight2.castShadow = false;
scene.add(directionalLight2);

let directionalLight3 = new THREE.DirectionalLight(0xffffff, 1);
directionalLight2.position.set(1, 1, -10);
directionalLight2.castShadow = false;
scene.add(directionalLight3);

let directionalLight4 = new THREE.DirectionalLight(0xffffff, 1);
directionalLight2.position.set(-10, -10, -10);
directionalLight2.castShadow = false;
scene.add(directionalLight4);

var light = new THREE.PointLight( 0xffffff, 0.9 );
camera.add( light );

let hlight = new THREE.AmbientLight(0xff0000, 1);
scene.add(hlight);

// End of the statement of the lights //


controls = new OrbitControls(camera, renderer.domElement);
controls.update();

// Render the scene
function animate() {
  requestAnimationFrame(animate);
  
  renderer.render(scene, camera);
}

const pointer = new THREE.Vector2();

function onPointerMove( event ) {

	// calculate pointer position in normalized device coordinates
	// (-1 to +1) for both components
  event.preventDefault();
  const renderBlock = document.querySelector('#main');
  let canvasBounds = renderer.getContext().canvas.getBoundingClientRect();
  
  pointer.x = ( ( event.clientX - canvasBounds.left ) / ( canvasBounds.right - canvasBounds.left ) ) * 2 - 1;
  pointer.y = - ( ( event.clientY - canvasBounds.top ) / ( canvasBounds.bottom - canvasBounds.top) ) * 2 + 1;
 

  render();
}

function render() {

	// update the picking ray with the camera and pointer position
	raycaster.setFromCamera( pointer, camera );

	// calculate objects intersecting the picking ray
	const intersects = raycaster.intersectObjects( scene.children );
  console.log(intersects);
	//intersects[0].object.material.color.set( 0xff0000 );
  if(intersects.length > 0){
    
    console.log(pointer);
    $.get(`/classroom/exists/${intersects[0].object.name}`, function(data, status){
      if(data.length > 0){
        $("#class-name").text(`Aula ${intersects[0].object.name}`);
      }
      
    });
    
  }
  
	renderer.render( scene, camera );

}

window.addEventListener( 'pointermove', onPointerMove );

window.requestAnimationFrame(render);



animate();

function executeAsync(func) {
  setInterval(func, 500);
}
executeAsync(()  => {
 
  // fetch data
  $.get("/classrooms", function(data, status){
    console.log(data);
    let json = data;  
    for (const key in json){
      try {
        if(json.hasOwnProperty(key)){
          let window = json[key];

          // Updating windows color
          let value = window.stato == 1 ? 0xff0000: 0x00ff00;

          let material = new THREE.MeshPhongMaterial( { color: value } );
          object.getObjectByName(window.aula).material = material;
          object.getObjectByName(window.aula).callback = function() { console.log( this.name ); }

        }
      }catch(e){}
    }  

  });
});


/*

// Inserting data from the model.

console.log("OBJ:");
console.log(object.children);
object.children.forEach(element => {
  console.log(`insert into FINESTRA(numero,aula,sensore_id) VALUES(0,"${element.name}","00AD");`);
  console.log(`insert into STATO(timestamp,stato,finestra_numero,finestra_aula,sensore_id) VALUES('${formatDate(new Date())}',${Math.round(Math.random())},0,"${element.name}","00AD");`);

});


function padTo2Digits(num) {
  return num.toString().padStart(2, '0');
}

function formatDate(date) {
  return (
    [
      date.getFullYear(),
      padTo2Digits(date.getMonth() + 1),
      padTo2Digits(date.getDate()),
    ].join('-') +
    ' ' +
    [
      padTo2Digits(date.getHours()),
      padTo2Digits(date.getMinutes()),
      padTo2Digits(date.getSeconds()),
    ].join(':')
  );
}
*/

  