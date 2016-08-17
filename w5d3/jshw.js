function madLib(verb, adjective, noun) {
  return "We shall " + verb + " the " + adjective + " " + noun + ".";
}

//console.log(madLib('eat', 'smelly', 'cheese'));

function isOdd(num){
  if (num % 2 === 0) {
    return false;}
  else {
    return true;}
}

//console.log(isOdd(3));

function yell(string){
  return string.toUpperCase();
}
console.log(yell("hi world"));

function isSubstring(searchString, substring) {
  var i = searchString.indexOf(substring);
  if (i > 0){
    return true;
  }
  else{
    return false;
  }
}

console.log(isSubstring('cheese', 'eese'));
