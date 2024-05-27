import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    document.addEventListener("turbo:submit-start", () => {
      this.showModal();
    });

    document.addEventListener("turbo:submit-end", () => {
      this.hideModal();
    });
    document.addEventListener("turbo:render", () => {
      this.switchForm();
    });
  }

  showModal() {
    document.getElementById("modal").classList.remove("hidden");
  }

  hideModal() {
    document.getElementById("modal").classList.add("hidden");
  }

  switchForm() {
    const aiGenerateButton = document.getElementById("ai_generate_button");
    const imagePostButton = document.getElementById("image_post_button");
    const aiGenerateForm = document.getElementById("ai_generate_form");
    const imagePostForm = document.getElementById("image_post_form");

    const toggleFormVisibility = (
      buttonToShow,
      buttonToHide,
      formToShow,
      formToHide
    ) => {
      buttonToShow.style.display = "block";
      buttonToHide.style.display = "none";
      formToShow.style.display = "block";
      formToHide.style.display = "none";
    };

    imagePostButton.addEventListener("click", () => {
      toggleFormVisibility(
        aiGenerateButton,
        imagePostButton,
        imagePostForm,
        aiGenerateForm
      );
    });

    aiGenerateButton.addEventListener("click", () => {
      toggleFormVisibility(
        imagePostButton,
        aiGenerateButton,
        aiGenerateForm,
        imagePostForm
      );
    });
  }
}
