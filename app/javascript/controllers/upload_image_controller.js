import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log('connected upload image')
  }

  updateTagImage(event) {
    const file = event.target.files[0];
    const reader = new FileReader();
  
    reader.onload = function (event) {
      const imageUrl = event.target.result;
      document.getElementById('upload-image__preview').src = imageUrl
    };
  
    reader.readAsDataURL(file);

    document.getElementById('upload-image__caption').classList.remove('hidden')
  }
}