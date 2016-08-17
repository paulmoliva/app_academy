'use strict';

 function printChildren () {
   console.log(arguments[0] + '\'s children are: ');
  for(let i = 1; i < arguments.length; i++)
  console.log(arguments[i]);
}

//printChildren('bob',1,4,6,7,8,9,'larry');

function addThree(a, b, c) {
  return a + b + c;
}
let arr = [1,2,3];
console.log(addThree(...arr));


function dinnerTonightIs(food = 'pizza') {
  console.log('Dinnner tonight is ' + food);
}

dinnerTonightIs('tacos');
dinnerTonightIs();
