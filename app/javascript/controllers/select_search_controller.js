import { Controller } from "@hotwired/stimulus"
import { get } from '@rails/request.js'

export default class extends Controller {
  initialize() {
    this.id = this.element.getAttribute('id')
    this.multiple = this.element.getAttribute('ror-multiple')
    try {
      this.rorScope = JSON.parse(this.element.getAttribute('ror-scope'))
    } catch(e) {
      this.rorScope = {}
    }
    this.onChange = this.debounce(this.onChange.bind(this), 300)
  }
 
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
        ...this.rorScope,
      },
      responseKind: 'turbo-stream'
    })
  }

  onRemove(e) {
    const value = e.target.getAttribute('value');
    this.element
      .querySelector(`.js__selected-user[value="${value}"]`)
      .remove();
  }

  onClick(e) {
    get(`/users/selected_user_search`, {
      query: {
        id: e.target.getAttribute('value'),
        element_id: this.id,
      },
      responseKind: 'turbo-stream'
    })
  }
}