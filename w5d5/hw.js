'use strict';

const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function askForTeaAndBiscuits(){
  reader.question('Would you like some tea?', (res) => {
    console.log(`You said ${res}`);
    reader.question('Would you likke some biscuits?', (bisRes) => {
      console.log(`You said ${bisRes}`);
      console.log(`You said ${res} to tea and ${bisRes} to biscuits!`);
      reader.close();
      });
    });
  }

askForTeaAndBiscuits();
