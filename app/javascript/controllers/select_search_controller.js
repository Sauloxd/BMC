import Controller from "controllers/base_controller"
import { get } from '@rails/request.js'

export default class extends Controller {
  initialize() {}
 
  debounce(fn, wait) {
    let timeout;
    return function() {
      const context = this;
      const args = arguments;
      
      clearTimeout(timeout);
          
      timeout = setTimeout(fn.bind(context, ...args), wait);
    };
  }

  connect() {
    console.log('connected selectSearch')
    this.id = this.element.getAttribute('id')
    this.multiple = this.element.getAttribute('ror-multiple')
    this.label = this.element.getAttribute('ror-label')
    this.rorScope = this.element.getAttribute('ror-scope')
    this.onChange = this.debounce(this.onChange.bind(this), 300)
  }

  onChange(e) {
    if(e.target.value === "") return;

    const selectedUsers = this.element.querySelectorAll('.js__selected-user')
    const excludeIds = Array.from(selectedUsers).map(u => u.getAttribute('value'))
    get('/users/select_search', {
      query: {
        query: e.target.value,
        excludes: excludeIds,
        element_id: this.id,
        multiple: this.multiple || false,
        label: this.label,
        scope: this.rorScope,
      },
      responseKind: 'turbo-stream'
    })
  }

  onRemove(e) {
    const value = e.target.getAttribute('value');
    this.element
      .querySelector(`.js__selected-user[value="${value}"]`)
      .remove();

    this.element
      .querySelector(this.query_id(`#user-select-search__${this.id}`))
      .classList
      .remove('hidden')
    
    this.element
      .querySelector(this.query_id(`#user-select-search__${this.id}`))
      .focus()
  }

  onClick(e) {
    get(`/users/selected_user_search`, {
      query: {
        id: e.target.getAttribute('value'),
        element_id: this.id,
        multiple: this.multiple,
        label: this.label,
        scope: this.rorScope,
      },
      responseKind: 'turbo-stream'
    })
  }
}