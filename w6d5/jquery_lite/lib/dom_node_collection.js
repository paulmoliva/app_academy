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
