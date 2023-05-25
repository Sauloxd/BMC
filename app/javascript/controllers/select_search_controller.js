import { Controller } from "@hotwired/stimulus"
import { get } from '@rails/request.js'

export default class extends Controller {
  initialize() {
    console.log('initialize?')
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
    const selectedUsers = document
      .getElementById('js__selected-users-container')
      .querySelectorAll('.js-selected-users')

    const excludeIds = Array.from(selectedUsers).map(u => u.getAttribute('value'))

    get('/users/select_search', {
      query: {
        query: e.target.value,
        excludes: excludeIds,
      },
      responseKind: 'turbo-stream'
    })
  }

  onClick(e) {
    get(`/users/selected_user_search?id=${e.target.getAttribute('value')}`, {
      responseKind: 'turbo-stream'
    })
  }

  onBlur(e) {
    get(`/users/select_search?state=reset`, {
      responseKind: 'turbo-stream'
    })
  }
}