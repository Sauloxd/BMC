import Controller from "./base_controller"

export default class extends Controller {
  SIDEBAR_ID = 'global-navigation-sidebar'
  BACKDROP_ID = 'global-navigation-sidebar-backdrop'
  
  open() {
    this.#sidebar().open()
    this.#backdrop().create()
  }

  close() {
    this.#sidebar().close()
    this.#backdrop().remove()
  }

  #sidebar() {
    const sidebar = {
      reload: () => sidebar.ref = document.getElementById(this.SIDEBAR_ID),
      close: () => sidebar.ref.classList.add('-translate-x-full'),
      open: () => sidebar.ref.classList.remove('-translate-x-full'),
      ref: null,
    }

    sidebar.reload();

    return sidebar
  }

  #backdrop() {
    const backdrop = {
      reload: () => backdrop.ref = document.getElementById(this.BACKDROP_ID),
      create: () => {
        const newBackdrop = document.createElement("div");
        newBackdrop.id = this.BACKDROP_ID
        newBackdrop.setAttribute('data-action', 'click->global-navigation-sidebar#close')
        newBackdrop.className = "bg-gray-900 bg-opacity-50 dark:bg-opacity-80 fixed inset-0 z-30"
        backdrop.ref = newBackdrop
        document.body.appendChild(newBackdrop)
      },
      remove: () => backdrop.ref.remove(),
      ref: null
    }

    backdrop.reload()

    return backdrop
  }

}