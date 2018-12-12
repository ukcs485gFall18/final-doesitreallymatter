const admin = require('firebase-admin');
const serviceAccount = require("./service-key.json");

const data = require("./restaurantdata.json");
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    apiKey: "AIzaSyB7noOPKmkZpkcqtGRDO5oajgp6YG0Q77Y",
    authDomain: "restaurant-royale.firebaseapp.com",
    databaseURL: "https://restaurant-royale.firebaseio.com",
    projectId: "restaurant-royale",
    storageBucket: "restaurant-royale.appspot.com",
    messagingSenderId: "141381234165"
});
var db= admin.firestore();
db.settings({timestampsInSnapshots: true});
data.forEach(restaurant =>
{
    var latstring = restaurant.Location.split(", ")[0];
    var lat = parseFloat(latstring);
    var lonstring = restaurant.Location.split(", ")[1];
    var lon = parseFloat(lonstring);
    var foodtype = restaurant.Type.split(",");
    console.log(foodtype);
    /* var typearray=[]
    for(i =0; i < foodtype.length; i++)
    {
        typearray.push(foodtype[i]);
    } */
    
    // Add a new document in collection "cities"
    console.log(restaurant);
    db.collection("restaurants").doc().set({

        name: restaurant.Name,
        location: new admin.firestore.GeoPoint(lat, lon),
        type: foodtype
    })
    .then(function() {
        console.log("Document successfully written!");
    })
    .catch(function(error) {
        console.error("Error writing document: ", error);
    });  
});

/* data && Object.keys(data).forEach(key => {
    const nestedContent = data[key];

    if (typeof nestedContent === "object") {
        Object.keys(nestedContent).forEach(docTitle => {
            admin.firestore()
                .collection(key)
                .doc(docTitle)
                .set(nestedContent[docTitle])
                .then((res) => {
                    console.log("Document successfully written!");
                })
                .catch((error) => {
                    console.error("Error writing document: ", error);
                });
        });
    }
}); */