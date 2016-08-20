class Router {
  constructor (node, routes) {
    this.node = node;
    this.routes = routes;
  }

  start () {
    this.render();
    window.addEventListener("hashchange", () => {
      this.render();
    });
  }

  render () {
    this.node.innerHTML = '';
    let component = this.activeRoute();
    if (!component){
      this.node.innerHTML = "";
    } else{
      this.node.innerHTML = "";
      let el = component.render();
      this.node.appendChild(el);
    }
  }

  activeRoute() {
    if (window.location.hash === "") {
      return "";
    } else {
      return this.routes[window.location.hash.slice(1)];
    }
  }
}

module.exports = Router;
