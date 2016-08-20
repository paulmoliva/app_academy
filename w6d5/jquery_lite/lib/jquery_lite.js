/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const DOMNodeCollection = __webpack_require__(1);

	// THE CORE FUNCTION.
	window.$l = function fn(arg){

	  if (arg instanceof HTMLElement) {
	    return new DOMNodeCollection([arg]);
	  } else {
	    return new DOMNodeCollection(Array.from(document.querySelectorAll(arg)));
	  }

	};


/***/ },
/* 1 */
/***/ function(module, exports) {

	class DOMNodeCollection {
	  constructor(htmlEls){
	    this.nodeList = htmlEls;
	  }

	  html (str) {
	    if (str){
	      this.nodeList.forEach((node) => {
	        node.innerHTML = str;
	      });
	    } else {
	      return this.nodeList[0].innerHTML;
	    }
	  }

	  empty () {
	    this.nodeList.forEach( (node) => {
	      let children = Array.from(node.childNodes);
	      children.forEach((childNode) => {
	        childNode.innerHTML = '';
	        childNode.outerHTML = '';
	      })
	    })
	  }

	  append(el) {
	    if (el instanceof DOMNodeCollection) {
	      this.nodeList.forEach ( (node) => {
	        let nodeList = Array.from(el.nodeList);
	        nodeList.forEach( (element) => {
	          // debugger;
	          node.innerHTML += element.outerHTML;
	        })
	      })
	    } else if (el instanceof HTMLElement) {
	      this.nodeList.forEach ( (node) => {
	        node.innerHTML += el.outerHTML;
	      })
	    } else if (typeof el === "string") {
	      this.nodeList.forEach ( (node) => {
	        node.innerHTML += el;
	      })
	    }
	  }

	}

	module.exports = DOMNodeCollection;


/***/ }
/******/ ]);