import { Controller } from "@hotwired/stimulus"
import MicroModal from 'micromodal';

export default class extends Controller {
  connect() {
    console.log('connected modal')
  }

  open() {
    MicroModal.show('form-modal')
  }

  close(event) {
    if (event.detail.success) {
      MicroModal.close('form-modal')
    }
  }
}