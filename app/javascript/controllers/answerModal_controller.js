import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    // 解答時のモーダル表示
    document.getElementById("my_modal_4").showModal();
  }
}
