const DOMNodeCollection = require('./dom_node_collection.js');

// THE CORE FUNCTION.
window.$l = function fn(arg){

  if (arg instanceof HTMLElement) {
    return new DOMNodeCollection([arg]);
  } else {
    return new DOMNodeCollection(Array.from(document.querySelectorAll(arg)));
  }

};
