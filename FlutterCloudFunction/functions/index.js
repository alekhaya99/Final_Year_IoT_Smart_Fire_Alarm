const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

exports.helloWorld = functions.database.ref('FIRE').onUpdate(evt => {
    const payload = {
        notification:{
            title : 'Emergency',
            body : 'There is a possibility of a Fire',
            badge : '1',
            sound : 'default'
        }
    };

    return admin.database().ref('fcm-token').once('value').then(allToken => {
        if(allToken.val()){
            console.log('token available');
            const token = Object.keys(allToken.val());
            return admin.messaging().sendToDevice(token,payload);
        }else{
            console.log('No token available');
        }
    });
});