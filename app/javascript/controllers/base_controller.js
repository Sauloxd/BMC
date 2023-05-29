import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  query_id(selector) {
    // https://learn.jquery.com/using-jquery-core/faq/how-do-i-select-an-element-by-an-id-that-has-characters-used-in-css-notation/

    return selector.replace( /(:|\.|\[|\]|,|=|@)/g, "\\$1" )
  }
}